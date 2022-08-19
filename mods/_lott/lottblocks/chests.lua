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

-- Регистрация "расового" сундука
-- Принимает:
-- - name - название ноды;
-- - desc - описание ноды;
-- - tiles - тайлы ноды;
-- - owner_race - раса, которая может открывать сундук;
-- - background - текстура фона сундука;
-- - fail_text - текст, печатающийся при несоответствии расы сундуку.
local function register_race_chest(name, desc, tiles, owner_race, background, fail_text)
	minetest.register_node(name, {
		description           = desc,
		tiles                 = tiles,
		paramtype2            = "facedir",
		groups                = { choppy = 2, oddly_breakable_by_hand = 2, wooden = 1, smallchest = 1 },
		legacy_facedir_simple = true,
		is_ground_content     = false,
		sounds                = default.node_sound_wood_defaults(),
		on_construct          = function(pos, node, active_object_count, active_object_count_wider)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", desc)
			local inv = meta:get_inventory()
			inv:set_size("main", 8 * 4)
		end,
		on_rightclick         = function(pos, node, clicker, itemstack)
			local player = clicker:get_player_name()
			local item   = itemstack:get_name()
			if races.get_race_and_gender(player)[1] == owner_race or minetest.is_creative_enabled(player) then
				minetest.show_formspec(player, name, default.chest.get_chest_formspec(pos, background))
			elseif item == "lottblocks:lockpick" then
				if math.random(1, 4) ~= 3 then
					itemstack:add_wear(65535 / 20)
					minetest.chat_send_player(player, SL("Lockpick failed"))
				else
					itemstack:add_wear(65535 / 18)
					minetest.show_formspec(player, name, default.chest.get_chest_formspec(pos, background))
				end
			else
				minetest.chat_send_player(player, fail_text)
			end
		end,
		can_dig               = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv  = meta:get_inventory()
			return inv:is_empty("main")
		end,
		on_punch              = function(pos, player)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", name)
			meta:set_string("formspec", "")
		end,
	})
end

register_race_chest("lottblocks:hobbit_chest", SL("Hobbit Chest"),
	{
		"lottblocks_hobbit_chest_top.png", "lottblocks_hobbit_chest_top.png", "lottblocks_hobbit_chest_side.png",
		"lottblocks_hobbit_chest_side.png", "lottblocks_hobbit_chest_side.png", "lottblocks_hobbit_chest_front.png",
	},
	"hobbit", "gui_hobbitbg.png", SL("Only Hobbits can open this kind of chest!"))

register_race_chest("lottblocks:gondor_chest", SL("Gondorian Chest"),
	{
		"lottblocks_gondor_chest_top.png", "lottblocks_gondor_chest_bottom.png", "lottblocks_gondor_chest_side.png",
		"lottblocks_gondor_chest_side.png", "lottblocks_gondor_chest_side.png", "lottblocks_gondor_chest_front.png",
	},
	"man", "gui_gondorbg.png", SL("Only Humans can open this kind of chest!"))

register_race_chest("lottblocks:rohan_chest", SL("Rohirrim Chest"),
	{
		"lottblocks_rohan_chest_top.png", "lottblocks_rohan_chest_bottom.png", "lottblocks_rohan_chest_side.png",
		"lottblocks_rohan_chest_side.png", "lottblocks_rohan_chest_side.png", "lottblocks_rohan_chest_front.png",
	},
	"man", "gui_rohanbg.png", SL("Only Humans can open this kind of chest!"))

register_race_chest("lottblocks:elfloth_chest", SL("Elven (Lorien) Chest"),
	{
		"lottblocks_elf_chest_top.png", "lottblocks_elf_chest_bottom.png", "lottblocks_elf_chest_side.png",
		"lottblocks_elf_chest_side.png", "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_front.png",
	},
	"elf", "gui_elfbg.png", SL("Only Elves can open this kind of chest!"))

register_race_chest("lottblocks:elfmirk_chest", SL("Elven (Mirkwood) Chest"),
	{
		"lottblocks_elf_chest_top.png", "lottblocks_elf_chest_bottom.png", "lottblocks_elf_chest_side.png",
		"lottblocks_elf_chest_side.png", "lottblocks_elf_chest_side.png", "lottblocks_elf_chest_front.png",
	},
	"elf", "gui_elfbg.png", SL("Only Elves can open this kind of chest!"))

register_race_chest("lottblocks:mordor_chest", SL("Mordor Chest"),
	{
		"lottblocks_mordor_chest_top.png", "lottblocks_mordor_chest_top.png", "lottblocks_mordor_chest_side.png",
		"lottblocks_mordor_chest_side.png", "lottblocks_mordor_chest_side.png", "lottblocks_mordor_chest_front.png",
	},
	"orc", "gui_mordorbg.png", SL("Only Orcs can open this kind of chest!"))

register_race_chest("lottblocks:angmar_chest", SL("Angmar Chest"),
	{
		"lottblocks_angmar_chest_top.png", "lottblocks_angmar_chest_top.png", "lottblocks_angmar_chest_side.png",
		"lottblocks_angmar_chest_side.png", "lottblocks_angmar_chest_side.png", "lottblocks_angmar_chest_front.png",
	},
	"orc", "gui_angmarbg.png", SL("Only Orcs can open this kind of chest!"))

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
