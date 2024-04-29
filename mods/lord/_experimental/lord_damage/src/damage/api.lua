local S = minetest.get_translator("lord_damage")

local damage = {
	--- @type table<string,function>
	damage_types = {
		["direct"] = function() end
	},
}

local function base_behavior(player, amount)

end

local function deal_damage(player, amount, type)
	if not amount then
		return false
	end

	if not type then
		type = "direct"
	end

	return damage.damage_types[type](player, amount)
end


--- @param type     string    damage type name
--- @param behavior function  function which is called on deal_damage()
local function register_damage_type(type, behavior)
	damage.damage_types[type] = behavior or base_behavior
	return true
end


return {
	register_damage_type = register_damage_type,
	deal_damage          = deal_damage,
	get_nodes            = function() return damage.damage_types end,
}
