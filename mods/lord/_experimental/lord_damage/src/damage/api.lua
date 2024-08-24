local function calculate_damage_absorption(player, amount, damage_type)
	local protection = player:get_armor_groups()[damage_type]
	if not protection or type(protection) ~= "number" or protection <= 0 then
		return amount
	end

	return amount - protection
end

--- @class DamageReason:PlayerHPChangeReason
--- @field damage_type string
--- @field source      string

--- @alias DamageBehavior fun(object:ObjectRef,amount:number,reason:DamageReason,chunks:number|nil,run:function|nil)

--- @type table<string,DamageBehavior>
local damage_types = {}

--- @param object Player|Entity  object to set the source onto
--- @param source string         source name
--- @param value  boolean        whether source is active (true) or not (false)
local function set_source(object, source, value)
	local state = base_classes.ObjectState:new(object)
	state:set_entry(source, value)
	state:save(object)
end

--- @param object Player|Entity  object to get the source from
--- @param source string         source name
--- @return boolean  whether source is active (true) or not (false)
local function get_source_status(object, source)
	local state = base_classes.ObjectState:new(object)

	return state:get_entry(source)
end

--- @param damage_type string    damage type name
--- @param behavior    function  function which is called on deal_damage()
local function register_damage_type(damage_type, behavior)
	damage_types[damage_type] = behavior
	return true
end

--- @return table<string, function>  a table containing all registered damage types
local function get_registered_damage_types()
	return damage_types
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

	local to_return = damage_types[reason.damage_type or "direct"](object, amount, reason, chunks, run)
	return to_return
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
	local source = reason.source
	amount = calculate_damage_absorption(object, amount, damage_type)
	run = run or function() end
	local caused_by_source = false
	if source then
		caused_by_source = true
	end


	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks
	local player_has_died = false
	local object_has_died = false
	local player_has_left = false
	local source_removed  = false



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

			if caused_by_source and not object_has_died then
				source_removed = (source and not get_source_status(object, source))
			end

			local reset_damage = player_has_died or player_has_left or object_has_died or source_removed
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

		if caused_by_source and not object_has_died then
			source_removed = (source and not get_source_status(object, source))
		end

		local reset_damage = player_has_died or player_has_left or object_has_died or source_removed
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
	-- get_source_status           = get_source_status,
	base_behavior               = base_behavior,
	periodic_base_behavior      = periodic_base_behavior,
	deal_damage                 = deal_damage,
	-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
	set_source                  = set_source,
}
