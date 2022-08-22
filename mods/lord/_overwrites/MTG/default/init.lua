local S = default.get_translator
local S2 = minetest.get_translator(minetest.get_current_modname()) -- для фикса локализации

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
minetest.clear_craft({recipe = {{"default:bush_stem"}}})
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
-- tree fuels:
minetest.clear_craft({type = "fuel", recipe = "group:tree"})
minetest.clear_craft({type = "fuel", recipe = "default:aspen_tree"}) -- добавлены в MTG, но у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:pine_tree"}) -- в lottplants своя
minetest.clear_craft({type = "fuel", recipe = "default:acacia_tree"}) -- добавлены в MTG, но у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:jungletree"})
minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 15,
})
-- wood fuels:
minetest.clear_craft({type = "fuel", recipe = "group:wood"})
minetest.clear_craft({type = "fuel", recipe = "default:aspen_wood"}) -- добавлены в MTG, но у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:pine_wood"}) -- в lottplants своя
minetest.clear_craft({type = "fuel", recipe = "default:acacia_wood"}) -- добавлены в MTG, но у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:junglewood"})
minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 10,
})
-- sapling fuels:
-- сами саженцы не выглядят не сбалансировано, но их у нас нет (пока выпиливаем):
minetest.clear_craft({type = "fuel", recipe = "default:bush_sapling"}) -- добавлены в MTG, но у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:acacia_bush_sapling"}) -- добавлены в MTG, у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:pine_bush_sapling"}) -- добавлены в MTG, у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:aspen_sapling"}) -- добавлены в MTG, у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:pine_sapling"}) -- добавлены в MTG, у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:acacia_sapling"}) -- добавлены в MTG, у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:junglesapling"}) -- добавлены в MTG, у нас не используется
minetest.clear_craft({type = "fuel", recipe = "default:emergent_jungle_sapling"}) -- добавлены в MTG, у нас нет
-- fence fuels:
-- в lottblocks свои заборы, а остальных у нас нет, придётся выпилить все
minetest.clear_craft({type = "fuel", recipe = "default:fence_aspen_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_pine_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_wood"}) -- является wooden
minetest.clear_craft({type = "fuel", recipe = "default:fence_acacia_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_junglewood"})
-- fence rail fuels:
minetest.clear_craft({type = "fuel", recipe = "default:fence_rail_aspen_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_rail_pine_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_rail_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_rail_acacia_wood"})
minetest.clear_craft({type = "fuel", recipe = "default:fence_rail_junglewood"})
-- bush fuels:
minetest.clear_craft({type = "fuel", recipe = "default:bush_stem"})
minetest.clear_craft({type = "fuel", recipe = "default:acacia_bush_stem"})
minetest.clear_craft({type = "fuel", recipe = "default:pine_bush_stem"})
-- other fuels:
minetest.clear_craft({type = "fuel", recipe = "default:junglegrass"}) -- нигде не генерится ? или ?

-- наше дополнительное топливо:
minetest.register_craft({
	type = "fuel",
	recipe = "group:paper",
	burntime = 2,
})
minetest.register_craft({
	type = "fuel",
	recipe = "group:grass",
	burntime = 3,
})
minetest.register_craft({
	type = "fuel",
	recipe = "group:wool",
	burntime = 1,
})
minetest.register_craft({
	type = "fuel",
	recipe = "group:wooden",
	burntime = 5,
})



-- default/nodes.lua

minetest.unregister_item("default:silver_sandstone")
minetest.unregister_item("default:silver_sandstone_brick")
minetest.unregister_item("default:silver_sandstone_block")
-- Временно закомментировано. Это неободимо для работы Farming.
-- Если будет возможно — исправим и восстановим эти строки.
-- Если нет — удалим "с корнем".
--[[
minetest.unregister_item("default:dirt_with_dry_grass")
minetest.unregister_item("default:dirt_with_rainforest_litter")
minetest.unregister_item("default:dirt_with_coniferous_litter")
minetest.unregister_item("default:dry_dirt")
minetest.unregister_item("default:dry_dirt_with_dry_grass")
]]
minetest.unregister_item("default:permafrost")
minetest.unregister_item("default:permafrost_with_stones")
minetest.unregister_item("default:permafrost_with_moss")
minetest.unregister_item("default:silver_sand")
minetest.unregister_item("default:cave_ice")
minetest.unregister_item("default:emergent_jungle_sapling")
minetest.unregister_item("default:pine_tree")
minetest.unregister_item("default:pine_wood")
minetest.unregister_item("default:pine_needles")
minetest.unregister_item("default:pine_sapling")
minetest.unregister_item("default:acacia_tree")
minetest.unregister_item("default:acacia_wood")
minetest.unregister_item("default:acacia_leaves")
minetest.unregister_item("default:acacia_sapling")
minetest.unregister_item("default:aspen_tree")
minetest.unregister_item("default:aspen_wood")
minetest.unregister_item("default:aspen_leaves")
minetest.unregister_item("default:aspen_sapling")
minetest.unregister_item("default:stone_with_tin")
minetest.unregister_item("default:tinblock")
minetest.unregister_item("default:bush_stem")
minetest.unregister_item("default:bush_sapling")
minetest.unregister_item("default:bush_leaves")
minetest.unregister_item("default:acacia_bush_stem")
minetest.unregister_item("default:acacia_bush_leaves")
minetest.unregister_item("default:acacia_bush_sapling")
minetest.unregister_item("default:pine_bush_stem")
minetest.unregister_item("default:pine_bush_needles")
minetest.unregister_item("default:pine_bush_sapling")
minetest.unregister_item("default:blueberry_bush_leaves_with_berries")
minetest.unregister_item("default:blueberry_bush_leaves")
minetest.unregister_item("default:blueberry_bush_sapling")
minetest.unregister_item("default:sand_with_kelp")
minetest.unregister_item("default:coral_green")
minetest.unregister_item("default:coral_pink")
minetest.unregister_item("default:coral_cyan")
minetest.unregister_item("default:coral_brown")
minetest.unregister_item("default:coral_orange")
minetest.unregister_item("default:coral_skeleton")
minetest.unregister_item("default:sign_wall_wood")
minetest.unregister_item("default:sign_wall_steel")
minetest.unregister_item("default:fence_acacia_wood")
minetest.unregister_item("default:fence_pine_wood")
minetest.unregister_item("default:fence_aspen_wood")
minetest.unregister_item("default:fence_rail_acacia_wood")
minetest.unregister_item("default:fence_rail_pine_wood")
minetest.unregister_item("default:fence_rail_aspen_wood")
minetest.unregister_item("default:mese_post_light")
minetest.unregister_item("default:mese_post_light_acacia_wood")
minetest.unregister_item("default:mese_post_light_junglewood")
minetest.unregister_item("default:mese_post_light_pine_wood")
minetest.unregister_item("default:mese_post_light_aspen_wood")


-- Наши моделька и интерфейс книжной полки

local bookshelf_formspec =
	"size[8,9]" ..
	"list[context;books;0,0;8,2;]" ..
	"list[current_player;main;0,5;8,4;]" ..
	"listring[context;books]" ..
	"listring[current_player;main]" ..
	"background[-0.5,-0.65;9,10.35;gui_chestbg.png]" ..
"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

-- Функция использовалась для другого, но я ее порезал, при этом
-- решив оставить функцией, а не распихивать по коллбэкам
local function update_bookshelf(pos)
	local meta = minetest.get_meta(pos)

	meta:set_string("formspec", bookshelf_formspec)
	meta:set_string("infotext", S("Bookshelf"))
end

minetest.override_item("default:bookshelf", {
	drawtype = "mesh",
	mesh = "3dbookshelf.obj",
	tiles = {
		"default_wood.png",
		"default_wood.png^3dbookshelf_inside_back.png",
		"3dbookshelf_books.png",
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
		update_bookshelf(pos)
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		update_bookshelf(pos)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" puts stuff to bookshelf at " .. minetest.pos_to_string(pos))
		update_bookshelf(pos)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		update_bookshelf(pos)
	end,
})

-- Кактус

minetest.override_item("default:cactus", {
	drawtype = "nodebox",
	tiles = {"default_cactus_top.png", "default_cactus_bottom.png", "default_cactus_side.png",
	"default_cactus_side.png","default_cactus_side.png","default_cactus_side.png"},
	use_texture_alpha = "clip",
	groups = {snappy = 1, choppy = 3, flammable = 2, plant = 1, oddly_breakable_by_hand = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	paramtype2 = "none",
	sunlight_propagates = false,
	--node_placement_prediction = "",
	drop = "flowers:cactus_decor",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, -8/16, -7/16,  7/16, 8/16,  7/16}, -- Main body
			{-8/16, -8/16, -7/16,  8/16, 8/16, -7/16}, -- Spikes
			{-8/16, -8/16,  7/16,  8/16, 8/16,  7/16}, -- Spikes
			{-7/16, -8/16, -8/16, -7/16, 8/16,  8/16}, -- Spikes
			{7/16,  -8/16,  8/16,  7/16, 8/16, -8/16}, -- Spikes
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {-7/16, -8/16, -7/16,  7/16, 7/16,  7/16}, -- Main body
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-7/16, -8/16, -7/16, 7/16, 8/16, 7/16},
		},
	},
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
	on_place = nil,
})

minetest.clear_craft({output = "default:large_cactus_seedling"})

-- Перезапись функции роста большого кактуса на пустую

function default.grow_large_cactus(pos)
	return nil
end

-- Ньян-кот

minetest.register_node(":default:nyancat", {
	description = S("Nyan Cat"),
	tiles = {"default_nc_side.png", "default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
	 "default_nc_back.png", "default_nc_front.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	legacy_facedir_simple = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_node(":default:nyancat_rainbow", {
	description = S("Nyan Cat Rainbow"),
	tiles = {"default_nc_rb.png^[transformR90", "default_nc_rb.png^[transformR90",
	 "default_nc_rb.png", "default_nc_rb.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
})

-- Перезапись листвы ради модельки и возможности карабкаться

minetest.override_item("default:leaves", {
	drawtype = "mesh",
	mesh = "leaves_model.obj",
	tiles = {"default_leaves.png"},
	use_texture_alpha = "clip",
	inventory_image = "default_leaves_inv.png",
	waving = 2,
	walkable = false,
	climbable = true,
})

minetest.override_item("default:jungleleaves", {
	drawtype = "mesh",
	mesh = "leaves_model.obj",
	tiles = {"default_jungleleaves.png"},
	use_texture_alpha = "clip",
	inventory_image = "default_jungleleaves_inv.png",
	waving = 2,
	walkable = false,
	climbable = true,
})

-- Какие-то брёвна...
-- Честно, понятия не имею, для чего они нужны, когда есть
-- default:tree и default:jungletree.

-- На всякий случай вынес их, вместо того чтобы регистровать alias
-- с default:tree и default:jungletree.

minetest.register_node(":default:tree_trunk", {
	description = S("Tree Тrunk"),
	tiles = { "default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "default:tree",
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

minetest.register_node(":default:jungletree_trunk", {
	description = S2("Jungle Tree Trunk"),
	tiles = {"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "default:jungletree",
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

-- Включение возможности падения стволов деревьев

minetest.override_item("default:tree", {
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "default:tree", digger, 20, 2, "default:tree")
	end,
})

minetest.override_item("default:jungletree", {
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "default:jungletree", digger, 20, 2, "default:jungletree")
	end,
})


-- default/functions.lua


-- Падение ствола деревьев вниз при ломании

local falling_trees = minetest.settings:get_bool("falling_trees")

if not falling_trees then
	if minetest.is_singleplayer() then
		falling_trees = false
	else
		falling_trees = true
	end
end

if falling_trees == true then
	function default.dig_tree(pos, node, name, digger, height, radius, drop)
		minetest.node_dig(pos, node, digger)

		if minetest.is_protected(pos, digger:get_player_name()) then
			return
		end

		local base_y = pos.y
		for i = 1, (height + 5) do
			pos.y        = base_y + i
			local node_i = minetest.get_node(pos)
			if node_i.name ~= name or i == (height + 5) then
				minetest.remove_node({ x = pos.x, y = pos.y - 1, z = pos.z })
				for k = -radius, radius do
					for l = -radius, radius do
						for j = 0, 1 do
							local tree_bellow = minetest.get_node({ x = pos.x + k, y = pos.y - 1, z = pos.z + l })
							if tree_bellow.name ~= name then
								local pos1 = { x = pos.x + k, y = pos.y + j, z = pos.z + l }
								if minetest.get_node(pos1).name == name then
									minetest.spawn_item(pos1, drop)
									minetest.remove_node(pos1)
								end
							end
						end
					end
				end
				return
			elseif node_i.name == name then
				minetest.set_node({ x = pos.x, y = pos.y - 1, z = pos.z }, { name = name })
			end
		end
	end
else
	function default.dig_tree(pos, node, name, digger, height, radius, drop)
		minetest.node_dig(pos, node, digger)
		return nil
	end
end

local function grow_papyrus_but_on_soils(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name

	-- HACK: There's another, non-overridable ABM in minetest_game that grows
	-- papyrus on these nodes. They're explicitly excluded from this ABM to
	-- keep growth chances equal.
	local is_growing_in_mtg =
		name == "default:dirt" or
		name == "default:dirt_with_grass" or
		name == "default:dirt_with_dry_grass" or
		name == "default:dirt_with_rainforest_litter" or
		name == "default:dry_dirt" or
		name == "default:dry_dirt_with_dry_grass"

	local is_soil = minetest.get_item_group(name, "soil") ~= 0

	-- Technically sand isn't soil, but it's required to keep compatibility
	if (not is_soil and name ~= "default:sand") or is_growing_in_mtg then
		return
	end
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "default:papyrus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "default:papyrus"})
	return true
end

minetest.register_abm({
	label = "Grow papyrus, but on the rest of soils",
	nodenames = {"default:papyrus"},
	neighbors = {"group:soil", "default:sand"},
	interval = 14,
	chance = 71,
	action = function(...)
		grow_papyrus_but_on_soils(...)
	end
})

-- Фикс локализации эвкалипта
minetest.override_item("default:jungletree", {
	description = S2("Jungle Tree"),
})
minetest.override_item("default:junglewood", {
	description = S2("Jungle Wood"),
})

-- Фикс локализации заборов
minetest.override_item("default:fence_junglewood", {
	description = S2("Junglewood Fence")
})
minetest.override_item("default:fence_rail_junglewood", {
	description = S2("Junglewood Fence Rail")
})
minetest.override_item("default:fence_wood", {
	description = S2("Wooden Fence")
})
minetest.override_item("default:fence_rail_wood", {
	description = S2("Wooden Fence Rail")
})
