local S = minetest.get_mod_translator()

-- Items

minetest.register_craftitem("lord_bricks:chamotte_brick_raw", {
	description = S("Raw Chamotte Brick"),
	inventory_image = "lord_bricks_chamotte_brick_raw.png"
})

minetest.register_craftitem("lord_bricks:chamotte_brick_dried", {
	description = S("Chamotte Brick"),
	inventory_image = "lord_bricks_chamotte_brick_dried.png"
})


-- Nodes

minetest.register_node("lord_bricks:chamotte_masonry", {
	description = S("Chamotte Masonry"),
	tiles = {"lord_bricks_chamotte_masonry.png"},
	is_ground_content = false,
	groups = {cracky = 2, brick = 1, wall_connected = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lord_bricks:chamotte_masonry_large", {
	description = S("Large Chamotte Masonry"),
	tiles = {"lord_bricks_chamotte_masonry_large.png"},
	is_ground_content = false,
	groups = {cracky = 2, brick = 1, wall_connected = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lord_bricks:chamotte_brick", {
	description = S("Chamotte Brick"),
	tiles = {"lord_bricks_chamotte_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, brick = 1, wall_connected = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lord_bricks:chamotte_block", {
	description = S("Chamotte Block"),
	tiles = {"lord_bricks_chamotte_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, wall_connected = 1},
	sounds = default.node_sound_stone_defaults(),
})


stairs.register_stair_and_slab("chamotte_masonry", "lord_bricks:chamotte_masonry",
		{cracky=2, wall_connected = 1},
		{"lord_bricks_chamotte_masonry.png"},
		S("Chamotte Masonry Stair"),
		S("Chamotte Masonry Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Chamotte Masonry Stair"),
		S("Outer Chamotte Masonry Stair")
)

stairs.register_stair_and_slab("chamotte_masonry_large", "lord_bricks:chamotte_masonry_large",
		{cracky=2, wall_connected = 1},
		{"lord_bricks_chamotte_masonry_large.png"},
		S("Large Chamotte Masonry Stair"),
		S("Large Chamotte Masonry Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Large Chamotte Masonry Stair"),
		S("Outer Large Chamotte Masonry Stair")
)

stairs.register_stair_and_slab("chamotte_brick", "lord_bricks:chamotte_brick",
		{cracky=2, wall_connected = 1},
		{"lord_bricks_chamotte_brick.png"},
		S("Chamotte Brick Stair"),
		S("Chamotte Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Chamotte Brick Stair"),
		S("Outer Chamotte Brick Stair")
)

stairs.register_stair_and_slab("chamotte_block", "lord_bricks:chamotte_block",
		{cracky=2, wall_connected = 1},
		{"lord_bricks_chamotte_block.png"},
		S("Chamotte Block Stair"),
		S("Chamotte Block Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Chamotte Block Stair"),
		S("Outer Chamotte Block Stair")
)

