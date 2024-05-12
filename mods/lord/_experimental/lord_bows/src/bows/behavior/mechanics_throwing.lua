
-- Table for saving player physics to avoid getting bugs with potions
local players_physics = {}

local CONTROL_CHARGE = "RMB"
local PLAYER_SLOWDOWN_SPEED = 0.25

--- @param tool_name string name of a stage of bow
--- @return          string name of the stage 0 bow
local function to_bow_name(tool_name)
	for name, bow in pairs(lord_bows.get_bows()) do
		print(minetest.serialize(bow))
		for _, stage in ipairs(bow.bow_stages.stages) do
			if stage == tool_name then
				return name
			end
		end
	end
	return tool_name
end

--- @param stack      ItemStack          a stack with the bow
--- @param hold_time  number             the time the player was holding CONTROL_CHARGE down
--- @param bow_stages bows.BowStages     the stages and time taken to charge
--- @param player     Player             a player that charges the bow
--- @return           boolean|ItemStack  a stack with the different name if charge is succesful, or false
local function bow_charge(stack, hold_time, bow_stages, player)
	local name = player:get_player_name()

	if not name then
		return false
	end

	for position, stage in pairs(bow_stages.stages) do
		if stack:get_name() == stage then
			if (hold_time >= bow_stages.charging_time[position]) and (#bow_stages.stages-1 >= position + 1) then
				stack:set_name(bow_stages.stages[position + 1])
				return stack
			end
		end
	end
	return false
end


--- @param stack ItemStack a stack with the bow
--- @return      ItemStack resulting bow stack
local function bow_discharge(stack)
	stack:set_name(to_bow_name(stack:get_name()))
	return stack
end


--- @param player Player a player to slow down
local function player_slowdown(player)
	local physics = player:get_physics_override()

	if not physics then
		return
	end

	if physics.speed ~= PLAYER_SLOWDOWN_SPEED then
		players_physics[player:get_player_name()] = physics.speed
	end

	physics.speed = PLAYER_SLOWDOWN_SPEED
	player:set_physics_override(physics)
end

--- @param player Player a player to reset the effect of slowing down for
local function player_reset_slowdown(player)
	local physics = player:get_physics_override()

	if not physics then
		return
	end

	physics.speed = players_physics[player:get_player_name()]
	player:set_physics_override(physics)
end

--- @param player    Player     a player that shoots the projectile
--- @param stack     ItemStack  a stack with the bow
--- @param hold_time number     the time the player was holding CONTROL_CHARGE down
local function projectile_shot(player, stack, hold_time)
	local inv            = player:get_inventory()
	local look_dir       = player:get_look_dir()
	local player_pos     = player:get_pos()
	local projectile_pos      = {x = player_pos.x, y = player_pos.y + 1.5, z = player_pos.z}
	local charging_time  = lord_bows.get_bows()[to_bow_name(stack:get_name())].bow_stages.charging_time
	local max_holding    = charging_time[#charging_time]
	local power          = hold_time/max_holding
	if power >= 1 then
		power = 1
	elseif hold_time <= 0.1 then
		power = 0.1/max_holding
	end
	local bow_uses = lord_bows.get_bows()[to_bow_name(stack:get_name())].definition.uses
	for item_name, reg in pairs(lord_bows.get_projectiles()) do
		if inv:contains_item("main", item_name) then
			local projectile = minetest.add_entity(projectile_pos, reg.entity_name)
			projectile:add_velocity({
				x = look_dir.x * reg.speed * 3 * power,
				y = look_dir.y * reg.speed * 3 * power,
				z = look_dir.z * reg.speed * 3 * power,
			})
			projectile:set_acceleration({x = 0, y = GRAVITY * (-1), z = 0})
			projectile:get_luaentity().shooter = player
			stack:add_wear(65535/bow_uses)
			inv:remove_item("main", item_name)
			return
		end
	end
end

-- Check if there are projectiles in player inventory
--- @param player Player   the player to check the inventory of
--- @return       boolean  true if player has projectiles, or false
local function check_projectiles(player, type)
	type = type or "arrow"
	local inv = player:get_inventory()
	for item_name, reg in pairs(lord_bows.get_projectiles()) do
		if reg.type == type and inv:contains_item("main", item_name) then
			return true
		end
	end
	return false
end

-- Bow charge on hold
lord.register_on_hold(function(player, control_name, hold_time)
	-- Charging on holding CONTROL_CHARGE
	if control_name ~= CONTROL_CHARGE then
		return
	end

	if control_name ~= CONTROL_CHARGE then
		return
	end

	-- Check if wielded item is not a bow
	local stack = player:get_wielded_item()
	if not stack:get_definition().groups.bow then
		return
	end

	if not check_projectiles(player) then
		return
	end

	player_slowdown(player)

	local new_stack = bow_charge(stack, hold_time, lord_bows.get_bows()[to_bow_name(stack:get_name())].bow_stages, player)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Bow discharge on release
lord.register_on_release(function(player, control_name, release_time)
	if control_name ~= CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.bow then
		return
	end

	projectile_shot(player, stack, release_time)

	player_reset_slowdown(player)
	local new_stack = bow_discharge(stack)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- If the wielded item changed while bow was charging, discharge without shooting the arrow
lord.register_on_wield_index_change(function(player, player_wield_index, player_last_wield_index)
	local inv   = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.bow then
		return
	end

	player_reset_slowdown(player)
	local new_stack = bow_discharge(stack)
	if new_stack then
		inv:set_stack("main", player_last_wield_index, new_stack)
	end
end)
