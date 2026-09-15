local S = core.get_mod_translator()

core.register_tool("lottclothes:hood_elven", {
	description = S("Elven Hood"),
	inventory_image = "lottclothes_inv_hood_elven.png",
	groups = {armor_feet=0, clothes=1, clothes_head=1},
	wear = 0
})

core.register_tool("lottclothes:shirt_elven", {
	description = S("Elven Shirt"),
	inventory_image = "lottclothes_inv_shirt_elven.png",
	groups = {armor_feet=0, clothes=1, clothes_torso=1},
	wear = 0
})

core.register_tool("lottclothes:trousers_elven", {
	description = S("Elven Trousers"),
	inventory_image = "lottclothes_inv_trousers_elven.png",
	groups = {armor_feet=0, clothes=1, clothes_legs=1},
	wear = 0
})

core.register_tool("lottclothes:shoes_elven", {
	description = S("Elven Shoes"),
	inventory_image = "lottclothes_inv_shoes_elven.png",
	groups = {armor_feet=0, clothes=1, clothes_feet=1},
	wear = 0
})

core.register_tool("lottclothes:cloak_elven", {
	description = S("Elven Cloak"),
	inventory_image = "lottclothes_inv_cloak_elven.png",
	groups = {armor_feet=0, clothes=1, clothes_cloak=1, no_preview=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:hood_elven",
	recipe = {
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"},
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 5',
	recipe = {
		{'lottclothes:hood_elven'},
	}
})

core.register_craft({
	output = "lottclothes:shirt_elven",
	recipe = {
		{"lottclothes:flax_grey", "", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 8',
	recipe = {
		{'lottclothes:shirt_elven'},
	}
})

core.register_craft({
	output = "lottclothes:trousers_elven",
	recipe = {
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 7',
	recipe = {
		{'lottclothes:trousers_elven'},
	}
})

core.register_craft({
	output = "lottclothes:shoes_elven",
	recipe = {
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"},
		{"lottclothes:felt_black", "" , "lottclothes:felt_black"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:shoes_elven'},
	}
})

core.register_craft({
	output = "lottclothes:cloak_elven",
	recipe = {
		{"lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 6',
	recipe = {
		{'lottclothes:cloak_elven'},
	}
})
