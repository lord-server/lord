local string_match
	= string.match


--- @type number
local armor_slots_count = equipment.Kind.get_size(equipment.Kind.ARMOR)

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

	for slot, stack in equipment.for_player(player):not_empty(equipment.Kind.ARMOR) do
		local item_groups = stack:get_definition().groups
		for _, type in ipairs(damage.Type.get_registered()) do
			defense[type] = defense[type] + (item_groups['defense_'..type] or 0)
		end
		damage_avoid = damage_avoid + (item_groups['damage_avoid_chance'] or 0)

		local mat = string_match(stack:get_name(), '%:.+_(.+)$')
		if material.type then
			if material.type == mat then
				material.count = material.count + 1
			end
		else
			material.type = mat
		end
	end

	-- if same material set
	if (material.type and material.count == armor_slots_count) then
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
	init = function()
		equipment.on_load(equipment.Kind.ARMOR, function(player)
			set_player_defense(player)
		end)

		equipment.on_change(equipment.Kind.ARMOR, function(player)
			set_player_defense(player)
		end)
	end,
}
