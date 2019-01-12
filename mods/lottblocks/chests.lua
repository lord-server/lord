local SL = lord.require_intllib()

minetest.register_tool("lottblocks:lockpick", {
	description     = SL("Lockpick"),
	inventory_image = "lottblocks_steel_lockpick.png", --Made by HeroOfTheWinds
	--https://github.com/HeroOfTheWinds/lockpicks/blob/master/textures/steel_lockpick.png
	max_stack       = 1,
})

minetest.register_craft({
	output = "lottblocks:lockpick",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "", "default:steel_ingot", "default:steel_ingot" },
		{ "", "group:stick", "" }
	}
})

minetest.register_node("lottblocks:hobbit_chest", {
	description           = SL("Hobbit Chest"),
	tiles                 = {
		"lottblocks_hobbit_chest_top.png", "lottblocks_hobbit_chest_top.png", "lottblocks_hobbit_chest_side.png",
		"lottblocks_hobbit_chest_side.png", "lottblocks_hobbit_chest_side.png", "lottblocks_hobbit_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Hobbit Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "hobbit" then
			minetest.show_formspec(
				player, "lottblocks:hobbit_chest", default.get_chest_formspec(pos, "gui_hobbitbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:hobbit_chest", default.get_chest_formspec(pos, "gui_hobbitbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Hobbits can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Hobbit Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_node("lottblocks:gondor_chest", {
	description           = SL("Gondorian Chest"),
	tiles                 = {
		"lottblocks_gondor_chest_top.png", "lottblocks_gondor_chest_bottom.png", "lottblocks_gondor_chest_side.png",
		"lottblocks_gondor_chest_side.png", "lottblocks_gondor_chest_side.png", "lottblocks_gondor_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Gondorian Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "man" then
			minetest.show_formspec(
				player,
				"lottblocks:gondor_chest",
				default.get_chest_formspec(pos, "gui_gondorbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:gondor_chest", default.get_chest_formspec(pos, "gui_gondorbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Humans can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Gondorian Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_node("lottblocks:rohan_chest", {
	description           = SL("Rohirrim Chest"),
	tiles                 = {
		"lottblocks_rohan_chest_top.png", "lottblocks_rohan_chest_bottom.png", "lottblocks_rohan_chest_side.png",
		"lottblocks_rohan_chest_side.png", "lottblocks_rohan_chest_side.png", "lottblocks_rohan_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Rohirrim Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "man" then
			minetest.show_formspec(
				player,
				"lottblocks:rohan_chest",
				default.get_chest_formspec(pos, "gui_rohanbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:rohan_chest", default.get_chest_formspec(pos, "gui_rohanbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Humans can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Rohirrim Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_node("lottblocks:elfloth_chest", {
	description           = SL("Elven (Lorien) Chest"),
	tiles                 = {
		"lottblocks_elf_chest_top.png", "lottblocks_elf_chest_bottom.png", "lottblocks_elf_chest_side.png",
		"lottblocks_elf_chest_side.png", "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Elven (Lorien) Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "elf" then
			minetest.show_formspec(
				player,
				"lottblocks:elfloth_chest",
				default.get_chest_formspec(pos, "gui_elfbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:elfloth_chest", default.get_chest_formspec(pos, "gui_elfbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Elves can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Elven (Lorien) Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_node("lottblocks:elfmirk_chest", {
	description           = SL("Elven (Mirkwood) Chest"),
	tiles                 = {
		"lottblocks_elf_chest_top.png", "lottblocks_elf_chest_bottom.png", "lottblocks_elf_chest_side.png",
		"lottblocks_elf_chest_side.png", "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Elven (Mirkwood) Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "elf" then
			minetest.show_formspec(
				player,
				"lottblocks:elfmirk_chest",
				default.get_chest_formspec(pos, "gui_elfbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:elfmirk_chest", default.get_chest_formspec(pos, "gui_elfbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Elves can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Elven (Mirkwood) Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_node("lottblocks:mordor_chest", {
	description           = SL("Mordor Chest"),
	tiles                 = {
		"lottblocks_mordor_chest_top.png", "lottblocks_mordor_chest_top.png", "lottblocks_mordor_chest_side.png",
		"lottblocks_mordor_chest_side.png", "lottblocks_mordor_chest_side.png", "lottblocks_mordor_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Mordor Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "orc" then
			minetest.show_formspec(
				player,
				"lottblocks:mordor_chest",
				default.get_chest_formspec(pos, "gui_mordorbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:mordor_chest", default.get_chest_formspec(pos, "gui_mordorbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Orcs can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Mordor Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_node("lottblocks:angmar_chest", {
	description           = SL("Angmar Chest"),
	tiles                 = {
		"lottblocks_angmar_chest_top.png", "lottblocks_angmar_chest_top.png", "lottblocks_angmar_chest_side.png",
		"lottblocks_angmar_chest_side.png", "lottblocks_angmar_chest_side.png", "lottblocks_angmar_chest_front.png",
	},
	paramtype2            = "facedir",
	groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_wood_defaults(),
	on_construct          = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Angmar Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_rightclick         = function(pos, node, clicker, itemstack)
		local player = clicker:get_player_name()
		local item   = itemstack:get_name()
		if races.get_race_and_gender(player)[1] == "orc" then
			minetest.show_formspec(
				player,
				"lottblocks:angmar_chest",
				default.get_chest_formspec(pos, "gui_angmarbg.png")
			)
		elseif item == "lottblocks:lockpick" then
			if math.random(1, 4) ~= 3 then
				itemstack:add_wear(65535 / 20)
				minetest.chat_send_player(player, SL("Lockpick failed"))
			else
				itemstack:add_wear(65535 / 18)
				minetest.show_formspec(
					player, "lottblocks:angmar_chest", default.get_chest_formspec(pos, "gui_angmarbg.png")
				)
			end
		else
			minetest.chat_send_player(player, SL("Only Orcs can open this kind of chest!"))
		end
	end,
	can_dig               = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("main")
	end,
	--backwards compatibility: punch to set formspec
	on_punch              = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Angmar Chest"))
		meta:set_string("formspec", "")
	end,
})

minetest.register_craft({
	output = "lottblocks:hobbit_chest",
	recipe = {
		{ "lottplants:birchwood", "lottplants:birchwood", "lottplants:birchwood" },
		{ "lottplants:birchwood", "", "lottplants:birchwood" },
		{ "lottplants:birchwood", "lottplants:birchwood", "lottplants:birchwood" },
	}
})

minetest.register_craft({
	output = "lottblocks:gondor_chest",
	recipe = {
		{ "lottplants:alderwood", "lottplants:alderwood", "lottplants:alderwood" },
		{ "lottplants:alderwood", "", "lottplants:alderwood" },
		{ "lottplants:alderwood", "lottplants:alderwood", "lottplants:alderwood" },
	}
})

minetest.register_craft({
	output = "lottblocks:rohan_chest",
	recipe = {
		{ "lottplants:lebethronwood", "lottplants:lebethronwood", "lottplants:lebethronwood" },
		{ "lottplants:lebethronwood", "", "lottplants:lebethronwood" },
		{ "lottplants:lebethronwood", "lottplants:lebethronwood", "lottplants:lebethronwood" },
	}
})

minetest.register_craft({
	output = "lottblocks:elfloth_chest",
	recipe = {
		{ "lottplants:mallornwood", "lottplants:mallornwood", "lottplants:mallornwood" },
		{ "lottplants:mallornwood", "", "lottplants:mallornwood" },
		{ "lottplants:mallornwood", "lottplants:mallornwood", "lottplants:mallornwood" },
	}
})

minetest.register_craft({
	output = "lottblocks:elfmirk_chest",
	recipe = {
		{ "default:junglewood", "default:junglewood", "default:junglewood" },
		{ "default:junglewood", "", "default:junglewood" },
		{ "default:junglewood", "default:junglewood", "default:junglewood" },
	}
})

minetest.register_craft({
	output = "lottblocks:mordor_chest",
	recipe = {
		{ "lottmapgen:mordor_stone", "lottmapgen:mordor_stone", "lottmapgen:mordor_stone" },
		{ "lottmapgen:mordor_stone", "", "lottmapgen:mordor_stone" },
		{ "lottmapgen:mordor_stone", "lottmapgen:mordor_stone", "lottmapgen:mordor_stone" },
	}
})

minetest.register_craft({
	output = "lottblocks:angmar_chest",
	recipe = {
		{ "lottplants:pinewood", "lottplants:pinewood", "lottplants:pinewood" },
		{ "lottplants:pinewood", "", "lottplants:pinewood" },
		{ "lottplants:pinewood", "lottplants:pinewood", "lottplants:pinewood" },
	}
})

minetest.register_alias("lottmapgen:hobbit_chest", "lottblocks:hobbit_chest")
minetest.register_alias("lottmapgen:gondor_chest", "lottblocks:gondor_chest")
minetest.register_alias("lottmapgen:rohan_chest", "lottblocks:rohan_chest")
minetest.register_alias("lottmapgen:elfloth_chest", "lottblocks:elfloth_chest")
minetest.register_alias("lottmapgen:elfmirk_chest", "lottblocks:elfmirk_chest")
minetest.register_alias("lottmapgen:mordor_chest", "lottblocks:mordor_chest")
minetest.register_alias("lottmapgen:angmar_chest", "lottblocks:angmar_chest")
