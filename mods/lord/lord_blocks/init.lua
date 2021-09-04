local S = minetest.get_translator("lord_blocks")

minetest.register_node("lord_blocks:blackout", {
	description = S("Blackout"),
	tiles = {"default_blackout.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
    walkable = false,
    buildable_to = true,
    pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
	--post_effect_color = {a = 10, r = 0, g = 0, b = 0},
})

minetest.register_alias("default:blackout", "lord_blocks:blackout")

minetest.register_node(":lottblocks:dwarfstone_stripe_singledot", {
	description       = S("Stripe Dwarf Stone (Single Dot)"),
	tiles             = {
		"lottblocks_dwarfstone_stripe_singledot_top.png",
		"lottblocks_dwarfstone_stripe_singledot_bottom.png",
		"default_stone.png",
		"lottblocks_dwarfstone_stripe_l.png",
		"lottblocks_dwarfstone_stripe_r.png",
		"default_stone.png",
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { cracky = 3 },
})

minetest.register_node(":lottblocks:dwarfstone_stripe_onesided", {
	description       = S("Stripe Dwarf Stone (One Sided)"),
	tiles             = {
		"lottblocks_dwarfstone_stripe_onesided_top.png",
		"lottblocks_dwarfstone_stripe_onesided_bottom.png",
		"lottblocks_dwarfstone_stripe_r.png",
		"lottblocks_dwarfstone_stripe_l.png",
		"lottblocks_dwarfstone_stripe_double.png",
		"default_stone.png",
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { cracky = 3 },
})

minetest.register_craft({
	output = 'lottblocks:dwarfstone_stripe_singledot 4',
	recipe = {
		{ 'default:stone', 'default:stone', 'default:coal_lump' },
		{ 'default:stone', 'default:stone', 'default:coal_lump' },
		{ 'default:stone', 'default:stone', 'default:coal_lump' },
	}
})

minetest.register_craft({
	output = 'lottblocks:dwarfstone_stripe_singledot 4',
	recipe = {
		{ 'default:coal_lump', 'default:stone', 'default:stone' },
		{ 'default:coal_lump', 'default:stone', 'default:stone' },
		{ 'default:coal_lump', 'default:stone', 'default:stone' },
	}
})

minetest.register_craft({
	output = 'lottblocks:dwarfstone_stripe_onesided 4',
	recipe = {
		{ 'default:coal_lump', 'default:stone', 'default:coal_lump' },
		{ 'default:coal_lump', 'default:stone', 'default:coal_lump' },
		{ 'default:coal_lump', 'default:stone', 'default:coal_lump' },
	}
})
