

-- default/chests.lua

-- Нам нужно только подсунуть свой фон (background), но для этого приходится переопределить ф-цию:
local old_chest_get_chest_formspec = default.chest.get_chest_formspec
default.chest.get_chest_formspec = function(pos)
	return old_chest_get_chest_formspec(pos) .. "background[-0.5,-0.65;9,10.35;gui_chestbg.png]"
end




-- default/furnace.lua

-- Нам нужно только подсунуть свой фон
local old_get_furnace_active_formspec = default.get_furnace_active_formspec
local old_get_furnace_inactive_formspec = default.get_furnace_inactive_formspec
default.get_furnace_active_formspec = function(fuel_percent, item_percent)
	return old_get_furnace_active_formspec(fuel_percent, item_percent) ..
		"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"
end
default.get_furnace_inactive_formspec = function()
	return old_get_furnace_inactive_formspec() ..
		"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"
end




-- default/tools.lua

-- свои кирки, лопаты, топоры, мечи и пр. мы определяем в моде `lord/tools/`,
-- поэтому тут мы подчищаем все эти тулзы из `MTG/default`
--
-- (!) сделано без циклов, чтобы выдавалось в поиске по проекту

minetest.clear_craft({output = "default:pick_wood"})
minetest.clear_craft({output = "default:pick_stone"})
minetest.clear_craft({output = "default:pick_bronze"})
minetest.clear_craft({output = "default:pick_steel"})
minetest.clear_craft({output = "default:pick_mese"})
minetest.clear_craft({output = "default:pick_diamond"})
minetest.unregister_item("default:pick_wood")
minetest.unregister_item("default:pick_stone")
minetest.unregister_item("default:pick_bronze")
minetest.unregister_item("default:pick_steel")
minetest.unregister_item("default:pick_mese")
minetest.unregister_item("default:pick_diamond")

minetest.clear_craft({output = "default:shovel_wood"})
minetest.clear_craft({output = "default:shovel_stone"})
minetest.clear_craft({output = "default:shovel_bronze"})
minetest.clear_craft({output = "default:shovel_steel"})
minetest.clear_craft({output = "default:shovel_mese"})
minetest.clear_craft({output = "default:shovel_diamond"})
minetest.unregister_item("default:shovel_wood")
minetest.unregister_item("default:shovel_stone")
minetest.unregister_item("default:shovel_bronze")
minetest.unregister_item("default:shovel_steel")
minetest.unregister_item("default:shovel_mese")
minetest.unregister_item("default:shovel_diamond")

minetest.clear_craft({output = "default:axe_wood"})
minetest.clear_craft({output = "default:axe_stone"})
minetest.clear_craft({output = "default:axe_bronze"})
minetest.clear_craft({output = "default:axe_steel"})
minetest.clear_craft({output = "default:axe_mese"})
minetest.clear_craft({output = "default:axe_diamond"})
minetest.unregister_item("default:axe_wood")
minetest.unregister_item("default:axe_stone")
minetest.unregister_item("default:axe_bronze")
minetest.unregister_item("default:axe_steel")
minetest.unregister_item("default:axe_mese")
minetest.unregister_item("default:axe_diamond")

minetest.clear_craft({output = "default:sword_wood"})
minetest.clear_craft({output = "default:sword_stone"})
minetest.clear_craft({output = "default:sword_bronze"})
minetest.clear_craft({output = "default:sword_steel"})
minetest.clear_craft({output = "default:sword_mese"})
minetest.clear_craft({output = "default:sword_diamond"})
minetest.unregister_item("default:sword_wood")
minetest.unregister_item("default:sword_stone")
minetest.unregister_item("default:sword_bronze")
minetest.unregister_item("default:sword_steel")
minetest.unregister_item("default:sword_mese")
minetest.unregister_item("default:sword_diamond")




-- default/craftitems.lua

-- в `lord/lord_mail/` мы создаём свою "книгу с текстом"
minetest.clear_craft({type = "fuel", recipe = "default:book_written"})
minetest.unregister_item("default:book_written")
-- у нас другой крафт бронзы
minetest.clear_craft({recipe = {
	{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	{"default:copper_ingot", "default:tin_ingot", "default:copper_ingot"},
	{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
}});
minetest.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot",
	recipe = {"lottores:tin_ingot", "default:copper_ingot"},
})
-- в `_lott/lottores` своё олово (видимо в MTG оно появилось позже)
minetest.clear_craft({type = "cooking", recipe = "default:tin_lump"})
minetest.clear_craft({recipe = {{"default:tinblock"}}}) -- `lottores:tin_block`
minetest.unregister_item("default:tin_ingot")
minetest.unregister_item("default:tin_lump")




-- default/crafting.lua

-- в LOTT (`lottplants/nodes.lua`) была изначально своя сосна (`lottplants:pinewood`)
minetest.clear_craft({recipe = {{"default:pine_tree"}}})

-- Были добавлены в MTG, но у нас не используются (пока выпиливаем):
minetest.clear_craft({recipe = {{"default:acacia_tree"}}})
minetest.clear_craft({recipe = {{"default:aspen_tree"}}})
--minetest.clear_craft({recipe = {{"default:bush_stem"}}})
minetest.clear_craft({recipe = {{"default:acacia_bush_stem"}}})
minetest.clear_craft({recipe = {{"default:pine_bush_stem"}}})

-- наши знаки намного лучше
minetest.clear_craft({output = "default:sign_wall_steel"})

-- в `_lott/lottores` своё олово (видимо в MTG оно появилось позже)
minetest.clear_craft({output = "default:tinblock"}) -- `lottores:tin_block`

-- `silver_sand` не генерируется нашим map-генератором (`mods/_lott/lottmapgen`)
minetest.clear_craft({output = "default:silver_sand"})
minetest.clear_craft({output = "default:silver_sandstone"})
minetest.clear_craft({output = "default:silver_sandstone_brick"})
minetest.clear_craft({output = "default:silver_sandstone_block"})

-- мы не можем делать лестницу из любой палочки, т.к. в `lottblocks` добавляются разные лестницы из разных палочек
minetest.clear_craft({output = "default:ladder_wood"})
minetest.register_craft({
	output = "default:ladder_wood 7", -- у нас выдаёт 7 штук, вместо 5-ти как в MTG
	recipe = {
		{"default:stick", "", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})
-- `castle:jailbars` имеют такой же крафт, как `default:ladder_steel`
minetest.clear_craft({output = "default:ladder_steel"})

-- не известно как выглядит дерево из этого саженца, скорее всего не подходит по стилистике, пока удаляем
minetest.clear_craft({output = "default:emergent_jungle_sapling"}) -- в MTG можно только скрафтить

-- наш вариант как скрафтить землю (видать попытка сделать землю воспроизводимой нодой)
minetest.register_craft({
	type = "shapeless",
	output = "default:dirt",
	recipe = {"group:leaves", "group:leaves", "default:clay", "default:sand"},
})

-- наши дополнительные крафты:
minetest.register_craft({
	type = "cooking",
	output = "default:cobble",
	recipe = "default:gravel",
})
minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "group:steel_item",
})
minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "group:copper_item",
})
minetest.register_craft({
	type = "cooking",
	output = "default:bronze_ingot",
	recipe = "group:bronze_item",
})
minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "group:gold_item",
})

-- Оставляем наше время горения дабы не нарушить баланс
-- (позже можно перебалансировать, учесть остальное топливо, напр. charcoal):
minetest.clear_craft({type = "fuel", recipe = "group:tree"})
minetest.clear_craft({type = "fuel", recipe = "default:aspen_tree"}) -- добавлены в MTG, но у нас не используются
minetest.clear_craft({type = "fuel", recipe = "default:pine_tree"})
minetest.clear_craft({type = "fuel", recipe = "default:acacia_tree"}) -- добавлены в MTG, но у нас не используются
minetest.clear_craft({type = "fuel", recipe = "default:jungletree"})
minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 15,
})
minetest.clear_craft({type = "fuel", recipe = "group:wood"})
minetest.clear_craft({type = "fuel", recipe = "default:aspen_wood"}) -- добавлены в MTG, но у нас не используются
minetest.clear_craft({type = "fuel", recipe = "default:pine_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:acacia_wood"}) -- добавлены в MTG, но у нас не используются
minetest.clear_craft({type = "fuel", recipe = "default:junglewood"})
minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 10,
})
