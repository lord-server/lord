local SL = lord.require_intllib()

minetest.register_tool("tools:sword_elven", {
	description = SL("Elven Sword"),
	wield_scale = {x=1,5, y=1,5, z=1},
	inventory_image = "tools_sword_elven.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=7.5},
	},
	groups = {bronze_item = 1, forbidden = 1},
})

minetest.register_tool("tools:sword_orc", {
	description = SL("Orcish Sword"),
	wield_scale = {x=1,5, y=1,5, z=1},
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


minetest.register_tool("tools:dragon_warrior_sword", {
	description = SL("Crusher\nDragon Warrior Sword"),
	wield_scale = {x=1,5, y=1,5, z=1},
	inventory_image = "tools_dragon_warrior_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.20,
		max_drop_level=2,
		wield_scale = {x=2, y=2, z=1},
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=90, maxlevel=3},
		},
		damage_groups = {fleshy=9.5},
	},
	groups = {mithril_item = 1, forbidden = 1},
})

minetest.register_tool("tools:melkor_pick", {
	description = SL("Melkor Pickaxe"),
	wield_scale = {x=1,5, y=1,5, z=1},
	inventory_image = "tools_melkor_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=1,
		groupcaps={
			hard = {times={[1]=7.5}, uses=25, maxlevel=3}
		},
		damage_groups = {fleshy=2},
	},
	groups = {mithril_item = 1, forbidden = 1},
})

minetest.register_craft({
	output = 'tools:dragon_warrior_sword',
	recipe = {
		{'default:mese', 'lottores:mithril_block', 'default:mese'},
		{'default:mese', 'tools:sword_mithril', 'default:mese'},
		{'', 'lottores:tilkal_ingot', ''},
	}
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
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', ''},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'tools:sword_orc',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot'},
		{'', 'group:stick'},
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
