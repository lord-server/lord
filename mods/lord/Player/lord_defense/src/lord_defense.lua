local string_match
	= string.match


--- @type number
local armor_slots_count = equipment.Kind.get_size(equipment.Kind.ARMOR)

---@param stack    ItemStack
---@param material {type:string,count:number}
local function remember_material(stack, material)
	local material_type = string_match(stack:get_name(), '%:.+_(.+)$')
	if material.type then
		if material.type == material_type then
			material.count = material.count + 1
		end
	else
		material.type = material_type
	end
end

--- @param player Player
local function collect_defense_from_armor_equipment(player)
	local defense = {
		fleshy      = 0,
		fire        = 0,
		soul        = 0,
		poison      = 0,
		suffocation = 0,
	}
	local damage_avoid = 0

	local material = { type = nil, count = 1 } -- detection of same material armor-set

	local ring_defense = 0
	for slot, stack in equipment.for_player(player):not_empty(equipment.Kind.ARMOR) do
		local item_groups = stack:get_definition().groups
		if stack:get_name() == 'lottother:nenya' then
			ring_defense = item_groups.defense_fleshy
		end
		for _, type in ipairs(damage.Type.get_registered()) do
			defense[type] = defense[type] + (item_groups['defense_'..type] or 0)
		end
		damage_avoid = damage_avoid + (item_groups['damage_avoid_chance'] or 0)
		remember_material(stack, material)
	end

	-- if same material set
	if (material.type and material.count == armor_slots_count) then
		defense.fleshy = defense.fleshy * 1.05
	end

	-- either armor or the ring
	if ring_defense > 0 then
		local only_armor_fleshy_defense = defense.fleshy - ring_defense
		defense.fleshy = math.max(ring_defense, only_armor_fleshy_defense)
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
