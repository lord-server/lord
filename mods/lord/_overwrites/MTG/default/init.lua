local S = core.get_mod_translator()

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

core.clear_craft({output = "default:pick_wood"})
core.clear_craft({output = "default:pick_stone"})
core.clear_craft({output = "default:pick_bronze"})
core.clear_craft({output = "default:pick_steel"})
core.clear_craft({output = "default:pick_mese"})
core.clear_craft({output = "default:pick_diamond"})
core.unregister_item("default:pick_wood")
core.unregister_item("default:pick_stone")
core.unregister_item("default:pick_bronze")
core.unregister_item("default:pick_steel")
core.unregister_item("default:pick_mese")
core.unregister_item("default:pick_diamond")

core.clear_craft({output = "default:shovel_wood"})
core.clear_craft({output = "default:shovel_stone"})
core.clear_craft({output = "default:shovel_bronze"})
core.clear_craft({output = "default:shovel_steel"})
core.clear_craft({output = "default:shovel_mese"})
core.clear_craft({output = "default:shovel_diamond"})
core.unregister_item("default:shovel_wood")
core.unregister_item("default:shovel_stone")
core.unregister_item("default:shovel_bronze")
core.unregister_item("default:shovel_steel")
core.unregister_item("default:shovel_mese")
core.unregister_item("default:shovel_diamond")

core.clear_craft({output = "default:axe_wood"})
core.clear_craft({output = "default:axe_stone"})
core.clear_craft({output = "default:axe_bronze"})
core.clear_craft({output = "default:axe_steel"})
core.clear_craft({output = "default:axe_mese"})
core.clear_craft({output = "default:axe_diamond"})
core.unregister_item("default:axe_wood")
core.unregister_item("default:axe_stone")
core.unregister_item("default:axe_bronze")
core.unregister_item("default:axe_steel")
core.unregister_item("default:axe_mese")
core.unregister_item("default:axe_diamond")

core.clear_craft({output = "default:sword_wood"})
core.clear_craft({output = "default:sword_stone"})
core.clear_craft({output = "default:sword_bronze"})
core.clear_craft({output = "default:sword_steel"})
core.clear_craft({output = "default:sword_mese"})
core.clear_craft({output = "default:sword_diamond"})
core.unregister_item("default:sword_wood")
core.unregister_item("default:sword_stone")
core.unregister_item("default:sword_bronze")
core.unregister_item("default:sword_steel")
core.unregister_item("default:sword_mese")
core.unregister_item("default:sword_diamond")

-- Remove junglesapling and jungleleaves
core.unregister_item("default:junglesapling")
core.unregister_item("default:jungleleaves")

core.register_lbm({
	name = "lord_overwrites_mtg_default:remove_junglesapling",
	nodenames = {"default:junglesapling"},
	action = function(pos, node)
		core.set_node(pos, {name = "lord_trees:mirk_sapling"})
	end
})

core.register_lbm({
	name = "lord_overwrites_mtg_default:remove_jungleleaves",
	nodenames = {"default:jungleleaves"},
	action = function(pos, node)
		core.set_node(pos, {name = "lord_trees:mirk_leaf"})
	end
})

-- default/craftitems.lua

-- в `lord/lord_mail/` мы создаём свою "книгу с текстом"
core.clear_craft({type = "fuel", recipe = "default:book_written"})
core.unregister_item("default:book_written")
-- у нас другой крафт бронзы
core.clear_craft({recipe = {
	{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	{"default:copper_ingot", "default:tin_ingot", "default:copper_ingot"},
	{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
}});
core.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot 2",
	recipe = {"lottores:tin_ingot", "default:copper_ingot"},
})
-- в `_lott/lottores` своё олово (видимо в MTG оно появилось позже)
core.clear_craft({type = "cooking", recipe = "default:tin_lump"})
core.clear_craft({recipe = {{"default:tinblock"}}}) -- `lottores:tin_block`
core.unregister_item("default:tin_ingot")
core.unregister_item("default:tin_lump")
-- у нас из разных пород разные палочки
core.clear_craft({recipe = { {"group:wood"}, }})
core.register_craft({
	output = "default:stick 4",
	recipe = { {"default:wood"}, }
})



-- default/crafting.lua

-- в LOTT (сейчас `lord_trees/src/trunks.lua`)
--    была изначально своя сосна (`lottplants:pinetree`, сейчас `lord_trees:pine_tree`)
core.clear_craft({recipe = {{"default:pine_tree"}}})

-- Были добавлены в MTG, но у нас не используются (пока выпиливаем):
core.clear_craft({recipe = {{"default:acacia_tree"}}})
core.clear_craft({recipe = {{"default:aspen_tree"}}})
core.clear_craft({recipe = {{"default:bush_stem"}}})
core.clear_craft({recipe = {{"default:acacia_bush_stem"}}})
core.clear_craft({recipe = {{"default:pine_bush_stem"}}})

-- наши знаки намного лучше
core.clear_craft({output = "default:sign_wall_wood"})
core.clear_craft({output = "default:sign_wall_steel"})

-- в `_lott/lottores` своё олово (видимо в MTG оно появилось позже)
core.clear_craft({output = "default:tinblock"}) -- `lottores:tin_block`

-- мы не можем делать лестницу из любой палочки, т.к. в `lottblocks` добавляются разные лестницы из разных палочек
core.clear_craft({output = "default:ladder_wood"})
core.register_craft({
	output = "default:ladder_wood 7", -- у нас выдаёт 7 штук, вместо 5-ти как в MTG
	recipe = {
		{"default:stick", "", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})
-- `castle:jailbars` имеют такой же крафт, как `default:ladder_steel`
core.clear_craft({output = "default:ladder_steel"})

-- не известно как выглядит дерево из этого саженца, скорее всего не подходит по стилистике, пока удаляем
core.clear_craft({output = "default:emergent_jungle_sapling"}) -- в MTG можно только скрафтить

-- наш вариант как скрафтить землю (видать попытка сделать землю воспроизводимой нодой)
core.register_craft({
	type = "shapeless",
	output = "default:dirt",
	recipe = {"group:leaves", "group:leaves", "default:clay", "default:sand"},
})

-- Оставляем наше время горения дабы не нарушить баланс
-- (позже можно перебалансировать, учесть остальное топливо, напр. charcoal):
-- tree fuels:
core.clear_craft({type = "fuel", recipe = "group:tree"})
core.clear_craft({type = "fuel", recipe = "default:aspen_tree"}) -- добавлены в MTG, но у нас не используется
core.clear_craft({type = "fuel", recipe = "default:pine_tree"}) -- в lord_trees своя
core.clear_craft({type = "fuel", recipe = "default:acacia_tree"}) -- добавлены в MTG, но у нас не используется
core.clear_craft({type = "fuel", recipe = "default:jungletree"})
core.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 15,
})
-- wood fuels:
core.clear_craft({type = "fuel", recipe = "group:wood"})
core.clear_craft({type = "fuel", recipe = "default:aspen_wood"}) -- добавлены в MTG, но у нас не используется
core.clear_craft({type = "fuel", recipe = "default:pine_wood"}) -- в lord_trees своя
core.clear_craft({type = "fuel", recipe = "default:acacia_wood"}) -- добавлены в MTG, но у нас не используется
core.clear_craft({type = "fuel", recipe = "default:junglewood"})
core.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 10,
})
-- sapling fuels:
-- сами саженцы не выглядят не сбалансировано, но их у нас нет (пока выпиливаем):
core.clear_craft({type = "fuel", recipe = "default:bush_sapling"}) -- добавлены в MTG, но у нас не используется
core.clear_craft({type = "fuel", recipe = "default:acacia_bush_sapling"}) -- добавлены в MTG, у нас не используется
core.clear_craft({type = "fuel", recipe = "default:pine_bush_sapling"}) -- добавлены в MTG, у нас не используется
core.clear_craft({type = "fuel", recipe = "default:aspen_sapling"}) -- добавлены в MTG, у нас не используется
core.clear_craft({type = "fuel", recipe = "default:pine_sapling"}) -- добавлены в MTG, у нас не используется
core.clear_craft({type = "fuel", recipe = "default:acacia_sapling"}) -- добавлены в MTG, у нас не используется
core.clear_craft({type = "fuel", recipe = "default:junglesapling"}) -- добавлены в MTG, у нас не используется
core.clear_craft({type = "fuel", recipe = "default:emergent_jungle_sapling"}) -- добавлены в MTG, у нас нет
-- fence fuels:
-- в lottblocks свои заборы, а остальных у нас нет, придётся выпилить все
core.clear_craft({type = "fuel", recipe = "default:fence_aspen_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_pine_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_wood"}) -- является wooden
core.clear_craft({type = "fuel", recipe = "default:fence_acacia_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_junglewood"})
-- fence rail fuels:
core.clear_craft({type = "fuel", recipe = "default:fence_rail_aspen_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_rail_pine_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_rail_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_rail_acacia_wood"})
core.clear_craft({type = "fuel", recipe = "default:fence_rail_junglewood"})
-- bush fuels:
core.clear_craft({type = "fuel", recipe = "default:bush_stem"})
core.clear_craft({type = "fuel", recipe = "default:acacia_bush_stem"})
core.clear_craft({type = "fuel", recipe = "default:pine_bush_stem"})
-- other fuels:
core.clear_craft({type = "fuel", recipe = "default:junglegrass"}) -- нигде не генерится ? или ?

-- наше дополнительное топливо:
core.register_craft({
	type = "fuel",
	recipe = "group:paper",
	burntime = 2,
})
core.register_craft({
	type = "fuel",
	recipe = "group:grass",
	burntime = 3,
})
core.register_craft({
	type = "fuel",
	recipe = "group:wooden",
	burntime = 5,
})



-- default/nodes.lua

-- Временно закомментировано. Это неободимо для работы Farming.
-- Если будет возможно — исправим и восстановим эти строки.
-- Если нет — удалим "с корнем".
--[[
core.unregister_item("default:dirt_with_dry_grass")
core.unregister_item("default:dirt_with_rainforest_litter")
core.unregister_item("default:dirt_with_coniferous_litter")
core.unregister_item("default:dry_dirt")
core.unregister_item("default:dry_dirt_with_dry_grass")
]]
core.unregister_item("default:permafrost")
core.unregister_item("default:permafrost_with_stones")
core.unregister_item("default:permafrost_with_moss")
core.unregister_item("default:cave_ice")
core.unregister_item("default:emergent_jungle_sapling")
core.unregister_item("default:pine_tree")
core.unregister_item("default:pine_wood")
core.unregister_item("default:pine_needles")
core.unregister_item("default:pine_sapling")
core.unregister_item("default:acacia_tree")
core.unregister_item("default:acacia_wood")
core.unregister_item("default:acacia_leaves")
core.unregister_item("default:acacia_sapling")
core.unregister_item("default:aspen_tree")
core.unregister_item("default:aspen_wood")
core.unregister_item("default:aspen_leaves")
core.unregister_item("default:aspen_sapling")
core.unregister_item("default:stone_with_tin")
core.unregister_item("default:tinblock")
core.unregister_item("default:bush_stem")
core.unregister_item("default:bush_sapling")
core.unregister_item("default:bush_leaves")
core.unregister_item("default:acacia_bush_stem")
core.unregister_item("default:acacia_bush_leaves")
core.unregister_item("default:acacia_bush_sapling")
core.unregister_item("default:pine_bush_stem")
core.unregister_item("default:pine_bush_needles")
core.unregister_item("default:pine_bush_sapling")
-- оставляем ноды, будем продавать в магазинах:
--core.unregister_item("default:blueberry_bush_leaves_with_berries")
--core.unregister_item("default:blueberry_bush_leaves")
--core.unregister_item("default:blueberry_bush_sapling")
core.unregister_item("default:sand_with_kelp")
core.unregister_item("default:coral_green")
core.unregister_item("default:coral_pink")
core.unregister_item("default:coral_cyan")
core.unregister_item("default:coral_brown")
core.unregister_item("default:coral_orange")
core.unregister_item("default:coral_skeleton")
core.unregister_item("default:sign_wall_wood")
core.unregister_item("default:sign_wall_steel")
core.unregister_item("default:fence_acacia_wood")
core.unregister_item("default:fence_pine_wood")
core.unregister_item("default:fence_aspen_wood")
core.unregister_item("default:fence_rail_acacia_wood")
core.unregister_item("default:fence_rail_pine_wood")
core.unregister_item("default:fence_rail_aspen_wood")
--core.unregister_item("default:mese_post_light")            -- у нас крафт возможен, выглядят неплохо
core.unregister_item("default:mese_post_light_acacia_wood")
--core.unregister_item("default:mese_post_light_junglewood") -- у нас крафт возможен, выглядят неплохо
core.unregister_item("default:mese_post_light_pine_wood")
core.unregister_item("default:mese_post_light_aspen_wood")

-- Мы на данный момент не используем acacia, aspen и pine деревья из MTG и их саженцы
-- Выше мы их удаляем, но после этого появляется в логах: https://github.com/lord-server/lord/issues/711
--     в силу того, что в MTG регистрируется LBM "default:convert_saplings_to_node_timer",
--     который реагирует на эти саженцы.
-- Тут мы просто удаляем из этого LBM имена не нужных нам саженцев:
for _, lbm in pairs(core.registered_lbms) do
	if (lbm.name == "default:convert_saplings_to_node_timer") then
		table.remove(lbm.nodenames, table.indexof(lbm.nodenames, "default:acacia_sapling"))
		table.remove(lbm.nodenames, table.indexof(lbm.nodenames, "default:aspen_sapling"))
		table.remove(lbm.nodenames, table.indexof(lbm.nodenames, "default:pine_sapling"))
	end
end

-- Наши моделька и интерфейс книжной полки

local bookshelf_formspec =
	"size[8,9]" ..
	"list[context;books;0,0;8,2;]" ..
	"list[current_player;main;0,5;8,4;]" ..
	"listring[context;books]" ..
	"listring[current_player;main]" ..
	"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"

-- Функция использовалась для другого, но я ее порезал, при этом
-- решив оставить функцией, а не распихивать по коллбэкам
local function update_bookshelf(pos)
	local meta = core.get_meta(pos)

	meta:set_string("formspec", bookshelf_formspec)
	meta:set_string("infotext", S("Bookshelf"))
end

core.override_item("default:bookshelf", {
	drawtype = "mesh",
	mesh = "3dbookshelf.obj",
	tiles = {
		"default_wood.png",
		"default_wood.png^3dbookshelf_inside_back.png",
		"3dbookshelf_books.png",
	},
	paramtype = "light",
	on_construct = function(pos)
		local meta = core.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
		update_bookshelf(pos)
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		core.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. core.pos_to_string(pos))
		update_bookshelf(pos)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
			" puts stuff to bookshelf at " .. core.pos_to_string(pos))
		update_bookshelf(pos)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		core.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. core.pos_to_string(pos))
		update_bookshelf(pos)
	end,
})

-- Кактус

core.override_item("default:cactus", {
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

core.clear_craft({output = "default:large_cactus_seedling"})

-- Перезапись функции роста большого кактуса на пустую

function default.grow_large_cactus(pos)
	return nil
end

-- Ньян-кот

core.register_node(":default:nyancat", {
	description = S("Nyan Cat"),
	tiles = {"default_nc_side.png", "default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
	 "default_nc_back.png", "default_nc_front.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	legacy_facedir_simple = true,
	sounds = default.node_sound_defaults(),
})

core.register_node(":default:nyancat_rainbow", {
	description = S("Nyan Cat Rainbow"),
	tiles = {"default_nc_rb.png^[transformR90", "default_nc_rb.png^[transformR90",
	 "default_nc_rb.png", "default_nc_rb.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
})

-- Перезапись листвы ради модельки и возможности карабкаться

core.override_item("default:leaves", {
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "default_leaves.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "default_leaves_inv.png",
	waving                     = 2,
	walkable                   = false,
	move_resistance            = 6,
	liquidtype                 = "source",
	liquid_alternative_flowing = "default:leaves",
	liquid_alternative_source  = "default:leaves",
	liquid_renewable           = false,
	liquid_range               = 0,
})

-- Временно выпилили в связи с #894 (см. github), где возникла проблема с default:junglesapling
-- В коде присутствует и default:jungleleaves, и lord_trees:mirk_leaf/lottplants:mirkleaf, что создаёт путанницу
-- Принято решение пока что оставить только lord_trees:mirk_leaf
-- Понадобится при возможном переходе с дерева из lord_trees на дерево из default
--[[core.override_item("default:jungleleaves", {
	drawtype = "mesh",
	mesh = "leaves_model.obj",
	tiles = {"default_jungleleaves.png"},
	use_texture_alpha = "clip",
	inventory_image = "default_jungleleaves_inv.png",
	waving = 2,
	walkable = false,
	climbable = true,
})]]

-- Какие-то брёвна...
-- Честно, понятия не имею, для чего они нужны, когда есть
-- default:tree и default:jungletree.

-- На всякий случай вынес их, вместо того чтобы регистровать alias
-- с default:tree и default:jungletree.

core.register_node(":default:tree_trunk", {
	description = S("Tree Trunk"),
	tiles = { "default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "default:tree",
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = core.rotate_node,
})

core.register_node(":default:jungletree_trunk", {
	description = S("Jungle Tree Trunk"),
	tiles = {"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "default:jungletree",
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = core.rotate_node,
})

-- Включение возможности падения стволов деревьев

core.override_item("default:tree", {
	on_dig         = function(pos, node, digger)
		default.dig_tree(pos, node, "default:tree", digger, 10, 2)
	end,
	on_place       = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "default:tree_trunk")
	end,
	_tree_height   = 10,
	_leaves_radius = 2,
})

core.override_item("default:jungletree", {
	on_dig         = function(pos, node, digger)
		default.dig_tree(pos, node, "default:jungletree", digger, 15, 2)
	end,
	on_place       = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "default:jungletree_trunk")
	end,
	_tree_height   = 15,
	_leaves_radius = 2,
})

core.override_item('default:lava_source',  { damage_groups = { fire = true, }, })
core.override_item('default:lava_flowing', { damage_groups = { fire = true, }, })


-- default/functions.lua

default.cool_lava = function(pos, node)
	if node.name == "default:lava_source" then
		core.set_node(pos, {name = "default:obsidian"})
	else -- Lava flowing
		local stone_name = core.find_node_near(pos, 1, {"lottmapgen:blacksource", "lottmapgen:blackflowing"})
			and "lord_rocks:mordor_stone"
			or  "default:stone"
		core.set_node(pos, {name = stone_name})
	end
	core.sound_play("default_cool_lava",
		{pos = pos, max_hear_distance = 16, gain = 0.2}, true)
end

--- Устанавливает trunk вместо tree (обработчик для on_place в tree).
---@param itemstack ItemStack @stack в руках игрока (tree)
---@param placer Player @объект игрока
---@param pointed_thing pointed_thing @объект направления
---@param trunk_name string @название соответствующего дереву (tree) блока trunk
---@return ItemStack @обновлённый stack в руках игрока (tree)
function default.place_tree(itemstack, placer, pointed_thing, trunk_name)
	local leftover_stack = core.rotate_node(ItemStack(trunk_name), placer, pointed_thing)
	if leftover_stack and leftover_stack:get_count() == 0 then
		itemstack:take_item()
	end

	return itemstack
end

--- Removes all specified `name`-nodes
local function falloff_tree_branches(pos, name, radius)
	for k = -radius, radius do
		for l = -radius, radius do
			for j = 0, 1 do
				local node_bellow = core.get_node({ x = pos.x + k, y = pos.y - 1, z = pos.z + l })
				if node_bellow.name ~= name then
					local node_pos = { x = pos.x + k, y = pos.y + j, z = pos.z + l }
					if core.get_node(node_pos).name == name then
						core.spawn_item(node_pos, name)
						core.remove_node(node_pos)
					end
				end
			end
		end
	end
end

--- Падение(сползание) ствола деревьев вниз при ломании
--- Fall(slide) all trunk nodes down while digging
--- @param pos    Position
--- @param node   NodeTable
--- @param name   string
--- @param digger Player
--- @param height number
--- @param radius number
---
--- @return boolean
function default.dig_tree(pos, node, name, digger, height, radius)
	if (not core.node_dig(pos, node, digger)) then
		return false
	end

	local pos_i        = vector.copy(pos)
	local previous_pos = vector.copy(pos)
	for i = 1, (height + 5) do
		pos_i.y      = pos.y + i
		local node_i = core.get_node(pos_i)
		if node_i.name ~= name or i == (height + 5) then
			if i == 1 then
				return true
			end

			core.remove_node(previous_pos) -- remove last (highest) trunk-node: for move all trunk nodes down
			core.node_punch(previous_pos, node, digger) -- punch for callback mechanics (for ex. torch will fall)
			core.set_node(pos, { name = name }) -- first trunk-node (actually dug): for move all trunk nodes down

			falloff_tree_branches(pos_i, name, radius)

			return true
		end
		previous_pos = vector.copy(pos_i)
	end

	return true
end

local function grow_papyrus_but_on_soils(pos, node)
	pos.y = pos.y - 1
	local name = core.get_node(pos).name

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

	local is_soil = core.get_item_group(name, "soil") ~= 0

	-- Technically sand isn't soil, but it's required to keep compatibility
	if (not is_soil and name ~= "default:sand") or is_growing_in_mtg then
		return
	end
	if not core.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "default:papyrus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = core.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if core.get_node_light(pos) < 13 then
		return
	end
	core.set_node(pos, {name = "default:papyrus"})
	return true
end

core.register_abm({
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
core.override_item("default:jungletree", {
	description = S("Jungle Tree"),
})
core.override_item("default:junglewood", {
	description = S("Jungle Wood"),
})

-- Фикс локализации заборов
core.override_item("default:fence_junglewood", {
	description = S("Junglewood Fence")
})
core.override_item("default:fence_rail_junglewood", {
	description = S("Junglewood Fence Rail")
})
core.override_item("default:fence_wood", {
	description = S("Wooden Fence")
})
core.override_item("default:fence_rail_wood", {
	description = S("Wooden Fence Rail")
})

-- заменяем исходную текстуру на свою с прозрачностью
core.register_node(":default:ice", {
	description = S("Ice"),
	drawtype = "glasslike",
	tiles = {"default_ice.png"},
	is_ground_content = true,
	use_texture_alpha = "blend",
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_ice_defaults(),
})

-- Add food points description:
dofile(core.get_modpath("lord_overwrites_mtg_default").."/food.lua")

dofile(core.get_modpath("lord_overwrites_mtg_default").."/mapgen.lua")
