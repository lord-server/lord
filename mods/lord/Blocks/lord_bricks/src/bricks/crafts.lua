-- Remove crafting default:clay_brick with default:clay_lump
core.clear_craft({
	type = "cooking",
	recipe = "default:clay_lump",
})


-- Recipes for default bricks

core.register_craft({
	output = "lord_bricks:clay_brick_raw 2",
	recipe = {
		{"default:clay_lump", "default:clay_lump"},
	},
})

core.register_craft({
	type = "cooking",
	output = "default:clay_brick",
	recipe = "lord_bricks:clay_brick_raw",
})

core.register_craft({
	output = "lord_bricks:chamotte_brick_raw 2",
	recipe = {
		{"clay_types:chamotte_lump", "clay_types:chamotte_lump"},
	},
})

core.register_craft({
	type = "cooking",
	output = "lord_bricks:chamotte_brick_dried",
	recipe = "lord_bricks:chamotte_brick_raw",
})

core.register_craft({
	output = "lord_bricks:chamotte_masonry",
	recipe = {
		{"lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried"},
		{"lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried"},
	},
})

core.register_craft({
	output = "lord_bricks:chamotte_masonry_large",
	recipe = {
		{"lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried"},
		{"lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried"},
		{"lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried", "lord_bricks:chamotte_brick_dried"},
	},
})

core.register_craft({
	output = "lord_bricks:chamotte_brick_dried 4",
	recipe = {
		{"lord_bricks:chamotte_masonry"},
	},
})

core.register_craft({
	output = "lord_bricks:chamotte_brick_dried 9",
	recipe = {
		{"lord_bricks:chamotte_masonry_large"},
	},
})


core.register_craft({
	output = "lord_bricks:chamotte_brick 4",
	recipe = {
		{"clay_types:chamotte_block_dried", "clay_types:chamotte_block_dried"},
		{"clay_types:chamotte_block_dried", "clay_types:chamotte_block_dried"},
	},
})

core.register_craft({
	output = "lord_bricks:chamotte_block 9",
	recipe = {
		{"clay_types:chamotte_block_dried", "clay_types:chamotte_block_dried",
				"clay_types:chamotte_block_dried"},
		{"clay_types:chamotte_block_dried", "clay_types:chamotte_block_dried",
				"clay_types:chamotte_block_dried"},
		{"clay_types:chamotte_block_dried", "clay_types:chamotte_block_dried",
				"clay_types:chamotte_block_dried"},
	},
})

-- Mordor Clay crafts

core.register_craft({
	output = "lord_bricks:mordor_clay_brick_raw 2",
	recipe = {
		{"clay_types:mordor_clay_lump", "clay_types:mordor_clay_lump"},
	},
})

core.register_craft({
	type = "cooking",
	output = "lord_bricks:mordor_clay_brick_dried",
	recipe = "lord_bricks:mordor_clay_brick_raw",
})

core.register_craft({
	output = "lord_bricks:mordor_clay_masonry",
	recipe = {
		{"lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried"},
		{"lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried"},
	},
})

core.register_craft({
	output = "lord_bricks:mordor_clay_masonry_large",
	recipe = {
		{"lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried"},
		{"lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried"},
		{"lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried", "lord_bricks:mordor_clay_brick_dried"},
	},
})

core.register_craft({
	output = "lord_bricks:mordor_clay_brick_dried 4",
	recipe = {
		{"lord_bricks:mordor_clay_masonry"},
	},
})

core.register_craft({
	output = "lord_bricks:mordor_clay_brick_dried 9",
	recipe = {
		{"lord_bricks:mordor_clay_masonry_large"},
	},
})


core.register_craft({
	output = "lord_bricks:mordor_clay_brick 4",
	recipe = {
		{"clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried"},
		{"clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried"},
	},
})

core.register_craft({
	output = "lord_bricks:mordor_clay_block 9",
	recipe = {
		{"clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried"},
		{"clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried"},
		{"clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried", "clay_types:mordor_clay_block_dried"},
	},
})
