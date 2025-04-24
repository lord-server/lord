-- AWARDS
--
-- Copyright (C) 2013-2015 rubenwardy
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- You should have received a copy of the GNU Lesser General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--

local S = minetest.get_mod_translator()

-- The global award namespace
lottachievements = {
	show_mode = "hud"
}

dofile(minetest.get_modpath("lottachievements") .. "/api.lua")
dofile(minetest.get_modpath("lottachievements") .. "/chat_commands.lua")
dofile(minetest.get_modpath("lottachievements") .. "/triggers.lua")

-- To add achievements in the middle of ids (e.g. between 29 and 30),
-- use the script at the bottom of the file, changing the variables as needed.

minetest.register_craftitem("lottachievements:achievement_book", {
	description     = S("Achievements Book"),
	inventory_image = "lottachievements_achievement_book.png",
	groups          = { book = 1 },
	stack_max       = 1,
	on_use          = function(_, player)
		local name = player:get_player_name()
		lottachievements.show_to(name, name)
	end,
})

minetest.register_craft({
	output = 'lottachievements:achievement_book',
	recipe = {
		{ 'lottores:blue_gem', 'lottores:tilkal_ingot', 'lottother:purple_gem' },
		{ 'default:mese_crystal', 'default:book', 'default:diamond' },
		{ 'lottores:white_gem', 'lottother:ringsilver_ingot', 'lottores:red_gem' },
	}
})
-- Different achievements
if (equipment) then
	equipment.on_set(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
		lottachievements.equip(item, player, 1)
	end)
	equipment.on_delete(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
		lottachievements.equip(item, player, -1)
	end)
end

lottachievements.register_achievement("master_craftsman", {
	title       = S("Master Craftsman"),
	description = S("Craft a Master Book of Crafts"),
	icon        = "master_book.png",
	id          = 1,
	trigger     = {
		type   = "craft",
		item   = "lord_books:master_book",
		target = 1,
	}
})

lottachievements.register_achievement("i_achieved_this", {
	title       = S("I achieved this!"),
	description = S("Make the Achievements Book"),
	icon        = "lottachievements_achievement_book.png",
	id          = 2,
	trigger     = {
		type   = "craft",
		item   = "lottachievements:achievement_book",
		target = 1,
	}
})

lottachievements.register_achievement("rope_is_useful", {
	title       = S("Rope is useful!"),
	description = S("Craft 100 meters of elven rope"),
	icon        = "lottblocks_elven_rope.png",
	id          = 3,
	trigger     = {
		type   = "craft",
		item   = "lottblocks:elven_rope",
		target = 100,
	}
})

lottachievements.register_achievement("silver_stringed_music", {
	title       = S("Silver Stringed Music"),
	description = S("Craft a dwarvern harp"),
	icon        = "lottblocks_harp_strings.png",
	id          = 4,
	trigger     = {
		type   = "craft",
		item   = "lottblocks:dwarf_harp",
		target = 1,
	}
})

lottachievements.register_achievement("express_miner", {
	title       = S("Express Miner"),
	description = S("Craft a mithril pickaxe"),
	icon        = "lottores_mithrilpick.png",
	id          = 5,
	trigger     = {
		type   = "craft",
		item   = "tools:pick_mithril",
		target = 1,
	}
})

lottachievements.register_achievement("elf_and_dwarf_cooperation", {
	title       = S("Elf and Dwarf Cooperation"),
	description = S("Place at least 6 ithildin stone"),
	icon        = "default_stone.png^ithildin_1.png",
	id          = 6,
	trigger     = {
		type   = "place",
		node   = "lottores:ithildin_stone_1",
		target = 6,
	}
})

lottachievements.register_achievement("chains_of_melkor", {
	title       = S("Chains of Melkor"),
	description = S("Craft a tilkal ingot"),
	icon        = "lottores_tilkal_ingot.png",
	id          = 7,
	trigger     = {
		type   = "craft",
		item   = "lottores:tilkal_ingot",
		target = 1
	}
})

lottachievements.register_achievement("tourist", {
	title       = S("Tourist"),
	description = S("Take a fire"),
	icon        = "campfire.png",
	id          = 8,
	trigger     = {
		type   = "place",
		node   = "campfire:campfire",
		target = 1,
	}
})

lottachievements.register_achievement("his_arm_has_grown_long", {
	title       = S("His arm has grown long indeed"),
	description = S("Craft a mithril spear"),
	icon        = "tools_spear_mithril.png",
	id          = 9,
	trigger     = {
		type   = "craft",
		item   = "tools:spear_mithril",
		target = 1
	}
})

lottachievements.register_achievement("marksman_of_lorien", {
	title       = S("Marksman of Lorien"),
	description = S("Craft a mallorn bow"),
	icon        = "lord_archery_mallorn_wood_bow.png",
	id          = 10,
	trigger     = {
		type   = "craft",
		item   = "lord_archery:mallorn_wood_bow",
		target = 1
	}
})

lottachievements.register_achievement("merry_shire", {
	title       = S("Merry Shire"),
	description = S("Visit Shire and get his soil"),
	icon        = "default_dirt.png^lord_ground_dirt_shire_side.png",
	id          = 11,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_shire",
		target = 1,
	}
})

lottachievements.register_achievement("the_golden_lorien", {
	title       = S("The Golden Lorien"),
	description = S("Visit the forests of Lorien and get their soil"),
	icon        = "default_dirt.png^lord_ground_dirt_lorien_side.png",
	id          = 12,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_lorien",
		target = 1,
	}
})

lottachievements.register_achievement("damaged_greenwood", {
	title       = S("Damaged Greenwood"),
	description = S("Visit the forests of Liholsye and get their soil"),
	icon        = "default_dirt.png^lord_ground_dirt_mirkwood_side.png",
	id          = 13,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_mirkwood",
		target = 1,
	}
})

lottachievements.register_achievement("iron_hills", {
	title       = S("Iron Hills"),
	description = S("Visit the Iron Hills and get his soil"),
	icon        = "default_dirt.png^lord_ground_dirt_dunland_side.png",
	id          = 14,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_iron_hills",
		target = 1,
	}
})

lottachievements.register_achievement("frozen_angmar", {
	title       = S("Frozen Angmar"),
	description = S("Visit Angmar, and get his soil"),
	icon        = "default_dirt.png^default_snow_side.png",
	id          = 15,
	trigger     = {
		type   = "dig",
		node   = "default:dirt_with_snow",
		target = 1,
	}
})

lottachievements.register_achievement("lands_of_rohan", {
	title       = S("Lands of Rohan"),
	description = S("Visit Rohan and get his soil"),
	icon        = "default_dirt.png^lord_ground_dirt_rohan_side.png",
	id          = 16,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_rohan",
		target = 1,
	}
})

lottachievements.register_achievement("lands_of_gondor", {
	title       = S("Lands of Gondor"),
	description = S("Visit Gondor and get his soil"),
	icon        = "default_dirt.png^default_grass_side.png",
	id          = 17,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_gondor",
		target = 1,
	}
})

lottachievements.register_achievement("live_fangorn", {
	title       = S("Live Fangorn"),
	description = S("Visit the forests of Fargorn and get their soil"),
	icon        = "default_dirt.png^default_grass_side.png",
	id          = 18,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_fangorn",
		target = 1,
	}
})

lottachievements.register_achievement("anxious_dunland", {
	title       = S("Anxious Dunland"),
	description = S("Visit Dunland and get its soil"),
	icon        = "default_dirt.png^lord_ground_dirt_dunland_side.png",
	id          = 19,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_dunland",
		target = 1,
	}
})

lottachievements.register_achievement("calm_ithilien", {
	title       = S("Calm Ithilien"),
	description = S("Visit Ithilien and get his soil"),
	icon        = "default_dirt.png^default_grass_side.png",
	id          = 20,
	trigger     = {
		type   = "dig",
		node   = "lord_ground:dirt_ithilien",
		target = 1,
	}
})

lottachievements.register_achievement("in_the_lands_of_mordor", {
	title       = S("In the lands of Mordor ..."),
	description = S("Visit Mordor and get Mordor stone as evidence"),
	icon        = "lord_rocks_mordor_stone.png",
	id          = 21,
	trigger     = {
		type   = "dig",
		node   = "lord_rocks:mordor_stone",
		target = 1,
	}
})

lottachievements.register_achievement("dungeons_deep_and_caverns_old", {
	title       = S("Dungeons Deep and Caverns Old"),
	description = S("Find an underground dungeon"),
	icon        = "default_mossycobble.png",
	id          = 22,
	trigger     = {
		type   = "dig",
		node   = "default:mossycobble",
		target = 1,
	}
})

lottachievements.register_achievement("a_small_patch_of_lorien", {
	title       = S("A small patch of Lorien"),
	description = S("Plant 7 seedlings of mallory"),
	icon        = "lord_trees_mallorn_sapling.png",
	id          = 23,
	trigger     = {
		type   = "place",
		node   = "lord_trees:mallorn_sapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_gondor", {
	title       = S("A small patch of Gondor"),
	description = S("Plant 7 seedlings of white tree of a gondor"),
	icon        = "lord_trees_white_sapling.png",
	id          = 24,
	trigger     = {
		type   = "place",
		node   = "lord_trees:white_sapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_iron_hills", {
	title       = S("A small patch of Iron Hills"),
	description = S("Plant 7 seedlings of pine"),
	icon        = "lord_trees_pine_sapling.png",
	id          = 25,
	trigger     = {
		type   = "place",
		node   = "lord_trees:pine_sapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_shire", {
	title       = S("A small patch of Shire"),
	description = S("Plant 7 seedlings of plums"),
	icon        = "lord_trees_plum_sapling.png",
	id          = 26,
	trigger     = {
		type   = "place",
		node   = "lord_trees:plum_sapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_immortal", {
	title       = S("A small patch of Ititian"),
	description = S("Plant 7 seedlings of the elm"),
	icon        = "lord_trees_elm_sapling.png",
	id          = 27,
	trigger     = {
		type   = "place",
		node   = "lord_trees:elm_sapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_fangorn", {
	title       = S("A small patch of Fangorn"),
	description = S("Plant 7 seedlings of culumalda"),
	icon        = "lord_trees_culumalda_sapling.png",
	id          = 28,
	trigger     = {
		type   = "place",
		node   = "lord_trees:culumalda_sapling",
		target = 7,
	}
})

lottachievements.register_achievement("foot_soldier", {
	title       = S("Foot Soldier"),
	description = S("Equip a full set of steel armor"),
	icon        = "lottarmor_inv_chestplate_steel.png",
	id          = 29,
	trigger     = {
		type = "equip",
		item = "lottarmor:chestplate_steel",
	}
})

lottachievements.register_achievement("dwarvern_lord", {
	title       = S("Dwarven Lord"),
	description = S("Equip a full set of mithril armor"),
	icon        = "lottarmor_inv_chestplate_mithril.png",
	id          = 30,
	trigger     = {
		type = "equip",
		item = "lottarmor:chestplate_mithril",
	}
})

lottachievements.register_achievement("elven_lord", {
	title       = S("Elven Lord"),
	description = S("Equip a full set of galvorn armor"),
	icon        = "lottarmor_inv_chestplate_galvorn.png",
	id          = 31,
	trigger     = {
		type = "equip",
		item = "lottarmor:chestplate_galvorn",
	}
})

lottachievements.register_achievement("rohirric_king", {
	title       = S("Rohirric King"),
	description = S("Equip a full set of gold armor"),
	icon        = "lottarmor_inv_chestplate_gold.png",
	id          = 32,
	trigger     = {
		type = "equip",
		item = "lottarmor:chestplate_gold",
	}
})

lottachievements.register_achievement("ringing_wheels", {
	title       = S("Ringing wheels"),
	description = S("Lay 100 m of conventional rail"),
	icon        = "carts_rail_straight.png^lottachievements_level1.png",
	id          = 33,
	trigger     = {
		type   = "place",
		node   = "carts:rail",
		target = 100,
	}
})

lottachievements.register_achievement("trail_men", {
	title       = S("Trail men"),
	description = S("Lay 1000 m of conventional rail"),
	icon        = "carts_rail_straight.png^lottachievements_level2.png",
	requires    = "ringing_wheels",
	id          = 34,
	trigger     = {
		type   = "place",
		node   = "carts:rail",
		target = 1000,
	}
})

lottachievements.register_achievement("with_the_wind", {
	title       = S("With the wind"),
	description = S("Install 50 steam engines"),
	icon        = "carts_steam_mechanism3.png",
	id          = 35,
	trigger     = {
		type   = "place",
		node   = "carts:steam_mechanism",
		target = 50,
	}
})

lottachievements.register_achievement("brake", {
	title       = S("Brake!"),
	description = S("Lay 40 m stopping rail"),
	icon        = "carts_rail_straight_brk.png",
	id          = 36,
	trigger     = {
		type   = "place",
		node   = "carts:brakerail",
		target = 40,
	}
})

lottachievements.register_achievement("first_truesilver", {
	title       = S("First Truesilver"),
	description = S("Mine 1 mithril ore"),
	icon        = "default_stone.png^lottores_mithril_ore.png^lottachievements_level1.png",
	id          = 37,
	trigger     = {
		type   = "dig",
		node   = "lottores:mithril_ore",
		target = 1
	}
})

lottachievements.register_achievement("dwarvern_miner", {
	title       = S("Dwarven Miner"),
	description = S("Mine 99 mithril ore"),
	icon        = "default_stone.png^lottores_mithril_ore.png^lottachievements_level2.png",
	requires    = "first_truesilver",
	id          = 38,
	trigger     = {
		type   = "dig",
		node   = "lottores:mithril_ore",
		target = 99
	}
})

lottachievements.register_achievement("ammassing_fortune", {
	title       = S("Amassing Fortune"),
	description = S("Mine 500 mithril ore"),
	icon        = "default_stone.png^lottores_mithril_ore.png^lottachievements_level3.png",
	requires    = "dwarvern_miner",
	id          = 39,
	trigger     = {
		type   = "dig",
		node   = "lottores:mithril_ore",
		target = 500
	}
})

lottachievements.register_achievement("truly_rich", {
	title       = S("Truly Rich"),
	description = S("Mine 1000 mithril ore"),
	icon        = "default_stone.png^lottores_mithril_ore.png^lottachievements_level4.png",
	requires    = "ammassing_fortune",
	id          = 40,
	trigger     = {
		type   = "dig",
		node   = "lottores:mithril_ore",
		target = 1000
	}
})

lottachievements.register_achievement("lord_of_moria", {
	title       = S("Lord of Moria"),
	description = S("Mine 5000 mithril ore"),
	icon        = "default_stone.png^lottores_mithril_ore.png^lottachievements_level5.png",
	requires    = "truly_rich",
	id          = 41,
	trigger     = {
		type   = "dig",
		node   = "lottores:mithril_ore",
		target = 5000
	}
})

lottachievements.register_achievement("little_cave", {
	title       = S("Little cave"),
	description = S("Dig out 100 of cobblestone"),
	icon        = "lottores_goldpick.png^lottachievements_level1.png",
	secret      = true,
	id          = 42,
	trigger     = {
		type   = "dig",
		node   = "default:stone",
		target = 100,
	}
})

lottachievements.register_achievement("miner", {
	title       = S("Miner"),
	description = S("Dig out 1000 of cobblestone"),
	icon        = "lottores_goldpick.png^lottachievements_level2.png",
	secret      = true,
	requires    = "little_cave",
	id          = 43,
	trigger     = {
		type   = "dig",
		node   = "default:stone",
		target = 1000,
	}
})

lottachievements.register_achievement("pick_man", {
	title       = S("Pick-man"),
	description = S("Dig out 10000 of cobblestone"),
	icon        = "lottores_goldpick.png^lottachievements_level3.png",
	secret      = true,
	requires    = "miner",
	id          = 44,
	trigger     = {
		type   = "dig",
		node   = "default:stone",
		target = 10000,
	}
})

lottachievements.register_achievement("first_time_for_everything", {
	title       = S("First Time for Everything"),
	description = S("Die once!"),
	secret      = true,
	id          = 45,
	icon        = "lottachievements_skull.png^lottachievements_level1.png",
	trigger     = {
		type   = "death",
		target = 1,
	}
})

lottachievements.register_achievement("not_again", {
	title       = S("Not Again!"),
	description = S("Die a second time"),
	icon        = "lottachievements_skull.png^lottachievements_level2.png",
	secret      = true,
	requires    = "first_time_for_everything",
	id          = 46,
	trigger     = {
		type   = "death",
		target = 2,
	}
})

lottachievements.register_achievement("this_is_becoming_a_habit", {
	title       = S("This is becoming a habit..."),
	description = S("Die 10 times!"),
	icon        = "lottachievements_skull.png^lottachievements_level3.png",
	secret      = true,
	requires    = "not_again",
	id          = 47,
	trigger     = {
		type   = "death",
		target = 10,
	}
})

lottachievements.register_achievement("im_getting_good_at_this", {
	title       = S("I'm getting good at this!"),
	description = S("Die 20 times, then 5 more."),
	icon        = "lottachievements_skull.png^lottachievements_level4.png",
	secret      = true,
	requires    = "this_is_becoming_a_habit",
	id          = 48,
	trigger     = {
		type   = "death",
		target = 25,
	}
})

lottachievements.register_achievement("this_is_really_too_much", {
	title       = S("This is really too much..."),
	description = S("Die a grand total of 100 times!"),
	icon        = "lottachievements_skull.png^lottachievements_level5.png",
	secret      = true,
	requires    = "im_getting_good_at_this",
	id          = 49,
	trigger     = {
		type   = "death",
		target = 100,
	}
})

lottachievements.register_achievement("king_of_dying", {
	title       = S("King of Dying"),
	description = S("Have 500 deaths to your name!"),
	icon        = "lottachievements_crowned_skull.png^lottachievements_level6.png",
	secret      = true,
	requires    = "this_is_really_too_much",
	id          = 50,
	trigger     = {
		type   = "death",
		target = 500,
	}
})

lottachievements.register_achievement("so_dead_im_immortal", {
	title       = S("So dead, I'm immortal!"),
	description = S("1000 deaths. Yes, 1000!"),
	icon        = "lottachievements_skull.png^lottachievements_level7.png",
	secret      = true,
	requires    = "king_of_dying",
	id          = 51,
	trigger     = {
		type   = "death",
		target = 1000,
	}
})

lottachievements.register_achievement("supersonic_speed", {
	title       = S("Supersonic Speed"),
	description = S("Craft a palantir"),
	icon        = "default_obsidian.png",
	secret      = true,
	id          = 52,
	trigger     = {
		type     = "craft",
		item     = "lottblocks:palantir",
		target   = 1,
		setprivs = function(player, data)
			minetest.set_player_privs(player.get_player_name(), "palantiri")
		end
	}
})

lottachievements.register_achievement("magic", {
	title       = S("A young wizard"),
	description = S("Craft a book of palantir"),
	icon        = "default_book.png^[colorize:darkblue:100",
	secret      = true,
	requires    = "supersonic_speed",
	id          = 53,
	trigger     = {
		effect = function(player)
			local player_name = player:get_player_name()
			if minetest.check_player_privs(player_name, "palantiri") then
				-- already have "palantiri" privilege
				return false
			end
			local player_privs = minetest.get_player_privs(player_name)
			player_privs["palantiri"] = true
			minetest.set_player_privs(player_name, player_privs)
			minetest.chat_send_player(
				player_name,
				minetest.colorize("purple", S("You can now travel with palantiri"))
			)
		end,
		item   = "lottblocks:palantir_guide",
		type   = "craft",
		target = 1,
	}
})

lottachievements.register_achievement("daggins_surname", {
	title       = S("Baggins surname"),
	description = S("Make 8 large bags"),
	icon        = "bags_large.png",
	secret      = true,
	id          = 54,
	trigger     = {
		type   = "craft",
		item   = "bags:large",
		target = 8
	}
})

lottachievements.register_achievement("dwarven_tomb", {
	title = S("Dwarven Tomb"),
	description = S("Find (and loot!) a dwarven tomb, deep underground..."),
	icon = "lottblocks_dh_top.png",
	id = 55,
	trigger = {
		type = "dig",
		node = "lottblocks:dwarf_tomb_top",
		target = 1,
	}
})
