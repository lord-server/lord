---
--- Регистрация спавнера сундуков
---
--- @param chest_name     string  название ноды целевого сундука
--- @param possible_items table[] массив c массивами, описывающими лут в сундуках и его возможное кол-во
---
--- `possible_items` имеет следующего вид:
--- ```
---   {
---		{ "some_mod:item_name", [постоянное число предметов] } -- по умолчанию 1
---		-- ИЛИ
---		{ "some_mod:item_name2", [нижняя граница числа предметов], [верхняя] } -- случайная выборка из данных границ
---		-- Примеры:
---   	{ "lottfarming:barley_seed" }, -- всегда 1 предмет в стаке
---   	{ "lottfarming:barley_cooked", 3 }, -- всегда 3 предмета в стаке
---   	{ "lottfarming:berries_seed", 2, 6 }, -- от 2 до 6 предметов в стаке
---   	...
---   }
--- ```
local function register_chest_spawner(chest_name, possible_items)

	-- Конструирование имени и описания ноды спавнера из имени ноды целевого сундука:
	local chest_basename = chest_name:replace("lord_chests:racial_", "")
	local chest_spawner_name = "lottmapgen:" .. chest_basename .. '_chest_spawner'

	minetest.register_node(chest_spawner_name, {
		description = chest_basename:first_to_upper() .. ' Chest Spawner',
		tiles = {"lord_chests_racial_elf_bottom.png"},
		is_ground_content = false,
		groups = { oddly_breakable_by_hand = 1, not_in_creative_inventory=1 },
	})

	--- Вспомогательная функция для регистрации ABM
	--- Преобразует possible_items (см. выше) в массив со stackstring'ами (см. lua_api.txt).
	--- @param potential_items table
	--- @return table[]
	local function get_items_available_from_possible_items(potential_items)
		local items_available = {}
		for _, item in ipairs(potential_items) do
			if #item == 1 then
				table.insert(items_available, item[1])
			elseif #item == 2 then
				table.insert(items_available, item[1] .. " " .. item[2])
			elseif #item == 3 then
				table.insert(items_available, item[1] .. " " .. math.random(item[2], item[3]))
			end
		end
		return items_available
	end

	minetest.register_abm({
		nodenames = {chest_spawner_name},
		interval = 9,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.set_node(pos, { name = chest_name, param2 = node.param2 })
			local number_of_items = math.random(3, 12)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local items_set = get_items_available_from_possible_items(possible_items)
			for _ = 1, number_of_items do
				local inv_size = inv:get_size("main")
				local stack_idx = math.random(inv_size)
				while not inv:get_stack("main", stack_idx):is_empty() do -- пока не выпадет свободный стак
					stack_idx = math.random(inv_size)
				end
				local item_idx = math.random(#items_set)
				inv:set_stack("main", stack_idx, items_set[item_idx])
			end
		end,
	})
end



register_chest_spawner("lord_chests:racial_hobbit", {
	{ "lottfarming:barley_seed", 2 },
	{ "lottfarming:barley_cooked", },
	{ "lottfarming:berries_seed", },
	{ "lottfarming:berries", 3 },
	{ "lottfarming:brown_mushroom_spore", 3 },
	{ "lottfarming:brown_mushroom", 6 },
	{ "lottfarming:corn_seed", 4 },
	{ "lottfarming:corn", 4 },
	{ "lottfarming:pipeweed_seed", 2 },
	{ "lottfarming:pipeweed", 5 },
	{ "lottfarming:pipeweed_cooked", 5 },
	{ "lottfarming:pipe", },
	{ "lottfarming:potato_seed", 2 },
	{ "lottfarming:potato", },
	{ "lottfarming:potato_cooked", 7 },
	{ "lottfarming:turnips_seed", 3 },
	{ "lottfarming:turnips", },
	{ "lottfarming:turnips_cooked", 7 },
	{ "lord_trees:plum", },
	{ "lottweapons:bronze_dagger", },
	{ "lottweapons:steel_dagger", },
	{ "lottweapons:copper_spear", },
	{ "lottweapons:tin_battleaxe", },
	{ "vessels:glass_bottle", 3 },
	{ "farming:hoe_steel", },
})

register_chest_spawner("lord_chests:racial_gondor", {
	{ "lottores:marble", 6 },
	{ "lottblocks:marble_brick", 10 },
	{ "lottarmor:helmet_silver", },
	{ "lottarmor:chestplate_steel", },
	{ "lottarmor:leggings_tin", },
	{ "lottarmor:boots_bronze", },
	{ "lottarmor:shield_copper", },
	{ "lottores:goldsword", },
	{ "default:sword_bronze", },
	{ "farming:bread", 5 },
	{ "lottmobs:meat", 2 },
	{ "lottfarming:potato_cooked", 4 },
	{ "lottfarming:melon", 3 },
	{ "lottfarming:tomatoes_cooked", 2 },
	{ "lottfarming:ear_of_corn", 6 },
	{ "lottfarming:turnips_cooked", 3 },
	{ "lottweapons:bronze_warhammer", },
	{ "lottweapons:gold_spear", },
	{ "lottweapons:copper_battleaxe", },
	{ "lottweapons:galvorn_dagger", },
	{ "lord_alcohol:beer", 10 },
	{ "lord_alcohol:cider", 10 },
	{ "lord_alcohol:wine", 5 },
	{ "lord_alcohol:wine", 2 },
	{ "lord_archery:alder_wood_bow" },
})

register_chest_spawner("lord_chests:racial_rohan", {
	{ "lottores:lead_block", },
	{ "lottores:pearl", 3 },
	{ "lottarmor:helmet_tin", },
	{ "lottarmor:chestplate_copper", },
	{ "lottarmor:leggings_bronze", },
	{ "lottarmor:boots_steel", },
	{ "lottarmor:shield_silver", },
	{ "lottores:silversword", },
	{ "lottweapons:bronze_spear", },
	{ "farming:bread", 4 },
	{ "lottmobs:meat", 6 },
	{ "lottfarming:potato_cooked", 2 },
	{ "lottfarming:brown_mushroom", 4 },
	{ "lottfarming:red_mushroom", 3 },
	{ "lottfarming:ear_of_corn", 7 },
	{ "lottweapons:gold_spear", },
	{ "lottweapons:bronze_battleaxe", },
	{ "lottweapons:tin_spear", },
	{ "lottweapons:steel_spear", },
	{ "lottweapons:tin_dagger", },
	{ "lord_alcohol:ale", 7 },
	{ "lord_alcohol:mead", 7 },
	{ "lord_alcohol:wine", 5 },
	{ "lord_alcohol:cider", 2 },
	{ "lottmobs:horseh1", },
	{ "lottmobs:horsepegh1", },
	{ "lottmobs:horsepegh1", },
	{ "lord_archery:tin_crossbow", },
	{ "lord_projectiles:steel_bolt", 5 },
})

register_chest_spawner("lord_chests:racial_elfloth", {
	{ "lottores:mithril_ingot", },
	{ "default:gold_ingot", 3 },
	{ "lottweapons:elven_sword", },
	{ "lord_wooden_stuff:door_mallorn", },
	{ "beds:bed", },
	{ "lord_wooden_stuff:fence_mallorn", 3 },
	{ "lord_wooden_stuff:table_mallorn", },
	{ "lottarmor:helmet_gold", },
	{ "lord_wooden_stuff:chair_mallorn", },
	{ "lottores:silversword", },
	{ "lottweapons:silver_spear", },
	{ "lottweapons:silver_dagger", },
	{ "lottweapons:silver_warhammer", },
	{ "lottweapons:silver_battleaxe", },
	{ "lottores:silveraxe", },
	{ "lottores:silverpick", },
	{ "lottores:silvershovel", },
	{ "lottfarming:tomato_soup", },
	{ "lottfarming:mushroom_soup", },
	{ "lottfarming:salad", },
	{ "lottfarming:athelas_seed", },
	{ "lottfarming:athelas", },
	{ "lord_trees:mallorn_sapling", },
	{ "lord_alcohol:mead", 6 },
	{ "lottplants:honey", 5 },
	{ "lord_potions:athelas_elixir_1", },
	{ "lottmobs:horsepegh1", },
	{ "lord_potions:athelas_elixir_1", },
	{ "lord_archery:alder_wood_bow", },
	{ "lord_projectiles:flint_arrow", 20 },
	{ "lord_potions:miruvor_1", },
	{ "lord_potions:athelas_elixir_1", 3 },
	{ "lottother:blue_torch", 10 },
	{ "lottores:white_gem", },
})

register_chest_spawner("lord_chests:racial_elfmirk", {
	{ "lottores:galvorn_ingot", 3 },
	{ "lottores:tin_ingot", 5 },
	{ "lottweapons:elven_sword", },
	{ "lord_wooden_stuff:door_alder", },
	{ "beds:bed", },
	{ "lord_wooden_stuff:fence_alder", 5 },
	{ "lord_wooden_stuff:table_lebethron", },
	{ "lottarmor:helmet_gold", },
	{ "lord_wooden_stuff:chair_lebethron", },
	{ "lottores:galvornsword", },
	{ "lottweapons:galvorn_spear", },
	{ "lottweapons:galvorn_dagger", },
	{ "bucket:bucket_water", },
	{ "lottfarming:tomatoes_seed", 3 },
	{ "lottfarming:barley_seed", 2 },
	{ "lottfarming:berries_seed", 6 },
	{ "lottfarming:cabbage_seed", 4 },
	{ "lottfarming:mushroom_soup", },
	{ "lottfarming:salad", },
	{ "lottfarming:corn_seed", },
	{ "lottfarming:melon_seed", 2 },
	{ "lottfarming:potato_seed", 4 },
	{ "lottfarming:turnips_seed", 2 },
	{ "lottfarming:blue_mushroom_spore", 5 },
	{ "lottfarming:brown_mushroom_spore", 5 },
	{ "lottmobs:horseh1", },
	{ "lottfarming:green_mushroom_spore", },
	{ "lottfarming:red_mushroom_spore", },
	{ "lord_projectiles:flint_arrow", 7 },
	{ "lord_potions:miruvor_2", },
	{ "lord_potions:athelas_elixir_1", 3 },
	{ "lord_archery:lebethron_wood_bow", },
	{ "lottores:blue_gem", },
	{ "farming:hoe_bronze", },
})

register_chest_spawner("lord_chests:racial_mordor", {
	{ "lord_rocks:mordor_stone", 6 },
	{ "lottblocks:orc_brick", 7 },
	{ "lottother:orc_torch", 4 },
	{ "lottmobs:meat", 5 },
	{ "lottfarming:blue_mushroom", },
	{ "lottfarming:green_mushroom", },
	{ "lord_archery:steel_crossbow", },
	{ "lord_projectiles:steel_bolt", 15 },
	{ "lord_projectiles:bronze_bolt", 2 },
	{ "lord_alcohol:wine", },
	{ "lord_potions:orcish_brew_1", 2 },
	{ "lord_potions:orcish_brew_2", },
	{ "lottweapons:orc_sword", },
	{ "bones:bone", 3 },
	{ "lottarmor:helmet_bronze", },
	{ "lottarmor:chestplate_bronze", },
	{ "lottarmor:leggings_bronze", },
	{ "lottarmor:boots_bronze", },
	{ "lord_alcohol:beer", },
	{ "lottmobs:meat_raw", },
	{ "bones:skeleton_body", },
	{ "lottweapons:steel_warhammer", },
	{ "lottfarming:blue_mushroom_spore", 2 },
	{ "lottmobs:horsearah1", },
	{ "lottores:red_gem", },
	{ "lottfarming:orc_food", 4 },
	{ "lottfarming:orc_medicine", 2 },
})

register_chest_spawner("lord_chests:racial_angmar", {
	{ "lottmapgen:angsnowblock", 3 },
	{ "lottblocks:orc_brick", 7 },
	{ "lottother:orc_torch", 4 },
	{ "lottmobs:meat", 5 },
	{ "lottfarming:blue_mushroom", },
	{ "lottfarming:green_mushroom", },
	{ "lord_archery:birch_wood_bow", },
	{ "lord_projectiles:flint_arrow", 15 },
	{ "lord_potions:athelas_elixir_1", 2 },
	{ "lottweapons:steel_battleaxe", },
	{ "lord_alcohol:wine", },
	{ "lord_potions:orcish_brew_1", 2 },
	{ "lottweapons:steel_battleaxe", },
	{ "lottweapons:orc_sword", },
	{ "bones:bone", 3 },
	{ "lottarmor:helmet_steel", },
	{ "lottarmor:chestplate_steel", },
	{ "lottarmor:leggings_steel", },
	{ "lottarmor:boots_steel", },
	{ "lord_alcohol:beer", },
	{ "lottmobs:meat_raw", },
	{ "bones:skeleton_body", },
	{ "lottweapons:steel_warhammer", },
	{ "default:sword_steel", },
	{ "lottmobs:horsepegh1", },
	{ "bones:bones", },
	{ "lottfarming:orc_food", 4 },
	{ "lottfarming:orc_medicine", 2 },
})

register_chest_spawner("lord_chests:racial_dwarf", {
	{ "lord_alcohol:beer", 1, 10 },
	{ "lord_alcohol:wine", 2, 6 },
	{ "lord_alcohol:mead", 2, 4 },
	{ "lord_alcohol:ale", 1, 15 },
	{ "lottores:mithril_lump", 2 },
	{ "lottores:galvorn_ingot", 3 },
	{ "default:iron_lump", 10, 20 },
	{ "default:steel_ingot", 5, 15 },
	{ "lottores:tin_lump", 5, 10 },
	{ "default:copper_lump", 5, 10 },
	{ "lord_planks:alder", 13 },
	{ "lottores:ithildin_stone_1", 2, 4 },
	{ "lottores:ithildin_stonelamp_1", 4, 6 },
	{ "lord_archery:galvorn_throwing_axe" },
	{ "lord_archery:steel_throwing_axe" },
	{ "lord_archery:alder_wood_bow" },
	{ "lord_projectiles:steel_arrow", 5, 20 },
	{ "tools:sword_gold" },
	{ "tools:spear_gold" },
	{ "lottarmor:chestplate_gold" },
	{ "lottarmor:helmet_gold" },
	{ "lottarmor:leggings_gold" },
	{ "lottarmor:boots_gold" },
	{ "lottarmor:shield_gold" },
	{ "default:gold_lump", 4, 10 },
	{ "default:gold_ingot", 1, 5 },
	{ "lord_archery:gold_crossbow" },
	{ "lord_projectiles:steel_bolt", 5, 20 },
	{ "lottblocks:dwarfstone_black", 10, 20 },
	{ "lottblocks:dwarfstone_white", 10, 20 },
	{ "lottmobs:meat", 1, 7 },
	{ "farming:bread", 2, 10 },
	-- это книги, которые есть в LOTT, но нет у нас:
	--{ "lottblocks:deep_depths" },
	--{ "lottblocks:miner_handbook" },
	--{ "lottblocks:miner_handbook_2" },
	--{ "lottblocks:miner_handbook_3" },
})
