local S = core.get_mod_translator()

local function is_water(pos)
	local nn = core.get_node(pos).name
	return core.get_item_group(nn, "water") ~= 0
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return { x = x, y = y, z = z, }
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

--- Handles forward / backward / cruise-mode controls.
--- @param self table boat entity
--- @param ctrl table player control
--- @param dtime number
--- @param mod table `def.control_modifier`
local function update_speed(self, ctrl, dtime, mod)
	if ctrl.up and ctrl.down then
		if not self.auto then
			self.auto = true
			core.chat_send_player(self.driver, S('Boat cruise mode on'))
		end
	elseif ctrl.down then
		self.v = self.v - dtime * mod.down
		if self.auto then
			self.auto = false
			core.chat_send_player(self.driver, S('Boat cruise mode off'))
		end
	elseif ctrl.up or self.auto then
		self.v = self.v + dtime * mod.up
	end
end

--- Handles left / right controls (steering is inverted while moving backward).
--- @param self table boat entity
--- @param ctrl table player control
--- @param dtime number
--- @param mod table `def.control_modifier`
local function update_steering(self, ctrl, dtime, mod)
	local direction = ctrl.left and 1 or (ctrl.right and -1 or 0)
	if direction == 0 then
		return
	end
	if self.v < -0.001 then
		direction = -direction
	end
	self.object:set_yaw(self.object:get_yaw() + direction * dtime * mod.left_right)
end

--- @param self table boat entity
--- @param dtime number
--- @param mod table `def.control_modifier`
local function apply_driver_control(self, dtime, mod)
	local driver_objref = core.get_player_by_name(self.driver)
	if not driver_objref then
		return
	end

	local ctrl = driver_objref:get_player_control()
	update_speed(self, ctrl, dtime, mod)
	update_steering(self, ctrl, dtime, mod)
end

--- @param self table boat entity
--- @return boolean
local function is_idle(self)
	local velo = self.object:get_velocity()

	return not self.driver and self.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0
end

--- @param self table boat entity
--- @param dtime number
local function apply_drag(self, dtime)
	-- We need to preserve velocity sign to properly apply drag force
	-- while moving backward
	local drag = dtime * math.sign(self.v) * (0.01 + 0.0796 * self.v * self.v)
	-- If drag is larger than velocity, then stop horizontal movement
	if math.abs(self.v) <= math.abs(drag) then
		self.v = 0
	else
		self.v = self.v - drag
	end
end

--- Motion when there is no water under the boat: on the ground or in the air.
--- @param self table boat entity
--- @param pos table position under the boat
--- @return table, table new velocity, new acceleration
local function get_non_water_motion(self, pos)
	local new_acce
	local nodedef = core.registered_nodes[core.get_node(pos).name]
	if (not nodedef) or nodedef.walkable then
		self.v = 0
		new_acce = { x = 0, y = 1, z = 0, }
	else
		new_acce = { x = 0, y = -9.8, z = 0, } -- freefall in air -9.81
	end
	local new_velo = get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y)
	self.object:set_pos(self.object:get_pos())

	return new_velo, new_acce
end

--- Motion when the boat is fully under water.
--- @param self table boat entity
--- @param vert_acce table `def.vertical_acceleration`
--- @return table, table new velocity, new acceleration
local function get_submerged_motion(self, vert_acce)
	local new_acce = { x = 0, y = 0, z = 0, }
	local y = self.object:get_velocity().y
	if y >= vert_acce.fast_condition then
		y = vert_acce.fast_up
	elseif y < 0 then
		new_acce = { x = 0, y = vert_acce.down, z = 0, }
	else
		new_acce = { x = 0, y = vert_acce.up, z = 0, }
	end
	local new_velo = get_velocity(self.v, self.object:get_yaw(), y)
	self.object:set_pos(self.object:get_pos())

	return new_velo, new_acce
end

--- Motion when the boat floats on the water surface.
--- @param self table boat entity
--- @return table, table new velocity, new acceleration
local function get_surface_motion(self)
	local new_acce = { x = 0, y = 0, z = 0, }
	local new_velo
	if math.abs(self.object:get_velocity().y) < 1 then
		local pos = self.object:get_pos()
		pos.y = math.floor(pos.y) + 0.5
		self.object:set_pos(pos)
		new_velo = get_velocity(self.v, self.object:get_yaw(), 0)
	else
		new_velo = get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y)
		self.object:set_pos(self.object:get_pos())
	end

	return new_velo, new_acce
end

--- @param self table boat entity
--- @param def table boat definition
--- @return table, table new velocity, new acceleration
local function get_motion(self, def)
	local pos = self.object:get_pos()
	pos.y = pos.y - 0.5
	if not is_water(pos) then
		return get_non_water_motion(self, pos)
	end

	pos.y = pos.y + 1
	if is_water(pos) then
		return get_submerged_motion(self, def.vertical_acceleration)
	end

	return get_surface_motion(self)
end

--- Delegates `on_place` to the pointed node's `on_rightclick` (unless the player is sneaking).
--- @return ItemStack|nil nil if the node has no `on_rightclick` or the player is sneaking
local function try_node_on_rightclick(itemstack, placer, pointed_thing)
	local under  = pointed_thing.under
	local node   = core.get_node(under)
	local udef   = core.registered_nodes[node.name]
	local sneaks = placer and placer:is_player() and placer:get_player_control().sneak
	if udef and udef.on_rightclick and not sneaks then
		return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
	end
end

--- @param itemstack ItemStack
--- @param placer ObjectRef|nil
--- @param pointed_thing table
--- @param boat_name string
local function place_boat(itemstack, placer, pointed_thing, boat_name)
	pointed_thing.under.y = pointed_thing.under.y + 0.5
	local boat_ent = core.add_entity(pointed_thing.under, boat_name)
	if not boat_ent then
		return
	end

	if placer then
		boat_ent:set_yaw(placer:get_look_horizontal())
	end
	local player_name = placer and placer:get_player_name() or ''
	if not core.is_creative_enabled(player_name) then
		itemstack:take_item()
	end
end


lord_boats = {}

function lord_boats.register_boat(boat_name, def)
	local boat_entity = {
		initial_properties = def.initial_properties,
		driver = nil,
		v = 0,
		last_v = 0,
		removed = false,
		auto = false,
		stepcount = 0,
		unattended = 0
	}

	function boat_entity.on_rightclick(self, clicker)
		if not clicker or not clicker:is_player() then
			return
		end
		local name = clicker:get_player_name()
		if self.driver and name == self.driver then
			self.driver = nil
			self.auto = false
			clicker:set_detach()
			player_api.player_attached[name] = false
			player_api.set_animation(clicker, "stand" , 30)
			local pos = clicker:get_pos()
			pos = {
				x = pos.x + def.driver_shift.x,
				y = pos.y + def.driver_shift.y,
				z = pos.z + def.driver_shift.z
			}
			core.after(0.1, function()
				clicker:set_pos(pos)
			end)
		elseif not self.driver then
			local attach = clicker:get_attach()
			if attach and attach:get_luaentity() then
				local luaentity = attach:get_luaentity()
				if luaentity.driver then
					luaentity.driver = nil
				end
				clicker:set_detach()
			end
			self.driver = name
			clicker:set_attach(self.object, "",
				def.driver_bone_position, { x = 0, y = 0, z = 0, })
			player_api.player_attached[name] = true
			core.after(0.2, function()
				player_api.set_animation(clicker, "sit" , 30)
			end)
			clicker:set_look_horizontal(self.object:get_yaw())
		end
	end

	function boat_entity.on_detach_child(self, child)
		self.driver = nil
		self.auto = false
	end

	function boat_entity.on_activate(self, staticdata, dtime_s)
		self.object:set_armor_groups({ immortal = 1, fleshy = 100, })
		if staticdata then
			self.v = tonumber(staticdata)
		end
		self.last_v = self.v
	end

	function boat_entity.get_staticdata(self)
		return tostring(self.v)
	end

	function boat_entity.on_punch(self, puncher)
		if not puncher or not puncher:is_player() or self.removed then
			return
		end

		local name = puncher:get_player_name()
		if self.driver and name == self.driver then
			self.driver = nil
			puncher:set_detach()
			player_api.player_attached[name] = false
		end
		if not self.driver then
			self.removed = true
			local inv = puncher:get_inventory()
			if not core.is_creative_enabled(name)
					or not inv:contains_item("main", boat_name) then
				local leftover = inv:add_item("main", boat_name)
				-- if no room in inventory add a replacement boat to the world
				if not leftover:is_empty() then
					core.add_item(self.object:get_pos(), leftover)
				end
			end
			-- delay remove to ensure player is detached
			core.after(0.1, function()
				self.object:remove()
			end)
		end
	end

	function boat_entity.on_step(self, dtime)
		self.v = get_v(self.object:get_velocity()) * math.sign(self.v)
		if self.driver then
			apply_driver_control(self, dtime, def.control_modifier)
		end
		if is_idle(self) then
			self.object:set_pos(self.object:get_pos())
			return
		end
		apply_drag(self, dtime)

		local new_velo, new_acce = get_motion(self, def)
		self.object:set_velocity(new_velo)
		self.object:set_acceleration(new_acce)
	end

	core.register_entity(boat_name, boat_entity)

	core.register_craftitem(boat_name, {
		description = def.description,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		wield_scale = { x = 2, y = 2, z = 1, },
		liquids_pointable = true,
		groups = { flammable = 2, wooden = 1, },

		on_place = function(itemstack, placer, pointed_thing)
			local result = try_node_on_rightclick(itemstack, placer, pointed_thing)
			if result then
				return result
			end

			if pointed_thing.type == 'node' and is_water(pointed_thing.under) then
				place_boat(itemstack, placer, pointed_thing, boat_name)
			end

			return itemstack
		end,
	})

	core.register_craft({
		output = boat_name,
		recipe = def.recipe,
	})

	core.register_craft({
		type = "fuel",
		recipe = boat_name,
		burntime = def.fuel_burntime,
	})
end
