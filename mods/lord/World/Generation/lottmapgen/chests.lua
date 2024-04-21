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
	local chest_basename = chest_name:sub(string.find(chest_name, ":")+1)
	local chest_spawner_basename = chest_basename .. "_spawner" -- используется в качестве описания ноды
	local chest_spawner_name = "lottmapgen:" .. chest_spawner_basename

	minetest.register_node(chest_spawner_name, {
		description = chest_spawner_basename,
		tiles = {"lottblocks_elf_chest_bottom.png"},
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



register_chest_spawner("lottblocks:hobbit_chest", {
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

register_chest_spawner("lottblocks:gondor_chest", {
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
	{ "lottpotion:beer", 10 },
	{ "lottpotion:cider", 10 },
	{ "lottpotion:wine", 5 },
	{ "lottpotion:wine", 2 },
	{ "lottthrowing:bow_wood_alder" },
})

register_chest_spawner("lottblocks:rohan_chest", {
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
	{ "lottpotion:ale", 7 },
	{ "lottpotion:mead", 7 },
	{ "lottpotion:wine", 5 },
	{ "lottpotion:cider", 2 },
	{ "lottmobs:horseh1", },
	{ "lottmobs:horsepegh1", },
	{ "lottmobs:horsepegh1", },
	{ "lottthrowing:crossbow_tin", },
	{ "lottthrowing:bolt", 5 },
})

register_chest_spawner("lottblocks:elfloth_chest", {
	{ "lottores:mithril_ingot", },
	{ "default:gold_ingot", 3 },
	{ "lottweapons:elven_sword", },
	{ "lottblocks:door_mallorn", },
	{ "beds:bed", },
	{ "lottblocks:fence_mallorn", 3 },
	{ "lottblocks:mallorn_table", },
	{ "lottarmor:helmet_gold", },
	{ "lottblocks:mallorn_chair", },
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
	{ "lottpotion:mead", 6 },
	{ "lottplants:honey", 5 },
	{ "lottpotion:athelasbrew_power1", },
	{ "lottmobs:horsepegh1", },
	{ "lottpotion:athelasbrew_power1", },
	{ "lottthrowing:bow_wood_mallorn", },
	{ "lottthrowing:arrow", 20 },
	{ "lottpotion:miruvor_power2_arrow", },
	{ "lottpotion:athelasbrew_power1_arrow", 3 },
	{ "lottother:blue_torch", 10 },
	{ "lottores:white_gem", },
})

register_chest_spawner("lottblocks:elfmirk_chest", {
	{ "lottores:galvorn_ingot", 3 },
	{ "lottores:tin_ingot", 5 },
	{ "lottweapons:elven_sword", },
	{ "lottblocks:door_alder", },
	{ "beds:bed", },
	{ "lottblocks:fence_alder", 5 },
	{ "lottblocks:lebethron_table", },
	{ "lottarmor:helmet_gold", },
	{ "lottblocks:lebethron_chair", },
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
	{ "lottthrowing:arrow", 7 },
	{ "lottpotion:miruvor_power2_arrow", },
	{ "lottpotion:athelasbrew_power1_arrow", 3 },
	{ "lottthrowing:bow_wood_lebethron", },
	{ "lottores:blue_gem", },
	{ "farming:hoe_bronze", },
})

register_chest_spawner("lottblocks:mordor_chest", {
	{ "lottmapgen:mordor_stone", 6 },
	{ "lottblocks:orc_brick", 7 },
	{ "lottother:orc_torch", 4 },
	{ "lottmobs:meat", 5 },
	{ "lottfarming:blue_mushroom", },
	{ "lottfarming:green_mushroom", },
	{ "lottthrowing:crossbow_steel", },
	{ "lottthrowing:bolt", 15 },
	{ "lottthrowing:bolt", 2 },
	{ "lottpotion:wine", },
	{ "lottpotion:orcdraught_power1", 2 },
	{ "lottpotion:orcdraught_power2", },
	{ "lottweapons:orc_sword", },
	{ "bones:bone", 3 },
	{ "lottarmor:helmet_bronze", },
	{ "lottarmor:chestplate_bronze", },
	{ "lottarmor:leggings_bronze", },
	{ "lottarmor:boots_bronze", },
	{ "lottpotion:beer", },
	{ "lottmobs:meat_raw", },
	{ "bones:skeleton_body", },
	{ "lottweapons:steel_warhammer", },
	{ "lottfarming:blue_mushroom_spore", 2 },
	{ "lottmobs:horsearah1", },
	{ "lottores:red_gem", },
	{ "lottfarming:orc_food", 4 },
	{ "lottfarming:orc_medicine", 2 },
})

register_chest_spawner("lottblocks:angmar_chest", {
	{ "lottmapgen:angsnowblock", 3 },
	{ "lottblocks:orc_brick", 7 },
	{ "lottother:orc_torch", 4 },
	{ "lottmobs:meat", 5 },
	{ "lottfarming:blue_mushroom", },
	{ "lottfarming:green_mushroom", },
	{ "lottthrowing:bow_wood_birch", },
	{ "lottthrowing:arrow", 15 },
	{ "lottpotion:athelasbrew_power1_arrow", 2 },
	{ "lottweapons:steel_battleaxe", },
	{ "lottpotion:wine", },
	{ "lottpotion:orcdraught_power1", 2 },
	{ "lottweapons:steel_battleaxe", },
	{ "lottweapons:orc_sword", },
	{ "bones:bone", 3 },
	{ "lottarmor:helmet_steel", },
	{ "lottarmor:chestplate_steel", },
	{ "lottarmor:leggings_steel", },
	{ "lottarmor:boots_steel", },
	{ "lottpotion:beer", },
	{ "lottmobs:meat_raw", },
	{ "bones:skeleton_body", },
	{ "lottweapons:steel_warhammer", },
	{ "default:sword_steel", },
	{ "lottmobs:horsepegh1", },
	{ "bones:bones", },
	{ "lottfarming:orc_food", 4 },
	{ "lottfarming:orc_medicine", 2 },
})

register_chest_spawner("lottblocks:dwarf_chest", {
	{ "lottpotion:beer", 1, 10 },
	{ "lottpotion:wine", 2, 6 },
	{ "lottpotion:mead", 2, 4 },
	{ "lottpotion:ale", 1, 15 },
	{ "lottores:mithril_lump", 2 },
	{ "lottores:galvorn_ingot", 3 },
	{ "default:iron_lump", 10, 20 },
	{ "default:steel_ingot", 5, 15 },
	{ "lottores:tin_lump", 5, 10 },
	{ "default:copper_lump", 5, 10 },
	{ "lottplants:alderwood", 13 },
	{ "lottores:ithildin_stone_1", 2, 4 },
	{ "lottores:ithildin_stonelamp_1", 4, 6 },
	{ "arrows:axe_dwarf", 1, 4 },
	{ "arrows:axe_steel", 1, 6 },
	{ "lottthrowing:bow_wood_alder" },
	{ "arrows:arrow_steel", 5, 20 },
	{ "tools:sword_gold" },
	{ "tools:spear_gold" },
	{ "lottarmor:chestplate_gold" },
	{ "lottarmor:helmet_gold" },
	{ "lottarmor:leggings_gold" },
	{ "lottarmor:boots_gold" },
	{ "lottarmor:shield_gold" },
	{ "default:gold_lump", 4, 10 },
	{ "default:gold_ingot", 1, 5 },
	{ "lottthrowing:crossbow_gold" },
	{ "lottthrowing:bolt", 5, 20 },
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
