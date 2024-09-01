local function calculate_damage_absorption(player, amount, damage_type)
	local protection = player:get_armor_groups()[damage_type]
	if not protection or type(protection) ~= "number" or protection <= 0 then
		return amount
	end

	return amount - protection
end

--- @class DamageReason:PlayerHPChangeReason
--- @field damage_type string
--- @field cause      string

--- @alias DamageBehavior fun(object:ObjectRef,amount:number,reason:DamageReason,chunks:number|nil,run:function|nil)

--- @type table<string,DamageBehavior>
local damage_behaviors = {}

--- @param object Player|Entity  object to set the cause onto
--- @param cause string         cause name
--- @param value  boolean        whether cause is active (true) or not (false)
local function set_cause(object, cause, value)
	local state = base_classes.ObjectState:new(object)
	state:set_entry(cause, value)
	state:save(object)
end

--- @param object Player|Entity  object to get the cause from
--- @param cause string         cause name
--- @return boolean  whether cause is active (true) or not (false)
local function get_cause(object, cause)
	local state = base_classes.ObjectState:new(object)

	return state:get_entry(cause)
end

--- @param damage_type string    damage type name
--- @param behavior    function  function which is called on deal_damage()
local function register_damage_type(damage_type, behavior)
	damage_behaviors[damage_type] = behavior
	return true
end

--- @return table<string, function>  a table containing all registered damage types
local function get_registered_damage_types()
	return damage_behaviors
end


--- @param object Player|Entity
--- @param amount number
--- @param reason DamageReason
--- @param chunks number
--- @param run    function
local function deal_damage(object, amount, reason, chunks, run)
	if not amount then
		return false
	end

	chunks = chunks or 1

	local to_return = damage_behaviors[reason.damage_type or "direct"](object, amount, reason, chunks, run)
	return to_return
end

local function generate_damage_pattern(amount, portions, treat_portions_as_divisions)
	local pattern = {}
	local max_entries

	if treat_portions_as_divisions == true then
		max_entries = portions
		portions = math.floor(amount/max_entries)
		
	else
		max_entries = math.floor(amount/portions)
	end
	local leftover_damage = amount%portions

	for i = 1, max_entries do
		pattern[i] = 1
	end

	return pattern
end

--- @param object Player|Entity
--- @param amount number
--- @param reason DamageReason
local function base_behavior(object, amount, reason)
	-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
	minetest.chat_send_player(reason.dealer:get_player_name(), "Hit: "..amount.."!")
	object:set_hp(object:get_hp() - amount, reason)
end

--- @param object Player|Entity
--- @param amount number
--- @param reason DamageReason
--- @param chunks number|nil
--- @param run    function
local function periodic_base_behavior(object, amount, reason, chunks, run)
	dump(chunks)
	local damage_type = reason.damage_type
	local cause = reason.cause
	amount = calculate_damage_absorption(object, amount, damage_type)
	run = run or function() end
	local has_a_cause = false
	if cause then
		has_a_cause = true
	end


	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks
	local player_has_died = false
	local object_has_died = false
	local player_has_left = false
	local cause_removed  = false



	local cycle_number = 0
	for i = 1, max_cycle do
		minetest.after(cycle_number, function()
			minetest.chat_send_all("Pass")
			if not object then
				return
			end

			if object:is_player() then
				minetest.chat_send_all("Is player")
				minetest.register_on_dieplayer(function(dieplayer)
					if dieplayer:get_player_name() == object:get_player_name() then
						player_has_died = true
					end
				end)
				minetest.register_on_leaveplayer(function(leaveplayer)
					if leaveplayer:get_player_name() == object:get_player_name() then
						player_has_left = true
					end
				end)
			else
				if not object:is_valid() or not object:get_luaentity() then
					minetest.chat_send_all("Died")
					object_has_died = true
				end
			end

			if has_a_cause and not object_has_died then
				cause_removed = (cause and not get_cause(object, cause))
			end

			local reset_damage = player_has_died or player_has_left or object_has_died or cause_removed
			if reset_damage then
				minetest.chat_send_all("Reset")
				leftover_damage = 0
				return
			end

			run()

			-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
			minetest.chat_send_player(reason.dealer:get_player_name(), "Hit: "..chunks.."!")
			object:set_hp(object:get_hp() - chunks, reason)
		end)
		cycle_number = cycle_number + 1
	end
	minetest.after(max_cycle, function()
		if not object then
			return
		end

		if leftover_damage == 0 then
			return
		end

		if object:is_player() then
			minetest.register_on_dieplayer(function(dieplayer)
				if dieplayer:get_player_name() == object:get_player_name() then
					player_has_died = true
				end
			end)
			minetest.register_on_leaveplayer(function(leaveplayer)
				if leaveplayer:get_player_name() == object:get_player_name() then
					player_has_left = true
				end
			end)
		else
			if not object:is_valid() or not object:get_luaentity() then
				minetest.chat_send_all("Died")
				object_has_died = true
			end
		end

		if has_a_cause and not object_has_died then
			cause_removed = (cause and not get_cause(object, cause))
		end

		local reset_damage = player_has_died or player_has_left or object_has_died or cause_removed
		if reset_damage then
			return
		end

		run()

		-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
		minetest.chat_send_player(reason.dealer:get_player_name(), "Hit: "..leftover_damage.."!")
		object:set_hp(object:get_hp() - leftover_damage, reason)
	end)
end


return {
	-- calculate_damage_absorption = calculate_damage_absorption,
	register_damage_type        = register_damage_type,
	get_registered_damage_types = get_registered_damage_types,
	-- get_cause           = get_cause,
	base_behavior               = base_behavior,
	periodic_base_behavior      = periodic_base_behavior,
	deal_damage                 = deal_damage,
	-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
	set_cause                  = set_cause,
}
