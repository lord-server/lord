
local S = minetest.get_translator("lord_overwrites_mtg_stairs")


-- stairs/init.lua
-- Т.к. в LOTT (`lottplants/nodes.lua) была изначально своя сосна (`lottplants:pinewood`),
-- то и её ступеньки нам не нужны (default:pine_wood)
minetest.unregister_item("stairs:slab_pine_wood")
minetest.unregister_item("stairs:stair_inner_pine_wood")
minetest.unregister_item("stairs:stair_outer_pine_wood")
minetest.unregister_item("stairs:stair_pine_wood")

-- Были добавлены, но у нас не используются (пока выпиливаем):
-- ступеньки и плиты акации (default:acacia_wood)
minetest.unregister_item("stairs:slab_acacia_wood")
minetest.unregister_item("stairs:stair_inner_acacia_wood")
minetest.unregister_item("stairs:stair_outer_acacia_wood")
minetest.unregister_item("stairs:stair_acacia_wood")
-- ступеньки и плиты осины (default:aspen_wood)
minetest.unregister_item("stairs:slab_aspen_wood")
minetest.unregister_item("stairs:stair_inner_aspen_wood")
minetest.unregister_item("stairs:stair_outer_aspen_wood")
minetest.unregister_item("stairs:stair_aspen_wood")

-- Т.к. в `_lott/lottores` своё олово (видимо в MTG оно появилось позже)
-- то и ступеньки из MTG нам не нужны (default:tinblock)
minetest.unregister_item("stairs:slab_tinblock")
minetest.unregister_item("stairs:stair_inner_tinblock")
minetest.unregister_item("stairs:stair_outer_tinblock")
minetest.unregister_item("stairs:stair_tinblock")


stairs.register_stair_and_slab(
	"diamondblock",
	"default:diamondblock",
	{ cracky = 1, level = 3 },
	{"default_diamond_block.png"},
	S("Diamond Block Stair"),
	S("Diamond Block Slab"),
	default.node_sound_glass_defaults(),
	true,
	S("Inner Diamond Block Stair"),
	S("Outer Diamond Block Stair")
)

-- Перезапись переводов Тропические -> Эвкалиптовые ступеньки
minetest.override_item("stairs:stair_junglewood", {
	description = S("Jungle Wood Stair")
})
minetest.override_item("stairs:stair_inner_junglewood", {
	description = S("Inner Jungle Wood Stair")
})
minetest.override_item("stairs:stair_outer_junglewood", {
	description = S("Outer Jungle Wood Stair")
})
minetest.override_item("stairs:slab_junglewood", {
	description = S("Jungle Wood Slab")
})
