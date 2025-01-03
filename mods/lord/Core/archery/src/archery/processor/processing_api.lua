local CONTROL_CHARGE = "RMB"
-- local PLAYER_SLOWDOWN_SPEED = 0.25

--- @param tool_name string name of a stage of an archery item
--- @return          string name of the stage 0 archery item
local function to_original_state(tool_name)
	local name = minetest.registered_items[tool_name]._original_state or tool_name
	return name
end

local function reg_from_archery_item(name)
    local common_table = table.join(table.join(archery.get_bows(), archery.get_crossbows()), archery.get_throwables())
    local reg = common_table[to_original_state(name)]
    return reg
end

--- @param stack      ItemStack          a stack with the archery item
--- @param hold_time  number             the time the player was holding CONTROL_CHARGE down
--- @param stage_conf archery.StageConf  the StageConf table
--- @param player     Player             a player that charges the archery item
--- @return           boolean|ItemStack  a stack with the different name if charge is succesful, or false
local function charge(stack, hold_time, stage_conf, player)
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
			if next_stage_time and (hold_time >= next_stage_time) then
				stack:set_name(next_stage_stack)
				return stack
			end
		end
	end
	return false
end

--- @param stack ItemStack a stack with the archery item
--- @return ItemStack resulting archery item stack
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
	local draw_power    = reg_from_archery_item(stack:get_name()).definition.draw_power
	local max_holding   = charging_time[#charging_time]

	if no_hold then
		return draw_power
	end

	local time_until_stage1 = charging_time[1]
	hold_time = hold_time-time_until_stage1

	if hold_time >= max_holding then
		hold_time = max_holding
	end

	local power = draw_power*hold_time/max_holding

	if power > 1 then
		power = 1
	elseif hold_time < 0.1 then
		power = 0.1
	end

	return power
end

--- @param shooter                Object|Player  a player that shoots the projectile
--- @param projectile_stack       ItemStack      itemstack with item to shoot
--- @param power                  number         power multiplier
--- @param forced_direction       vector         forced shooting direction (normalized vector)
--- @param forced_start_position  vector         forced position to spawn the projectile on
local function projectile_shoot(shooter, projectile_stack, power, forced_direction, forced_start_position)
	local shooter_pos    = shooter:get_pos()
	local yaw            = shooter:get_yaw()
	local look_dir       = forced_direction
	local projectile_pos = forced_start_position

	if shooter and shooter:is_player() then
		look_dir = look_dir or shooter:get_look_dir()
		projectile_pos = forced_start_position or vector.new(shooter_pos.x, shooter_pos.y + 1.5, shooter_pos.z)
	elseif shooter then
		look_dir = look_dir or vector.new(-math.sin(yaw), 0.25, math.cos(yaw))
		projectile_pos = forced_start_position or vector.new(shooter_pos.x, shooter_pos.y, shooter_pos.z)
	end

	local projectile_item = projectile_stack:get_name()

	local projectile_reg = projectiles.get_projectiles()[projectile_item]

	local projectile_entity = minetest.add_entity(projectile_pos, projectile_reg.entity_name)
	projectile_entity:add_velocity(vector.multiply(look_dir, projectile_reg.entity_reg.max_speed * power))
	projectile_entity:set_acceleration(vector.new(0, -GRAVITY, 0))
	projectile_entity:get_luaentity()._shooter = shooter
	projectile_entity:get_luaentity()._projectile_stack = projectile_stack
	projectile_entity:get_luaentity()._remove_on_object_hit = projectile_reg.entity_reg.remove_on_object_hit
	projectile_entity:get_luaentity()._rotation_formula = projectile_reg.entity_reg.rotation_formula

	return true
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

	-- luacheck: globals g1 g2, ignore 512
	for _, projectile_type in ipairs(used_projectiles) do
		local found_projectile = check_projectiles(player, projectile_type)
		return found_projectile
	end
end

return {
	find_matching_projectile = find_matching_projectile,
	player_reset_slowdown = player_reset_slowdown,
	reg_from_archery_item = reg_from_archery_item,
	to_original_state = to_original_state,
	projectile_shoot = projectile_shoot,
	calculate_power = calculate_power,
	player_slowdown = player_slowdown,
	discharge = discharge,
	charge = charge,
	CONTROL_CHARGE = CONTROL_CHARGE,
}
