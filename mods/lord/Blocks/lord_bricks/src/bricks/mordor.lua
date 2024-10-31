local S = minetest.get_mod_translator()

-- Items

minetest.register_craftitem("lord_bricks:mordor_clay_brick_raw", {
	description = S("Raw Mordor Clay Brick"),
	inventory_image = "lord_bricks_mordor_clay_brick_raw.png"
})

minetest.register_craftitem("lord_bricks:mordor_clay_brick_dried", {
	description = S("Mordor Clay Brick"),
	inventory_image = "lord_bricks_mordor_clay_brick_dried.png"
})


-- Nodes

minetest.register_node("lord_bricks:mordor_clay_masonry", {
	description = S("Mordor Clay Masonry"),
	tiles = {"lord_bricks_mordor_clay_masonry.png"},
	is_ground_content = false,
	groups = {cracky = 2, brick = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lord_bricks:mordor_clay_masonry_large", {
	description = S("Large Mordor Clay Masonry"),
	tiles = {"lord_bricks_mordor_clay_masonry_large.png"},
	is_ground_content = false,
	groups = {cracky = 2, brick = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lord_bricks:mordor_clay_brick", {
	description = S("Mordor Clay Brick"),
	tiles = {"lord_bricks_mordor_clay_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, brick = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lord_bricks:mordor_clay_block", {
	description = S("Mordor Clay Block"),
	tiles = {"lord_bricks_mordor_clay_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab("mordor_clay_masonry", "lord_bricks:mordor_clay_masonry",
		{cracky=2},
		{"lord_bricks_mordor_clay_masonry.png"},
		S("Mordor Clay Masonry Stair"),
		S("Mordor Clay Masonry Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Mordor Clay Masonry Stair"),
		S("Outer Mordor Clay Masonry Stair")
)

stairs.register_stair_and_slab("mordor_clay_masonry_large", "lord_bricks:mordor_clay_masonry_large",
		{cracky=2},
		{"lord_bricks_mordor_clay_masonry_large.png"},
		S("Large Mordor Clay Masonry Stair"),
		S("Large Mordor Clay MasonrySlab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Large Mordor Clay Masonry Stair"),
		S("Outer Large Mordor Clay Masonry Stair")
)

stairs.register_stair_and_slab("mordor_clay_brick", "lord_bricks:mordor_clay_brick",
		{cracky=2},
		{"lord_bricks_mordor_clay_brick.png"},
		S("Mordor Clay Brick Stair"),
		S("Mordor Clay Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Mordor Clay Brick Stair"),
		S("Outer Mordor Clay Brick Stair")
)

stairs.register_stair_and_slab("mordor_clay_block", "lord_bricks:mordor_clay_block",
		{cracky=2},
		{"lord_bricks_mordor_clay_block.png"},
		S("Mordor Clay Block Stair"),
		S("Mordor Clay Block Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Mordor Clay Block Stair"),
		S("Outer Mordor Clay Block Stair")
)
