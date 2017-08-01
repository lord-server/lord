local SL = lord.require_intllib()

--Thanks for all the things in this file, and the related textures goes to catninja!--

-------------
--- Items ---
-------------

-- TREES
-- Vine tree

minetest.register_node("lottblocks:tree_vine", {
	description = SL("Tree With Vines"),
	tiles = {"lottblocks_tree_vine_top.png", "lottblocks_tree_vine_top.png", "lottblocks_tree_vine.png", "lottblocks_tree_vine.png", "lottblocks_tree_vine.png", "lottblocks_tree_vine.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2,snappy=2, tree=1},
})

stairs.register_stair_and_slab("tree_vine", "lottblocks:tree_vine",
		{choppy=2,snappy=2, tree=1},
		{"lottblocks_tree_vine.png"},
		SL("Tree With Vines Stair"),
		SL("Tree With Vines Slab"),
		default.node_sound_wood_defaults()
)

-- Mossy tree

minetest.register_node("lottblocks:tree_mossy", {
	description = SL("Tree With Moss"),
	tiles = {"lottblocks_tree_mossy_top.png", "lottblocks_tree_mossy_top.png", "lottblocks_tree_mossy.png", "lottblocks_tree_mossy.png", "lottblocks_tree_mossy.png", "lottblocks_tree_mossy.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2, tree=1},
})

stairs.register_stair_and_slab("tree_mossy", "lottblocks:tree_mossy",
		{choppy=2, tree=1},
		{"lottblocks_tree_mossy.png"},
		SL("Tree With Moss Stair"),
		SL("Tree With Moss Slab"),
		default.node_sound_wood_defaults()
)

-- Leafroof dark

minetest.register_node("lottblocks:leafroof_dark", {
	description = SL("Dark Leaf Roof"),
	tiles = {"lottblocks_leafroof.png"},
	paramtype = "light",
	drawtype = "allfaces_optional",
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=2,oddly_breakable_by_hand=2,leaves=1},
})

stairs.register_stair_and_slab("leafroof_dark", "lottblocks:leafroof_dark",
		{oddly_breakable_by_hand=2,leaves=1},
		{"lottblocks_leafroof.png"},
		SL("Dark Leaf Roof Stair"),
		SL("Dark Leaf Roof Slab"),
		default.node_sound_stone_defaults()
)


-- MALLORN
-- Leafroof mallorn

minetest.register_node("lottblocks:leafroof_mallorn", {
	description = SL("Mallorn Leaf Roof"),
	tiles = {"lottblocks_mallornroof.png"},
	paramtype = "light",
	drawtype = "allfaces_optional",
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
	groups = {oddly_breakable_by_hand=2,leaves=1},
})

stairs.register_stair_and_slab("leafroof_mallorn", "lottblocks:leafroof_mallorn",
		{oddly_breakable_by_hand=2,leaves=1},
		{"lottblocks_mallornroof.png"},
		SL("Mallorn Leaf Roof Stair"),
		SL("Mallorn Leaf Roof Slab"),
		default.node_sound_leaves_defaults()
)

-- mallorn pillar

minetest.register_node("lottblocks:mallorn_pillar", {
	description = SL("Mallorn Pillar"),
	tiles = {"lottblocks_mallorn_pillar.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2, wooden=1},
})

stairs.register_stair_and_slab("mallorn_pillar", "lottblocks:mallorn_pillar",
		{snappy=2,choppy=2, wooden=1},
		{"lottblocks_mallorn_pillar.png"},
		SL("Mallorn Pillar Stair"),
		SL("Mallorn Pillar Slab"),
		default.node_sound_wood_defaults()
)

-- mallorn White

minetest.register_node("lottblocks:mallorn_white", {
	description = SL("White Mallorn"),
	tiles = {"lottblocks_mallorn_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2, wooden=1},
})

stairs.register_stair_and_slab("mallorn_white", "lottblocks:mallorn_white",
		{snappy=2,choppy=2, wooden=1},
		{"lottblocks_mallorn_white.png"},
		SL("White Mallorn Stair"),
		SL("White Mallorn Slab"),
		default.node_sound_wood_defaults()
)

-- DWARFSTONE
-- white

minetest.register_node("lottblocks:dwarfstone_white", {
	description = SL("White Dwarf Stone"),
	tiles = {"lottblocks_dwarfstone_white_top.png", "lottblocks_dwarfstone_white_top.png", "lottblocks_dwarfstone_white_side.png", "lottblocks_dwarfstone_white_side.png", "lottblocks_dwarfstone_white_side.png", "lottblocks_dwarfstone_white_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

stairs.register_stair_and_slab("dwarfstone_white", "lottblocks:dwarfstone_white",
		{cracky=2},
		{"lottblocks_dwarfstone_white_top.png"},
		SL("White Dwarf Stone Stair"),
		SL("White Dwarf Stone Slab"),
		default.node_sound_stone_defaults()
)

-- black

minetest.register_node("lottblocks:dwarfstone_black", {
	description = SL("Black Dwarf Stone"),
	tiles = {"lottblocks_dwarfstone_black_top.png", "lottblocks_dwarfstone_black_top.png", "lottblocks_dwarfstone_black_side.png", "lottblocks_dwarfstone_black_side.png", "lottblocks_dwarfstone_black_side.png", "lottblocks_dwarfstone_black_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

stairs.register_stair_and_slab("dwarfstone_black", "lottblocks:dwarfstone_black",
		{cracky=2},
		{"lottblocks_dwarfstone_black_top.png"},
		SL("Black Dwarf Stone Stair"),
		SL("Black Dwarf Stone Slab"),
		default.node_sound_stone_defaults()
)

-- stripe

minetest.register_node("lottblocks:dwarfstone_stripe", {
	description = SL("Stripe Dwarf Stone"),
	tiles = {"lottblocks_dwarfstone_stripe_top.png", "lottblocks_dwarfstone_stripe_bottom.png", "lottblocks_dwarfstone_stripe_l.png", "lottblocks_dwarfstone_stripe_l.png", "lottblocks_dwarfstone_stripe_r.png", "lottblocks_dwarfstone_stripe_r.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

--------------
--- Crafts ---
--------------

--TREES
-- vine

minetest.register_craft({
	output = 'lottblocks:tree_vine 4',
	recipe = {
		{'default:tree', 'default:grass_1'},
		{'default:grass_1', 'default:tree'},
	}
})

-- mossy tree

minetest.register_craft({
	output = 'lottblocks:tree_mossy 4',
	recipe = {
		{'default:grass_1', 'default:grass_1', 'default:grass_1'},
		{'default:grass_1', 'default:tree', 'default:grass_1'},
		{'default:grass_1', 'default:grass_1', 'default:grass_1'},
	}
})

-- leafroof dark


minetest.register_craft({
	output = 'lottblocks:leafroof_dark',
	recipe = {
		{'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves'},
	}
})

-- MALLORN
-- leafroof mallorn

minetest.register_craft({
	output = 'lottblocks:leafroof_mallorn',
	recipe = {
		{'lottplants:mallornleaf', 'lottplants:mallornleaf'},
		{'lottplants:mallornleaf', 'lottplants:mallornleaf'},
	}
})

-- White mallorn

minetest.register_craft({
	output = 'lottblocks:mallorn_white',
	recipe = {
		{'dye:white'},
		{'lottplants:mallornwood'},
	}
})

-- Mallorn pillar

minetest.register_craft({
	output = 'lottblocks:mallorn_pillar',
	recipe = {
		{'lottplants:mallorntree', 'default:gold_ingot'},
		{'default:gold_ingot', 'lottplants:mallorntree'},
	}
})

-- DWARFSTONE
-- white

minetest.register_craft({
	output = 'lottblocks:dwarfstone_white 4',
	recipe = {
		{'default:steel_ingot', 'default:stone', 'default:steel_ingot'},
		{'default:stone', 'default:steel_ingot', 'default:stone'},
		{'default:steel_ingot', 'default:stone', 'default:steel_ingot'},
	}
})

-- black

minetest.register_craft({
	output = 'lottblocks:dwarfstone_black 4',
	recipe = {
		{'default:coal_lump', 'default:stone', 'default:coal_lump'},
		{'default:stone', 'default:coal_lump', 'default:stone'},
		{'default:coal_lump', 'default:stone', 'default:coal_lump'},
	}
})

-- stripe

minetest.register_craft({
	output = 'lottblocks:dwarfstone_stripe 4',
	recipe = {
		{'default:stone', 'default:coal_lump'},
		{'default:stone', 'default:coal_lump'},
	}
})

--[[Dwarf Tombs, by Amaz.
minetest.register_node("lottblocks:dwarf_tomb_top", {
	description = "Dwarf Tomb",
	drawtype = "nodebox",
	tiles = {
		"lottblocks_dh_top.png", "default_stone.png",
		"lottblocks_dh_side2.png", "lottblocks_dh_side1.png",
		"lottblocks_dh_back.png", "lottblocks_dh_front.png",
	},
	paramtype = "light",
	groups = {cracky = 1},
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			--{x-, y-, z-, x+, y+, z+}
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, -- NodeBox1
			{0.4375, -0.375, 0.125, -0.4375, -0.3125, -0.5}, -- NodeBox3
			{0.375, -0.3125, 0.125, -0.375, -0.1875, -0.5}, -- NodeBox4
			{0.3125, -0.1875, 0.125, -0.3125, -0.0625, -0.5}, -- NodeBox5
			{0.125, -0.0625, -0.3125, -0.125, 0.0625, -0.5}, -- NodeBox6
			{0.0625, -0.0625, -0.1875, -0.0625, 0, -0.3125}, -- NodeBox7
			{0.3125, -0.0625, -0.375, -0.3125, 0, -0.5}, -- NodeBox10
			{-0.25, -0.0625, 0, -0.3125, 0, -0.5}, -- NodeBox11
			{0.1875, -0.0625, -0.0625, 0.3125, 0, 0.0625}, -- NodeBox13
			{0.3125, -0.0625, 0.0625, 0.25, 0, -0.5}, -- NodeBox14
			{0.3125, -0.0625, 0.0625, 0.1875, 0, -0.0625}, -- NodeBox16
			{0.4375, -0.375, 0.5, -0.4375, -0.0625, 0.125}, -- NodeBox17
			{0.25, -0.0625, 0.5, -0.25, 0.0625, 0.0625}, -- NodeBox18
			{-0.0625, -0.0625, -0.125, 0.125, 0, 0.125}, -- NodeBox19
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -1.5, 0.5, 0.0625, 0.5}
		}
	},
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local pos
		if minetest.registered_items[minetest.get_node(under).name].buildable_to then
			pos = under
		else
			pos = pointed_thing.above
		end

		if minetest.is_protected(pos, placer:get_player_name()) and
				not minetest.check_player_privs(placer, "protection_bypass") then
			minetest.record_protection_violation(pos, placer:get_player_name())
			return itemstack
		end

		local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
		if not node_def or not node_def.buildable_to then
			return itemstack
		end

		local dir = minetest.dir_to_facedir(placer:get_look_dir())
		local botpos = vector.subtract(pos, minetest.facedir_to_dir(dir))

		if minetest.is_protected(botpos, placer:get_player_name()) and
				not minetest.check_player_privs(placer, "protection_bypass") then
			minetest.record_protection_violation(botpos, placer:get_player_name())
			return itemstack
		end

		local botdef = minetest.registered_nodes[minetest.get_node(botpos).name]
		if not botdef or not botdef.buildable_to then
			return itemstack
		end

		minetest.set_node(pos, {name = "lottblocks:dwarf_tomb_top", param2 = dir})
		minetest.set_node(botpos, {name = "lottblocks:dwarf_tomb_bottom", param2 = dir})

		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
	on_destruct = function(pos)
		local node = minetest.get_node(pos)
		local dir = minetest.facedir_to_dir(node.param2)
		local other = vector.subtract(pos, dir)
		minetest.remove_node(other)
	end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottblocks:dwarf_tomb_bottom", {
	description = "Dwarf Tomb Bottom",
	tiles = {
		"lottblocks_db_top.png", "default_stone.png",
		"lottblocks_db_side2.png", "lottblocks_db_side1.png",
		"lottblocks_db_back.png", "lottblocks_db_front.png",
	},
	pointable = false,
	groups = {not_in_creative_inventory = 1},
	paramtype2 = "facedir",
	drawtype = "nodebox",
	drop = "lottblocks:dwarf_tomb_top",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, -- NodeBox1
			{0.4375, -0.375, 0.5, -0.4375, -0.3125, -0.375}, -- NodeBox2
			{0.375, -0.3125, 0.5, -0.375, -0.1875, -0.3125}, -- NodeBox3
			{0.25, -0.1875, 0.5, -0.25, -0.0625, -0.3125}, -- NodeBox5
			{-0.0625, -0.0625, 0.5, 0.0625, 0, 0.375}, -- NodeBox6
			{0.0625, -0.0625, 0.375, -0.0625, 0, -0.1875}, -- NodeBox8
			{0.25, -0.0625, 0.0625, -0.25, 0, -0.1875}, -- NodeBox8
		}
	},
	sounds = default.node_sound_stone_defaults(),
})
]]