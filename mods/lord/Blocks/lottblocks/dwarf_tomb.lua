local S = minetest.get_translator("lottblocks")

local common_definition = {
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	drop = "lottblocks:dwarf_tomb_top",
	sounds = default.node_sound_stone_defaults(),
}

local tomb_top = table.merge(common_definition, {
	description = S("Dwarf Tomb"),
	tiles = {
		"lottblocks_dh_top.png", "default_stone.png",
		"lottblocks_dh_side2.png", "lottblocks_dh_side1.png",
		"lottblocks_dh_back.png", "lottblocks_dh_front.png",
	},
	groups = {cracky = 1},
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
	on_destruct = function(pos)
		local node  = minetest.get_node(pos)
		local dir   = minetest.facedir_to_dir(node.param2)
		local other = vector.subtract(pos, dir)
		minetest.remove_node(other)
	end,
})

local tomb_bottom = table.merge(common_definition, {
	description = S("Dwarf Tomb Bottom (placeholder)"),
	tiles = {
		"lottblocks_db_top.png", "default_stone.png",
		"lottblocks_db_side2.png", "lottblocks_db_side1.png",
		"lottblocks_db_back.png", "lottblocks_db_front.png",
	},
	pointable = false,
	groups = {not_in_creative_inventory = 1},
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
})


-- MapGen only blocks.
-- Follow two blocks are spawned only on map dungeon generation.
minetest.register_node("lottblocks:gen_dwarf_tomb_top", table.merge(tomb_top, {
	description = S("Generated @1", tomb_top.description),
	drop = {
		max_items = 3,
		items = {
			{items = {"lottother:dwarf_ring"},         rarity = 100/3},  -- 3%
			{items = {"lottblocks:dwarf_tomb_top"}},
			{items = {"lottarmor:chestplate_mithril"}, rarity = 100/50}, -- 50%
			{items = {"lottarmor:helmet_mithril"},     rarity = 100/50}, -- 50%
		}
	},
}))

minetest.register_node("lottblocks:gen_dwarf_tomb_bottom", table.merge(tomb_bottom, {
	description = S("Generated @1", tomb_bottom.description),
}))


-- Tomb nodes for players.
-- Follow two blocks are drops from generated ones and used when player place the tomb.
minetest.register_node("lottblocks:dwarf_tomb_top", table.merge(tomb_top, {
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

		if not minetest.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
}))

minetest.register_node("lottblocks:dwarf_tomb_bottom", tomb_bottom)
