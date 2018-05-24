local SL = lord.require_intllib()

minetest.register_tool("tools:sword_elven", {
	description = SL("Elven Sword"),
	inventory_image = "tools_sword_elven.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=7.5},
	},
	groups = {bronze_item = 1},
})

minetest.register_tool("tools:sword_orc", {
	description = SL("Orcish Sword"),
	inventory_image = "tools_sword_orc.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=2.25, [2]=1.80, [3]=1.30}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=6.5},
	},
	groups = {steel_item = 1},
})

minetest.register_tool("tools:melkor_pick", {
	description = SL("Melkor Pickaxe"),
	inventory_image = "tools_melkor_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=1,
		groupcaps={
			hard = {times={[1]=7.5}, uses=50, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
	groups = {forbidden = 1},
})

minetest.register_craft({
	output = 'tools:sword_elven',
	recipe = {
		{'lottores:white_gem', 'default:steel_ingot', 'lottores:white_gem'},
		{'default:bronze_ingot', 'lottores:mithril_ingot', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'tools:sword_orc',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'tools:sword_orc',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', ''},
		{'', 'default:steel_ingot', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'tools:melkor_pick',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:tilkal', 'lottores:mithril_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})
