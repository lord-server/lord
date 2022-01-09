

-- stairs/init.lua
-- т.к. в LOTT (`lottplants/nodes.lua) была изначально своя сосна (`lottplants:pinewood`),
-- то и её ступеньки нам не нужны
minetest.unregister_item("stairs:slab_pine_wood")
minetest.unregister_item("stairs:stair_inner_pine_wood")
minetest.unregister_item("stairs:stair_outer_pine_wood")
minetest.unregister_item("stairs:stair_pine_wood")
