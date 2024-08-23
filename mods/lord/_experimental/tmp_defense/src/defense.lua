local math_limit, math_floor, string_match, ipairs
    = math.limit, math.floor, string.match, ipairs

local PlayerDefense = require('defense.PlayerDefense')


--- @type table<number,string>|string[]
local ARMOR_PURPOSE = { 'head', 'torso', 'legs', 'feet', 'shield' }


defense = {} -- luacheck: ignore unused global variable defense

local function register_api()
	_G.defense = {
		--- @param player Player
		for_player = function(player)
			return PlayerDefense:new(player)
		end,
	}
end

local function collect_armor_data(player)
	local armor_level     = 0
	local armor_dmg_avoid = 0
	local armor_fire      = 0
	local armor_wear      = 0
	local armor_count     = 0

	local material = { type = nil, count = 1 } -- detection of same material armor-set

	for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			armor_level     = armor_level + (item_groups['armor_' .. ARMOR_PURPOSE[slot]] or 0)
			armor_wear      = armor_wear + stack:get_wear()
			armor_count     = armor_count + 1
			armor_dmg_avoid = armor_dmg_avoid + (item_groups['damage_avoid_chance'] or 0)
			armor_fire      = armor_fire + (item_groups['armor_fire'] or 0)
			local mat = string_match(stack:get_name(), '%:.+_(.+)$')
			if material.type then
				if material.type == mat then
					material.count = material.count + 1
				end
			else
				material.type = mat
			end
		end
	end

	return armor_level, armor_dmg_avoid, armor_fire, armor_wear, armor_count,
		(material.type and material.count == #ARMOR_PURPOSE)
end

local function rebuild_armor_groups(player, armor_level)
	local immortal = player:get_armor_groups().immortal
	if player:get_meta():get('lott:immunity') ~= nil and (not immortal or immortal == 0) then
		return { fleshy = 1 }
	end

	local armor_groups = {}
	if immortal and immortal ~= 0 then
		armor_groups.immortal = 1
	end

	armor_level = math_limit(armor_level, 0, 100)
	armor_groups.level = math_floor(armor_level / 20)
	armor_groups.fleshy = 100 - armor_level

	return armor_groups
end

local function set_player_defense(player)
	local name = player:get_player_name()
	if not name then
		return
	end

	local armor_level, armor_dmg_avoid, armor_fire, armor_wear, armor_count, same_material_set = collect_armor_data(player)

	if same_material_set then
		armor_level = armor_level * 1.1
	end

	player:set_armor_groups(rebuild_armor_groups(player, armor_level))
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		equipment.on_change(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
			set_player_defense(player)
		end)

		require('damage_avoid')
	end
}
