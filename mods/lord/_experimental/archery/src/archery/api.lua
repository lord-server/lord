
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
--- @param stages     archery.Stages     the stages and time taken to charge
--- @param player     Player             a player that charges the archery item
--- @return           boolean|ItemStack  a stack with the different name if charge is succesful, or false
local function charge(stack, hold_time, stages, player)
	local name = player:get_player_name()

	if not name then
		return false
	end

	for position, stage in pairs(stages.stages) do
		if stack:get_name() == stage then
			if (hold_time >= stages.charging_time[position]) and (#stages.stages-1 >= position + 1) then
				stack:set_name(stages.stages[position + 1])
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
--- @param stack     ItemStack  a stack with the archery item
--- @param hold_time number     the time the player was holding CONTROL_CHARGE down
local function projectile_shot(player, stack, hold_time)
	local inv            = player:get_inventory()
	local look_dir       = player:get_look_dir()
	local player_pos     = player:get_pos()
	local projectile_pos = vector.new(player_pos.x, player_pos.y + 1.5, player_pos.z)
	local charging_time  = reg_from_archery_item(stack:get_name()).stages.charging_time
	local shot_power     = reg_from_archery_item(stack:get_name()).shot_power or 1
	local max_holding    = charging_time[#charging_time]

    if not hold_time then
        hold_time = max_holding
    end

	local power = hold_time/max_holding

	if power >= 1 then
		power = 1
	elseif hold_time <= 0.1 then
		power = 0.1/max_holding
	end
	local uses = reg_from_archery_item(stack:get_name()).definition.uses
	for item_name, reg in pairs(projectiles.get_projectiles()) do
		if inv:contains_item("main", item_name) then
			local projectile = minetest.add_entity(projectile_pos, reg.entity_name)
			projectile:add_velocity(vector.multiply(look_dir, reg.entity_reg.max_speed * 3 * power * shot_power))
			projectile:set_acceleration(vector.new(0, -GRAVITY, 0))
			projectile:get_luaentity()._shooter = player
			stack:add_wear(65535/uses)
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
	for item_name, reg in pairs(projectiles.get_projectiles()) do
		if reg.type == type and inv:contains_item("main", item_name) then
			return true
		end
	end
	return false
end

-- Bow charge on hold
controls.on_hold(function(player, key, hold_time)
	-- Charging on holding CONTROL_CHARGE
	if key ~= CONTROL_CHARGE then
		return
	end

	-- Check if wielded item is not an archery_item
	local stack = player:get_wielded_item()
	if not stack:get_definition().groups.archery_item then
		return
	end

	if not check_projectiles(player) then
		return
	end

	player_slowdown(player)

	local new_stack = charge(stack, hold_time, reg_from_archery_item(stack:get_name()).stages, player)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Charged crossbow discharge on release
controls.on_press(function(player, key)
	if key ~= CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.crossbow then
		return
	end

	minetest.sound_play(stack:get_definition()["_sound_on_release"], {object = player})

	projectile_shot(player, stack, hold_time)

	player_reset_slowdown(player)
	local new_stack = discharge(stack)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- Bow discharge on release
controls.on_release(function(player, key, hold_time)
	if key ~= CONTROL_CHARGE then
		return
	end

	local stack = player:get_wielded_item()

	if not stack:get_definition().groups.bow then
		return
	end

	minetest.sound_play(stack:get_definition()["_sound_on_release"], {object = player})

	projectile_shot(player, stack, hold_time)

	player_reset_slowdown(player)
	local new_stack = discharge(stack)
	if new_stack then
		player:set_wielded_item(new_stack)
	end
end)

-- If the wielded item changed while bow was charging, discharge without shooting the arrow
wield_item.on_index_change(function(player, player_wield_index, player_last_wield_index)
	local inv   = player:get_inventory()
	local stack = inv:get_stack("main", player_last_wield_index)

	if not stack:get_definition().groups.allow_hold_abort then
		return
	end

	player_reset_slowdown(player)
	local new_stack = discharge(stack)
	if new_stack then
		inv:set_stack("main", player_last_wield_index, new_stack)
	end
end)
