-- Table for saving player physics to avoid getting bugs with potions
local players_physics = {}

local CONTROL_CHARGE = "RMB"
local PLAYER_SLOWDOWN_SPEED = 0.25

--- @param tool_name string name of a stage of an archery item
--- @return          string name of the stage 0 archery item
local function to_original_state(tool_name)
	local name = minetest.registered_items[tool_name]._original_state or tool_name
	return name
end

local function reg_from_archery_item(name)
    local common_table = table.join(table.copy(lord_archery.get_bows()), table.copy(lord_archery.get_crossbows()))
    local reg = common_table[to_original_state(name)]
    print(dump(reg))
    return reg
end

--- @param stack      ItemStack          a stack with the archery item
--- @param hold_time  number             the time the player was holding CONTROL_CHARGE down
--- @param stage_conf archery.StageConf  the StageConf table
--- @param player     Player             a player that charges the archery item
--- @return           boolean|ItemStack  a stack with the different name if charge is succesful, or false
local function charge(stack, hold_time, stage_conf, player)
	minetest.chat_send_all("TWO")
	local name = player:get_player_name()

	if not name then
		return false
	end
	local stage_list = stage_conf.stages

	for position, current_stage in pairs(stage_list) do
		local next_pos = position + 1
		local next_stage_time = stage_conf.charging_time[next_pos]
		local next_stage_stack = stage_list[next_pos]
		if stack:get_name() == current_stage then
			--minetest.chat_send_all(#stage_list-1)
			--minetest.chat_send_all(position + 1)
			if next_stage_time and (hold_time >= next_stage_time) then
				stack:set_name(next_stage_stack)
				return stack
			end
		end
	end
	return false
end


--- @param stack ItemStack a stack with the archery item
--- @return      ItemStack resulting archery item stack
local function discharge(stack)
	stack:set_name(to_original_state(stack:get_name()))
	return stack
end

-- See #1855
--- @param player Player a player to slow down
local function player_slowdown(player)
	--physics.for_player(player):set({
	--	speed = PLAYER_SLOWDOWN_SPEED,
	--},
	--{
	--	name = "archery:draw_slowdown",
	--})
end

-- See #1855
--- @param player Player a player to reset the effect of slowing down for
local function player_reset_slowdown(player)
	--physics.for_player(player):revert({
	--	name = "archery:draw_slowdown",
	--})
end

local function calculate_power(stack, hold_time, no_hold)
	local charging_time = reg_from_archery_item(stack:get_name()).stage_conf.charging_time
	local draw_power    = reg_from_archery_item(stack:get_name()).draw_power or 1
	local max_holding   = charging_time[#charging_time]

	if no_hold then
		return draw_power
	end

	local power = draw_power*(hold_time-charging_time[1])/max_holding

	if power >= 1 then
		power = 1
	elseif hold_time <= 0.1 then
		power = 0.1/max_holding
	end
	return power
end

--- @param player    Player     a player that shoots the projectile
--- @param stack     ItemStack  a stack with the archery item
--- @param hold_time number     the time the player was holding CONTROL_CHARGE down
local function projectile_shoot(player, stack, power)
	local inv            = player:get_inventory()
	local look_dir       = player:get_look_dir()
	local player_pos     = player:get_pos()
	local projectile_pos = vector.new(player_pos.x, player_pos.y + 1.5, player_pos.z)

	local uses = reg_from_archery_item(stack:get_name()).definition.uses
	for item_name, reg in pairs(projectiles.get_projectiles()) do
		if inv:contains_item("main", item_name) then
			local projectile = minetest.add_entity(projectile_pos, reg.entity_name)

			projectile:add_velocity(vector.multiply(look_dir, reg.entity_reg.max_speed * 3 * power))
			projectile:set_acceleration(vector.new(0, -GRAVITY, 0))
			projectile:get_luaentity()._shooter = player
			stack:add_wear(65535/uses)
			inv:remove_item("main", item_name)
			return true
		end
	end
end

-- Check if there are projectiles in player inventory
--- @param player Player   the player to check the inventory of
--- @return       boolean  true if player has projectiles, or false
local function check_projectiles(player, type)
	type = type or "arrow"
	local inv = player:get_inventory()
	for item_name, reg in pairs(projectiles.get_projectiles()) do
		if reg.type == type and inv:contains_item("main", item_name) then
			return item_name
		end
	end
	return false
end

local function find_matching_projectile(player, archery_item)
	local used_projectiles = archery_item:get_definition()._used_projectiles
	for _, projectile_type in ipairs(used_projectiles) do
		local found_projectile = check_projectiles(player, projectile_type)
		return found_projectile
	end
end

return {
	find_matching_projectile = find_matching_projectile,
	player_reset_slowdown = player_reset_slowdown,
	reg_from_archery_item = reg_from_archery_item,
	projectile_shoot = projectile_shoot,
	calculate_power = calculate_power,
	player_slowdown = player_slowdown,
	discharge = discharge,
	charge = charge,
	CONTROL_CHARGE = CONTROL_CHARGE,
}
