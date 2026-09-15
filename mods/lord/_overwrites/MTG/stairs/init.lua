
local S = core.get_mod_translator()


-- stairs/init.lua
-- Т.к. в LOTT (сейчас `lord_trees/src/nodes.lua)
--    была изначально своя сосна (`lottplants:pinetree`, сейчас `lord_trees:pine_tree`),
-- то и её ступеньки нам не нужны (default:pine_wood)
core.unregister_item("stairs:slab_pine_wood")
core.unregister_item("stairs:stair_inner_pine_wood")
core.unregister_item("stairs:stair_outer_pine_wood")
core.unregister_item("stairs:stair_pine_wood")

-- Были добавлены, но у нас не используются (пока выпиливаем):
-- ступеньки и плиты акации (default:acacia_wood)
core.unregister_item("stairs:slab_acacia_wood")
core.unregister_item("stairs:stair_inner_acacia_wood")
core.unregister_item("stairs:stair_outer_acacia_wood")
core.unregister_item("stairs:stair_acacia_wood")
-- ступеньки и плиты осины (default:aspen_wood)
core.unregister_item("stairs:slab_aspen_wood")
core.unregister_item("stairs:stair_inner_aspen_wood")
core.unregister_item("stairs:stair_outer_aspen_wood")
core.unregister_item("stairs:stair_aspen_wood")

-- Т.к. в `mods/lord/Blocks/lottores` своё олово (видимо в MTG оно появилось позже)
-- то и ступеньки из MTG нам не нужны (default:tinblock)
core.unregister_item("stairs:slab_tinblock")
core.unregister_item("stairs:stair_inner_tinblock")
core.unregister_item("stairs:stair_outer_tinblock")
core.unregister_item("stairs:stair_tinblock")


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
core.override_item("stairs:stair_junglewood", {
	description = S("Jungle Wood Stair")
})
core.override_item("stairs:stair_inner_junglewood", {
	description = S("Inner Jungle Wood Stair")
})
core.override_item("stairs:stair_outer_junglewood", {
	description = S("Outer Jungle Wood Stair")
})
core.override_item("stairs:slab_junglewood", {
	description = S("Jungle Wood Slab")
})
