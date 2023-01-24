local SL = lord.require_intllib()

minetest.register_tool("lottinventory:small", {
	description     = SL("Small Bag"),
	inventory_image = "bags_small.png",
	groups          = { bagslots = 8 },
})
minetest.register_tool("lottinventory:medium", {
	description     = SL("Medium Bag"),
	inventory_image = "bags_medium.png",
	groups          = { bagslots = 16 },
})
minetest.register_tool("lottinventory:large", {
	description     = SL("Large Bag"),
	inventory_image = "bags_large.png",
	groups          = { bagslots = 24, forbidden = 1 },
})

minetest.register_craft({
	output = 'lottinventory:small',
	recipe = {
		{ '', 'group:stick', '' },
		{ 'group:wool', 'default:steel_ingot', 'group:wool' },
		{ 'group:wool', 'group:wool', 'group:wool' },
	}
})

minetest.register_craft({
	output = 'lottinventory:medium',
	recipe = {
		{ 'default:steel_ingot', 'farming:string', 'default:steel_ingot' },
		{ 'lottinventory:small', 'farming:string', 'lottinventory:small' },
	}
})

minetest.register_craft({
	output = 'lottinventory:large',
	recipe = {
		{ 'default:steel_ingot', 'lottinventory:medium', 'default:steel_ingot' },
		{ 'farming:string', 'lottinventory:small', 'farming:string' },
	}
})

minetest.register_craft({
	output = 'lottinventory:large',
	recipe = {
		{ 'default:steel_ingot', 'lottinventory:small', 'default:steel_ingot' },
		{ 'farming:string', 'lottinventory:medium', 'farming:string' },
	}
})
