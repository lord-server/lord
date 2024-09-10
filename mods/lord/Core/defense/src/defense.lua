local string_match
    = string.match

local PlayerDefense = require('defense.PlayerDefense')


--- @type table<number,string>|string[]
local ARMOR_PURPOSE = { 'head', 'torso', 'legs', 'feet', 'shield' }

--- @type defense.PlayerDefense[]|table<string,defense.PlayerDefense>
local player_defense = {}


defense = {} -- luacheck: ignore unused global variable defense

local function register_api()
	_G.defense = {
		--- @param player Player
		for_player = function(player)
			local name = player:get_player_name()
			if not player_defense[name] then
				player_defense[name] = PlayerDefense:new(player)
			else
				player_defense[name]:refresh_player(player)
			end

			return player_defense[name]
		end,
	}
end

--- @param player Player
local function collect_defense_from_armor_equipment(player)
	local defense = {
		fleshy = 0,
		fire   = 0,
		soul   = 0,
		poison = 0,
	}
	local damage_avoid = 0

	local material = { type = nil, count = 1 } -- detection of same material armor-set

	for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			defense.fleshy = defense.fleshy + (item_groups['armor_' .. ARMOR_PURPOSE[slot]] or 0)
			defense.fire   = defense.fire   + (item_groups['armor_fire'] or 0)
			damage_avoid   = damage_avoid + (item_groups['damage_avoid_chance'] or 0)

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

	-- if same material set
	if (material.type and material.count == #ARMOR_PURPOSE) then
		defense.fleshy = defense.fleshy * 1.1
	end

	return defense, damage_avoid
end

--- @param player Player
local function set_player_defense(player)
	local defense_groups, damage_avoid_chance = collect_defense_from_armor_equipment(player)
	defense.for_player(player):set(defense_groups, damage_avoid_chance)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()

		equipment.on_load(equipment.Kind.ARMOR, function(player)
			set_player_defense(player)
		end)

		equipment.on_change(equipment.Kind.ARMOR, function(player)
			set_player_defense(player)
		end)

		minetest.register_on_leaveplayer(function(player, timed_out)
			player_defense[player:get_player_name()] = nil
		end)

		require('defense.damage_avoid')
	end
}
