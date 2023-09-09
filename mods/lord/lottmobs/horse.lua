local SL = minetest.get_translator("lottmobs")

local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
		minetest.get_item_group(nn, "cracky") ~= 0 or
		minetest.get_item_group(nn, "choppy") ~= 0 or
		minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw) * v
	local z = math.sin(yaw) * v
	return { x = x, y = y, z = z }
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

--- @param entity luaentity|table
--- @param player Player
--- @return boolean
local function move_horse_to_inventory(entity, player)
	local horse_item = ItemStack(entity.name)
	horse_item:get_meta():set_int('hp', entity.object:get_hp())
	if not player:get_inventory():room_for_item("main", horse_item) then
		minetest.chat_send_player(
			player:get_player_name(),
			minetest.colorize("yellow", SL("Inventory is full!"))
		)
		return false
	end
	player:get_inventory():add_item("main", horse_item)
	entity.object:remove()

	return true
end

--- Tries to feed the horse `horse`(any riding entity) with a `item_stack`.
--- Ups the health points if this `horse` can eat this `item_stack`, decreases items in stack.
--- Possible food for horse and health points recovering configures by `feed` field in `register_horse()` func.
--- @param horse      luaentity|table
--- @param item_stack ItemStack
--- @return boolean true if horse was fed & hp was up.
local function feed_horse(horse, item_stack)
	local item_name = item_stack:get_name()

	if not item_name or horse.object:get_hp() == horse.hp_max or not horse.feed or not horse.feed[item_name] then
		return false
	end

	local hp = horse.object:get_hp() + tonumber(horse.feed[item_name])
	if hp > horse.hp_max then
		hp = horse.hp_max
	end
	horse.object:set_hp(hp)
	item_stack:take_item()

	return true
end

function lottmobs.register_horse(name, craftitem, horse)

	horse.makes_footstep_sound = true
	horse.hp_max = horse.hp_max or horse.hp or 10

	if craftitem ~= nil then

		craftitem.stack_max = 1

		--- @param itemstack ItemStack
		--- @param placer    Player
		--- @param pointed_thing pointed_thing
		--- @return ItemStack, Position|nil
		function craftitem.on_place(itemstack, placer, pointed_thing)
			-- Call on_rightclick if the pointed node defines it
			if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
				local n = core.get_node(pointed_thing.under)
				local nn = n.name
				if core.registered_nodes[nn] and core.registered_nodes[nn].on_rightclick then
					return
						core.registered_nodes[nn].on_rightclick(
							pointed_thing.under, n, placer, itemstack, pointed_thing
						) or itemstack,
						nil
				end
			end

			if not pointed_thing.above then
				return itemstack, nil
			end

			local pos_below  = vector.add(pointed_thing.above, vector.new(0, -1, 0))
			local node_below = minetest.get_node_or_nil(pos_below)
			local node_under_def = node_below and minetest.registered_nodes[node_below.name]
			local walkable = node_under_def and (node_under_def.walkable == nil or node_under_def.walkable == true)
			if not walkable then
				minetest.chat_send_player(
					placer:get_player_name(),
					minetest.colorize("yellow", SL("Can only be placed on a hard surface."))
				)
				return itemstack, nil
			end

			if not minetest.find_path(placer:get_pos(), pointed_thing.above, 1, 1, 3, "Dijkstra") then
				minetest.chat_send_player(
					placer:get_player_name(),
					minetest.colorize("yellow", SL("Sweetly far. Try to get closer."))
				)
				return itemstack, nil
			end

			local place_to = vector.copy(pointed_thing.above)
			place_to.y     = place_to.y - 0.5
			local entity = minetest.add_entity(place_to, name)
			if itemstack:get_meta():contains('hp') then
				entity:set_hp(itemstack:get_meta():get_int('hp') or horse.hp)
			end

			if not minetest.is_creative_enabled(placer) then
				itemstack:take_item()
			end

			return itemstack, pointed_thing.above
		end

		minetest.register_craftitem(name, craftitem)
	end

	function horse:set_animation(type)
		if not self.animation then
			return
		end
		if not self.current_animation then
			self.current_animation = ""
		end
		if type == "stand" and self.current_animation ~= "stand" then
			if
				self.animation.stand_start
				and self.animation.stand_end
				and self.animation.speed_normal
			then
				self.object:set_animation(
					{ x = self.animation.stand_start, y = self.animation.stand_end },
					self.animation.speed_normal * 0.6, 0
				)
				self.current_animation = "stand"
			end
		elseif type == "walk" and self.current_animation ~= "walk" then
			if
				self.animation.walk_start
				and self.animation.walk_end
				and self.animation.speed_normal
			then
				self.object:set_animation(
					{ x = self.animation.walk_start, y = self.animation.walk_end },
					self.animation.speed_normal * 3, 0
				)
				self.current_animation = "walk"
			end
		elseif type == "punch" and self.current_animation ~= "punch" then
			if
			self.animation.punch_start
				and self.animation.punch_end
				and self.animation.speed_normal
			then
				self.object:set_animation(
					{ x = self.animation.punch_start, y = self.animation.punch_end },
					self.animation.speed_normal * 3, 0
				)
				self.current_animation = "punch"
			end
		end
	end

	function horse:on_step(dtime)
		local p         = self.object:get_pos()
		p.y             = p.y - 0.1
		local on_ground = is_ground(p)

		self.v          = get_v(self.object:get_velocity()) * get_sign(self.v)

		-- driver controls
		if self.driver then
			local ctrl = self.driver:get_player_control()

			-- rotation (the faster we go, the less we rotate)
			if ctrl.left then
				self.object:set_yaw(
					self.object:get_yaw()
						+ 2 * (1.5 - math.abs(self.v / self.max_speed)) * math.pi / 90
						+ dtime * math.pi / 90
				)
			end
			if ctrl.right then
				self.object:set_yaw(
					self.object:get_yaw()
						- 2 * (1.5 - math.abs(self.v / self.max_speed)) * math.pi / 90
						- dtime * math.pi / 90)
			end
			-- jumping (only if on ground)
			if ctrl.jump and on_ground then
				local v = self.object:get_velocity()
				v.y     = (self.jump_speed or 3)
				self.object:set_velocity(v)
			end

			-- forwards/backwards
			if ctrl.up then
				self.v = self.v + self.forward_boost
			elseif ctrl.down then
				self.v = self.v - 0.3
			elseif on_ground then
				if math.abs(self.v) < 1 then
					self.v = 0
				else
					self.v = self.v * 0.8
				end
			end
		else
			if math.abs(self.v) < 1 then
				self.v = 0
			else
				self.v = self.v * 0.95
			end
		end

		-- show health  (for non driven & damaged)
		local tag = ""
		if not self.driver and self.object:get_hp() < self.hp then
			tag = self.object:get_hp() .. " / " .. self.hp
		end
		if (self.object:get_properties().nametag ~= tag) then -- only if changed (possible reduces network traffic)
			self.object:set_properties({ nametag = tag, nametag_color = "red" })
		end


		local underattack = self.underattack or false

		if self.v == 0 then
			if underattack ~= true then
				self.object:set_velocity({ x = 0, y = 0, z = 0 })
				self:set_animation("stand")
				return
			else
				self:set_animation("punch")
			end
		else
			self:set_animation("walk")
		end

		-- make sure we don't go past the limit
		if math.abs(self.v) > self.max_speed then
			self.v = self.max_speed * get_sign(self.v)
		end

		p   = self.object:get_pos()
		p.y = p.y + 1
		if not is_ground(p) then
			if minetest.registered_nodes[minetest.get_node(p).name].walkable then
				self.v = 0
			end
			self.object:set_acceleration({ x = 0, y = -10, z = 0 })
			self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y))
		else
			self.object:set_acceleration({ x = 0, y = 0, z = 0 })
			-- falling
			if math.abs(self.object:get_velocity().y) < 1 then
				local pos = self.object:get_pos()
				pos.y     = math.floor(pos.y) + 0.5
				self.object:set_pos(pos)
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), 0))
			else
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y))
			end
		end

		if self.object:get_velocity().y > 0.1 then
			local yaw = self.object:get_yaw()
			if self.drawtype == "side" then
				yaw = yaw + (math.pi / 2)
			end
			local x = math.sin(yaw) * -2
			local z = math.cos(yaw) * 2
			if minetest.get_item_group(minetest.get_node(self.object:get_pos()).name, "water") ~= 0 then
				self.object:set_acceleration({ x = x, y = 2, z = z })
			else
				self.object:set_acceleration({ x = x, y = -5, z = z })
			end
		else
			if minetest.get_item_group(minetest.get_node(self.object:get_pos()).name, "water") ~= 0 then
				self.object:set_acceleration({ x = 0, y = 2, z = 0 })
			else
				self.object:set_acceleration({ x = 0, y = -5, z = 0 })
			end
		end

	end

	--- @param clicker Player
	function horse:on_rightclick(clicker)
		local player = clicker:get_player_name()
		if not clicker or not clicker:is_player() then
			return
		end
		local wielded_item = clicker:get_wielded_item()
		if feed_horse(self, wielded_item) then
			clicker:set_wielded_item(wielded_item)
			return
		end

		if self.driver and clicker == self.driver then
			self.driver    = nil
			self.ridername = nil
			clicker:set_detach()
			player_api.player_attached[clicker:get_player_name()] = false
			if self.offset == true then
				clicker:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
			end
		elseif not self.driver and not player_api.player_attached[player] then

			for no = 1, #self.riders do -- who can drive
				if self.riders[no] == races.get_race_and_gender(player)[1] or
					clicker:get_inventory():get_stack("main", clicker:get_wield_index()):get_name() == "lottother:beast_ring" then

					self.driver    = clicker
					local attach_h = self.attach_h or 15
					local attach_r = self.attach_r or 90
					clicker:set_attach(self.object, "", { x = 0, y = attach_h, z = 0 }, { x = 0, y = attach_r, z = 0 })

					player_api.player_attached[clicker:get_player_name()] = true
					self.object:set_yaw(clicker:get_look_horizontal() + math.pi/2)
					self.ridername = clicker:get_player_name()

					if self.offset == true then
						local offset_h        = self.offset_h or 0
						local offset_r        = self.offset_r or 0
						self.driver_attach_at = { x = 0, y = -20, z = 0 }
						clicker:set_eye_offset({ x = 0, y = offset_h, z = 0 }, { x = 0, y = offset_r, z = 0 })
					end
				end
			end
			if not player_api.player_attached[clicker:get_player_name()] then
				minetest.chat_send_player(player, core.colorize("#ff8ea1", SL("You can't ride this beast!!!")))
			end
		end
	end

	--- @param static_data string
	function horse:on_activate(static_data, _)
		self.object:set_armor_groups({ fleshy = 100 })
		self.v = 0
		self.driver = nil
		self.current_animation = "stand"
		if not static_data or static_data == "" then
			return
		end

		local data = minetest.deserialize(static_data)
		if not data then return end
		if data.hp then
			self.object:set_hp(data.hp)
		end
	end

	--- @return string
	function horse:get_staticdata()
		return minetest.serialize({
			hp = self.object:get_hp()
		})
	end

	--- @param puncher Player|ObjectRef
	function horse:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
		local ridername = self.ridername
		local rider
		if ridername ~= nil then
			rider = minetest.get_player_by_name(ridername)
		end

		if puncher and puncher:is_player() then
			if puncher:get_player_name() == ridername then
				if move_horse_to_inventory(self, puncher) then
					player_api.player_attached[puncher:get_player_name()] = false
					puncher:set_detach()
					if self.offset == true then
						puncher:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
					end
				end
			elseif ridername == nil and puncher:get_player_control().sneak then
				move_horse_to_inventory(self, puncher)
			elseif self.aggressive == true then
				local objs = minetest.get_objects_inside_radius(self.object:get_pos(), 4)
				for _, obj in ipairs(objs) do
					if obj:is_player() and puncher:get_player_name() == obj:get_player_name() then
						self.underattack = true
						minetest.after(2, function()
							self.underattack = false
						end)

						puncher:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups       = { fleshy = self.dps }
						}, nil)
					end
				end
			end
		else
			if puncher and self.aggressive == true then
				local objs = minetest.get_objects_inside_radius(self.object:get_pos(), 4)
				for _, obj in ipairs(objs) do
					if puncher:get_luaentity() == obj:get_luaentity() then
						self.underattack = true
						minetest.after(2, function()
							self.underattack = false
						end)

						puncher:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups       = { fleshy = self.dps }
						}, nil)
					end
				end
			end
		end

		if self.object:get_hp() <= 0 and player_api.player_attached[ridername] then
			player_api.player_attached[ridername] = false
			rider:set_detach()
			self.object:remove()
			if self.offset == true then
				rider:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
			end
		end
	end

	function horse:on_death(killer)
		if not self.driver then return end

		player_api.player_attached[self.driver:get_player_name()] = false
		self.driver:set_detach()
	end

	minetest.register_entity(name, horse)
end

---------------------

lottmobs.register_horse("lottmobs:horseh1", {
	description     = SL("Brown Horse"),
	inventory_image = "lottmobs_horse_inventory.png",
}, {
	riders        = { "man", "elf" },
	physical      = true,
	collisionbox  = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual        = "mesh",
	stepheight    = 1.1,
	hp            = 30,
	visual_size   = { x = 1, y = 1 },
	mesh          = "horseh1_model.x",
	textures      = { "lottmobs_horse.png" },
	animation     = {
		speed_normal = 10,
		stand_start  = 0,
		stand_end    = 50,
		walk_start   = 75,
		walk_end     = 98,

	},
	max_speed     = 7,
	forward_boost = 2.33,
	jump_boost    = 4,
	attach_h = 6,
	feed = {
		["lottfarming:carrot_item"] = 5,
	},
})

--horse white

lottmobs.register_horse("lottmobs:horsepegh1", {
	description     = SL("White Horse"),
	inventory_image = "lottmobs_horsepeg_inventory.png",
}, {
	riders        = { "man", "elf" },
	physical      = true,
	collisionbox  = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual        = "mesh",
	stepheight    = 1.1,
	hp            = 30,
	visual_size   = { x = 1, y = 1 },
	mesh          = "horseh1_model.x",
	textures      = { "lottmobs_horsepeg.png" },
	animation     = {
		speed_normal = 10,
		stand_start  = 0,
		stand_end    = 50,
		walk_start   = 75,
		walk_end     = 98,
	},
	max_speed     = 7,
	forward_boost = 2.33,
	jump_boost    = 4,
	attach_h = 6,
	feed = {
		["lottfarming:carrot_item"] = 5,
	},
})

--horse arabik

lottmobs.register_horse("lottmobs:horsearah1", {
	description     = SL("Black Horse"),
	inventory_image = "lottmobs_horseara_inventory.png",
}, {
	riders        = { "man", "elf" },
	physical      = true,
	collisionbox  = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual        = "mesh",
	stepheight    = 1.1,
	hp            = 30,
	visual_size   = { x = 1, y = 1 },
	mesh          = "horseh1_model.x",
	textures      = { "lottmobs_horseara.png" },
	animation     = {
		speed_normal = 10,
		stand_start  = 0,
		stand_end    = 50,
		walk_start   = 75,
		walk_end     = 98,
	},
	max_speed     = 7,
	forward_boost = 2.33,
	jump_boost    = 4,
	attach_h = 6,
	feed = {
		["lottfarming:carrot_item"] = 5,
	},
})

lottmobs.register_horse("lottmobs:shireponyblackh1", {
	description     = SL("Shire Pony"),
	inventory_image = "lottmobs_shireponyblack_inventory.png",
}, {
	riders        = { "dwarf", "hobbit" },
	physical      = true,
	collisionbox  = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual        = "mesh",
	stepheight    = 1.1,
	hp            = 30,
	visual_size   = { x = 1.15, y = 1.15 },
	mesh          = "shireponyh1_model.x",
	textures      = { "lottmobs_shireponyblack.png" },
	offset        = true,
	offset_h      = 2,
	attach_h      = 2,
	animation     = {
		speed_normal = 15,
		stand_start  = 0,
		stand_end    = 39,
		walk_start   = 45,
		walk_end     = 85,
	},
	max_speed     = 5,
	forward_boost = 1.67,
	jump_boost    = 3,
	feed = {
		["lottfarming:carrot_item"] = 5,
	},
})

lottmobs.register_horse("lottmobs:shireponyh1", {
	description     = SL("Shire Pony"),
	inventory_image = "lottmobs_shirepony_inventory.png",
}, {
	riders        = { "dwarf", "hobbit" },
	physical      = true,
	collisionbox  = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual        = "mesh",
	stepheight    = 1.1,
	hp            = 30,
	visual_size   = { x = 1.15, y = 1.15 },
	mesh          = "shireponyh1_model.x",
	textures      = { "lottmobs_shirepony.png" },
	offset        = true,
	offset_h      = 2,
	attach_h      = 2,
	animation     = {
		speed_normal = 15,
		stand_start  = 0,
		stand_end    = 39,
		walk_start   = 45,
		walk_end     = 85,
	},
	max_speed     = 5,
	forward_boost = 1.67,
	jump_boost    = 3,
	feed = {
		["lottfarming:carrot_item"] = 5,
	},
})


----------------------

mobs:register_mob("lottmobs:horse", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_horse.png" },
	},
	visual               = "mesh",
	mesh                 = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 25,
		stand_end    = 75,
		walk_start   = 75,
		walk_end     = 100,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = { "farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "default:apple" },
	view_range           = 9,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:horseh1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
})

mobs:register_mob("lottmobs:horsepeg", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_horsepeg.png" },
	},
	visual               = "mesh",
	mesh                 = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 25,
		stand_end    = 75,
		walk_start   = 75,
		walk_end     = 100,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = { "farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "default:apple" },
	view_range           = 9,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:horsepegh1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
})

mobs:register_mob("lottmobs:horseara", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_horseara.png" },
	},
	visual               = "mesh",
	mesh                 = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 25,
		stand_end    = 75,
		walk_start   = 75,
		walk_end     = 100,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = { "farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "default:apple" },
	view_range           = 9,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:horsearah1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
})

mobs:register_mob("lottmobs:shirepony", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_shirepony.png" },
	},
	visual               = "mesh",
	mesh                 = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	visual_size          = { x = 1.3, y = 1.3 },
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 0,
		stand_end    = 40,
		walk_start   = 45,
		walk_end     = 85,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = {
		"farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "lottfarming:carrot_item"
	},
	view_range           = 5,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "lottfarming:sheaf_barley" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:shireponyh1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
})

mobs:register_mob("lottmobs:shireponyblack", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_shireponyblack.png" },
	},
	visual               = "mesh",
	mesh                 = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	visual_size          = { x = 1.3, y = 1.3 },
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 0,
		stand_end    = 40,
		walk_start   = 45,
		walk_end     = 85,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = {
		"farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "lottfarming:carrot_item"
	},
	view_range           = 5,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "lottfarming:sheaf_barley" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:shireponyblackh1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
})
