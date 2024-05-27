-- local S = minetest.get_translator("lord_damage")

local function calculate_damage_absorption(player, amount, damage_type)
	local protection = player:get_armor_groups()[damage_type]
	if not protection or type(protection) ~= "number" or protection <= 0 then
		return amount
	end

	return amount - protection
end

local function base_behavior(player, amount, damage_type, reason)
	amount = calculate_damage_absorption(player, amount, damage_type)
	return player:set_hp(player:get_hp() - amount, reason)
end

local damage = {
	--- @type table<string,function>
	damage_types = {},
}

local function set_source(player, source, value)
	local meta = player:get_meta()
	meta:set_string(source, value)
	return player, source
end

local function get_source_status(player, source)
	local meta = player:get_meta()
	return meta:get_string(source)
end

--- @param damage_type string    damage type name
--- @param behavior    function  function which is called on deal_damage()
local function register_damage_type(damage_type, behavior)
	damage.damage_types[damage_type] = behavior
	return true
end

local function deal_damage(player, amount, damage_type, reason, source, chunks)
	if not amount then
		return false
	end

	if not damage_type then
		damage_type = "direct"
	end

	chunks = chunks or 1

	return damage.damage_types[damage_type](player, amount, reason, source, chunks)
end


return {
	calculate_damage_absorption = calculate_damage_absorption,
	register_damage_type        = register_damage_type,
	get_source_status           = get_source_status,
	base_behavior               = base_behavior,
	deal_damage                 = deal_damage,
	set_source                  = set_source,
	get_nodes                   = function() return damage.damage_types end,
}
