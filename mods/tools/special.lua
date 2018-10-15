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

minetest.register_tool("tools:battleaxe_dwarven", {
	description = SL("Dwarven Battleaxe"),
	inventory_image = "castle_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=20, maxlevel=3},
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	groups = {steel_item = 1},
})

minetest.register_craft({
	output = 'tools:sword_elven',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot'},
		{'default:mese_crystal', 'group:stick', 'default:mese_crystal'},
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
	output = "tools:battleaxe_dwarven",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal","default:steel_ingot"},
		{"default:steel_ingot", "group:stick","default:steel_ingot"},
                  {"", "group:stick",""}
	}
})
