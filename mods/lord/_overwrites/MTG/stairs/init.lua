

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

-- `silver_sand` не генерируется нашим map-генератором (`mods/_lott/lottmapgen`)
minetest.unregister_item("stairs:slab_silver_sandstone")
minetest.unregister_item("stairs:stair_inner_silver_sandstone")
minetest.unregister_item("stairs:stair_outer_silver_sandstone")
minetest.unregister_item("stairs:stair_silver_sandstone")
minetest.unregister_item("stairs:slab_silver_sandstone_block")
minetest.unregister_item("stairs:stair_inner_silver_sandstone_block")
minetest.unregister_item("stairs:stair_outer_silver_sandstone_block")
minetest.unregister_item("stairs:stair_silver_sandstone_block")
minetest.unregister_item("stairs:slab_silver_sandstone_brick")
minetest.unregister_item("stairs:stair_inner_silver_sandstone_brick")
minetest.unregister_item("stairs:stair_outer_silver_sandstone_brick")
minetest.unregister_item("stairs:stair_silver_sandstone_brick")
