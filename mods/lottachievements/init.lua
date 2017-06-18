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

local SL = lord.require_intllib()

-- The global award namespace
lottachievements = {
	show_mode = "hud"
}

-- Internationalization support.
local S, NS = dofile(minetest.get_modpath("lottachievements").."/intllib.lua")

lottachievements.gettext, lottachievements.ngettext = S, NS

dofile(minetest.get_modpath("lottachievements").."/api.lua")
dofile(minetest.get_modpath("lottachievements").."/chat_commands.lua")
dofile(minetest.get_modpath("lottachievements").."/triggers.lua")

-- To add achievements in the middle of ids (e.g. between 29 and 30),
-- use the script at the bottom of the file, changing the variables as needed.

minetest.register_craftitem("lottachievements:achievement_book", {
	description = SL("Achievements Book"),
	inventory_image = "lottachievements_achievement_book.png",
	groups = {book=1},
	on_place = function(_, player)
		local name = player:get_player_name()
		lottachievements.show_to(name, name)
	end,
	on_use = function(_, player)
		local name = player:get_player_name()
		lottachievements.show_to(name, name)
	end,
})

minetest.register_craft({
	output = 'lottachievements:achievement_book',
	recipe = {
		{'lottores:blue_gem', 'lottores:tilkal_ingot', 'lottother:purple_gem'},
		{'default:mese_crystal', 'default:book', 'default:diamond'},
		{'lottores:white_gem', 'lottother:ringsilver_ingot', 'lottores:red_gem'},
	}
})
-- Different achievements

lottachievements.register_achievement("master_craftsman", {
	title = SL("Master Craftsman"),
	description = SL("Craft a Master Book of Crafts"),
	icon = "lottinventory_master_book.png",
	id = 1,
	trigger = {
		type = "craft",
		item = "lottinventory:master_book",
		target = 1,
	}
})

lottachievements.register_achievement("i_achieved_this", {
	title = SL("I achieved this!"),
	description = SL("Make the Achievements Book"),
	icon = "lottachievements_achievement_book.png",
	id = 2,
	trigger = {
		type = "craft",
		item = "lottachievements:achievement_book",
		target = 1,
	}
})

lottachievements.register_achievement("rope_is_useful", {
	title = SL("Rope is useful!"),
	description = SL("Craft 100 meters of elven rope"),
	icon = "lottblocks_elven_rope.png",
	id = 3,
	trigger = {
		type = "craft",
		item = "lottblocks:elven_rope",
		target = 100,
	}
})

lottachievements.register_achievement("silver_stringed_music", {
	title = SL("Silver Stringed Music"),
	description = SL("Craft a dwarvern harp"),
	icon = "lottblocks_harp_strings.png",
	id = 4,
	trigger = {
		type = "craft",
		item = "lottblocks:dwarf_harp",
		target = 1,
	}
})

lottachievements.register_achievement("express_miner", {
	title = SL("Express Miner"),
	description = SL("Craft a mithril pickaxe"),
	icon = "lottores_mithrilpick.png",
	id = 5,
	trigger = {
		type = "craft",
		item = "tools:pick_mithril",
		target = 1,
	}
})

lottachievements.register_achievement("elf_and_dwarf_cooperation", {
	title = SL("Elf and Dwarf Cooperation"),
	description = SL("Place at least 6 ithildin stone"),
	icon = "default_stone.png^ithildin_1.png",
	id = 6,
	trigger = {
		type = "place",
		node = "lottores:ithildin_stone_1",
		target = 6,
	}
})

lottachievements.register_achievement("chains_of_melkor", {
	title = SL("Chains of Melkor"),
	description = SL("Craft a tilkal ingot"),
	icon = "lottores_tilkal_ingot.png",
	id = 7,
	trigger = {
		type = "craft",
		item = "lottores:tilkal_ingot",
		target = 1
	}
})

lottachievements.register_achievement("tourist", {
	title = SL("Tourist"),
	description = SL("Take a fire"),
	icon = "campfire.png",
	id = 8,
	trigger = {
		type = "place",
		node = "fire:campfire",
		target = 1,
	}
})

lottachievements.register_achievement("his_arm_has_grown_long", {
	title = SL("His arm has grown long indeed"),
	description = SL("Craft a mithril spear"),
	icon = "tools_spear_mithril.png",
	id = 9,
	trigger = {
		type = "craft",
		item = "tools:spear_mithril",
		target = 1
	}
})

lottachievements.register_achievement("marksman_of_lorien", {
	title = SL("Marksman of Lorien"),
	description = SL("Craft a mallorn bow"),
	icon = "lottthrowing_bow_wood_mallorn.png",
	id = 10,
	trigger = {
		type = "craft",
		item = "lottthrowing:bow_wood_mallorn",
		target = 1
	}
})

lottachievements.register_achievement("merry_shire", {
	title = SL("Merry Shire"),
	description = SL("Visit Shire and get his soil"),
	icon = "default_dirt.png^lottmapgen_shire_grass_side.png",
	id = 11,
	trigger = {
		type = "dig",
		node = "lottmapgen:shire_grass",
		target = 1,
	}
})

lottachievements.register_achievement("the_golden_lorien", {
	title = SL("The Golden Lorien"),
	description = SL("Visit the forests of Lorien and get their soil"),
	icon = "default_dirt.png^lottmapgen_lorien_grass_side.png",
	id = 12,
	trigger = {
		type = "dig",
		node = "lottmapgen:lorien_grass",
		target = 1,
	}
})

lottachievements.register_achievement("damaged_greenwood", {
	title = SL("Damaged Greenwood"),
	description = SL("Visit the forests of Liholsye and get their soil"),
	icon = "default_dirt.png^lottmapgen_mirkwood_grass_side.png",
	id = 13,
	trigger = {
		type = "dig",
		node = "lottmapgen:mirkwood_grass",
		target = 1,
	}
})

lottachievements.register_achievement("iron_hills", {
	title = SL("Iron Hills"),
	description = SL("Visit the Iron Hills and get his soil"),
	icon = "default_dirt.png^lottmapgen_dunland_grass_side.png",
	id = 14,
	trigger = {
		type = "dig",
		node = "lottmapgen:ironhill_grass",
		target = 1,
	}
})

lottachievements.register_achievement("frozen_angmar", {
	title = SL("Frozen Angmar"),
	description = SL("Visit Angmar, and get his soil"),
	icon = "default_dirt.png^default_snow_side.png",
	id = 15,
	trigger = {
		type = "dig",
		node = "default:dirt_with_snow",
		target = 1,
	}
})

lottachievements.register_achievement("lands_of_rohan", {
	title = SL("Lands of Rohan"),
	description = SL("Visit Rohan and get his soil"),
	icon = "default_dirt.png^lottmapgen_rohan_grass_side.png",
	id = 16,
	trigger = {
		type = "dig",
		node = "lottmapgen:rohan_grass",
		target = 1,
	}
})

lottachievements.register_achievement("lands_of_gondor", {
	title = SL("Lands of Gondor"),
	description = SL("Visit Gondor and get his soil"),
	icon = "default_dirt.png^default_grass_side.png",
	id = 17,
	trigger = {
		type = "dig",
		node = "lottmapgen:gondor_grass",
		target = 1,
	}
})

lottachievements.register_achievement("live_fangorn", {
	title = SL("Live Fangorn"),
	description = SL("Visit the forests of Fargorn and get their soil"),
	icon = "default_dirt.png^default_grass_side.png",
	id = 18,
	trigger = {
		type = "dig",
		node = "lottmapgen:fangorn_grass",
		target = 1,
	}
})

lottachievements.register_achievement("anxious_dunland", {
	title = SL("Anxious Dunland"),
	description = SL("Visit Dunland and get its soil"),
	icon = "default_dirt.png^lottmapgen_dunland_grass_side.png",
	id = 19,
	trigger = {
		type = "dig",
		node = "lottmapgen:dunland_grass",
		target = 1,
	}
})

lottachievements.register_achievement("calm_ithilien", {
	title = SL("Calm Ithilien"),
	description = SL("Visit Ithilien and get his soil"),
	icon = "default_dirt.png^default_grass_side.png",
	id = 20,
	trigger = {
		type = "dig",
		node = "lottmapgen:ithilien_grass",
		target = 1,
	}
})

lottachievements.register_achievement("in_the_lands_of_mordor", {
	title = SL("In the lands of Mordor ..."),
	description = SL("Visit Mordor and dobudte Mordorskiy stone as evidence"),
	icon = "lottmapgen_mordor_stone.png",
	id = 21,
	trigger = {
		type = "dig",
		node = "lottmapgen:mordor_stone",
		target = 1,
	}
})

lottachievements.register_achievement("dungeons_deep_and_caverns_old", {
	title = SL("Dungeons Deep and Caverns Old"),
	description = SL("Find an underground dungeon"),
	icon = "default_mossycobble.png",
	id = 22,
	trigger = {
		type = "dig",
		node = "default:mossycobble",
		target = 1,
	}
})

lottachievements.register_achievement("a_small_patch_of_lorien", {
	title = SL("A small patch of Lorien"),
	description = SL("Plant 7 seedlings of mallory"),
	icon = "lottplants_mallornsapling.png",
	id = 23,
	trigger = {
		type = "place",
		node = "lottplants:mallornsapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_gondor", {
	title = SL("A small patch of Gondor"),
	description = SL("Plant 7 seedlings of white tree of a gondor"),
	icon = "lottplants_whitesapling.png",
	id = 24,
	trigger = {
		type = "place",
		node = "lottplants:whitesapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_iron_hills", {
	title = SL("A small patch of Iron Hills"),
	description = SL("Plant 7 seedlings of pine"),
	icon = "lottplants_pinesapling.png",
	id = 25,
	trigger = {
		type = "place",
		node = "lottplants:pinesapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_shire", {
	title = SL("A small patch of Shire"),
	description = SL("Plant 7 seedlings of plums"),
	icon = "lottplants_plumsapling.png",
	id = 26,
	trigger = {
		type = "place",
		node = "lottplants:plumsapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_immortal", {
	title = SL("A small patch of Ititian"),
	description = SL("Plant 7 seedlings of the elm"),
	icon = "lottplants_elmsapling.png",
	id = 27,
	trigger = {
		type = "place",
		node = "lottplants:elmsapling",
		target = 7,
	}
})

lottachievements.register_achievement("a_small_patch_of_fangorn", {
	title = SL("A small patch of Fangorn"),
	description = SL("Plant 7 seedlings of culumalda"),
	icon = "lottplants_culumaldasapling.png",
	id = 28,
	trigger = {
		type = "place",
		node = "lottplants:culumaldasapling",
		target = 7,
	}
})

lottachievements.register_achievement("foot_soldier", {
	title = SL("Foot Soldier"),
	description = SL("Equip a full set of steel armor"),
	icon = "lottarmor_inv_chestplate_steel.png",
	id = 29,
	trigger = {
		type = "equip",
		item = "lottarmor:chestplate_steel",
	}
})

lottachievements.register_achievement("dwarvern_lord", {
	title = SL("Dwarven Lord"),
	description = SL("Equip a full set of mithril armor"),
	icon = "lottarmor_inv_chestplate_mithril.png",
	id = 30,
	trigger = {
		type = "equip",
		item = "lottarmor:chestplate_mithril",
	}
})

lottachievements.register_achievement("elven_lord", {
	title = SL("Elven Lord"),
	description = SL("Equip a full set of galvorn armor"),
	icon = "lottarmor_inv_chestplate_galvorn.png",
	id = 31,
	trigger = {
		type = "equip",
		item = "lottarmor:chestplate_galvorn",
	}
})

lottachievements.register_achievement("rohirric_king", {
	title = SL("Rohirric King"),
	description = SL("Equip a full set of gold armor"),
	icon = "lottarmor_inv_chestplate_gold.png",
	id = 32,
	trigger = {
		type = "equip",
		item = "lottarmor:chestplate_gold",
	}
})

lottachievements.register_achievement("ringing_wheels", {
	title = SL("Ringing wheels"),
	description = SL("Lay 100 m of conventional rail"),
	icon = "carts_rail.png^lottachievements_level1.png",
	id = 33,
	trigger = {
		type = "place",
		node = "carts:rail",
		target = 100,
	}
})

lottachievements.register_achievement("trail_men", {
	title = SL("Trail men"),
	description = SL("Lay 1000 m of conventional rail"),
	icon = "carts_rail.png^lottachievements_level2.png",
	requires = "ringing_wheels",
	id = 34,
	trigger = {
		type = "place",
		node = "carts:rail",
		target = 1000,
	}
})

lottachievements.register_achievement("with_the_wind", {
	title = SL("With the wind"),
	description = SL("Install 50 steam engines"),
	icon = "carts_steam_mechanism3.png",
	id = 35,
	trigger = {
		type = "place",
		node = "carts:steam_mechanism",
		target = 50,
	}
})

lottachievements.register_achievement("brake", {
	title = SL("Brake!"),
	description = SL("Lay 40 m stopping rail"),
	icon = "carts_rail_brk.png",
	id = 36,
	trigger = {
		type = "place",
		node = "carts:stopping_rail",
		target = 40,
	}
})

lottachievements.register_achievement("first_truesilver", {
	title = SL("First Truesilver"),
	description = SL("Mine 1 mithril ore"),
	icon = "default_stone.png^lottores_mithril_ore.png^lottachievements_level1.png",
	id = 37,
	trigger = {
		type = "dig",
		node = "lottores:mithril_ore",
		target = 1
	}
})

lottachievements.register_achievement("dwarvern_miner", {
	title = SL("Dwarven Miner"),
	description = SL("Mine 99 mithril ore"),
	icon = "default_stone.png^lottores_mithril_ore.png^lottachievements_level2.png",
	requires = "first_truesilver",
	id = 38,
	trigger = {
		type = "dig",
		node = "lottores:mithril_ore",
		target = 99
	}
})

lottachievements.register_achievement("ammassing_fortune", {
	title = SL("Amassing Fortune"),
	description = SL("Mine 500 mithril ore"),
	icon = "default_stone.png^lottores_mithril_ore.png^lottachievements_level3.png",
	requires = "dwarvern_miner",
	id = 39,
	trigger = {
		type = "dig",
		node = "lottores:mithril_ore",
		target = 500
	}
})

lottachievements.register_achievement("truly_rich", {
	title = SL("Truly Rich"),
	description = SL("Mine 1000 mithril ore"),
	icon = "default_stone.png^lottores_mithril_ore.png^lottachievements_level4.png",
	requires = "ammassing_fortune",
	id = 40,
	trigger = {
		type = "dig",
		node = "lottores:mithril_ore",
		target = 1000
	}
})

lottachievements.register_achievement("lord_of_moria", {
	title = SL("Lord of Moria"),
	description = SL("Mine 5000 mithril ore"),
	icon = "default_stone.png^lottores_mithril_ore.png^lottachievements_level5.png",
	requires = "truly_rich",
	id = 41,
	trigger = {
		type = "dig",
		node = "lottores:mithril_ore",
		target = 5000
	}
})

lottachievements.register_achievement("little_cave", {
	title = SL("Little cave"),
	description = SL("Dig out 100 of cobblestone"),
	icon = "lottores_goldpick.png^lottachievements_level1.png",
	secret = true,
	id = 42,
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 100,
	}
})

lottachievements.register_achievement("miner", {
	title = SL("Miner"),
	description = SL("Dig out 1000 of cobblestone"),
	icon = "lottores_goldpick.png^lottachievements_level2.png",
	secret = true,
	requires = "little_cave",
	id = 43,
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 1000,
	}
})

lottachievements.register_achievement("pick_man", {
	title = SL("Pick-man"),
	description = SL("Dig out 10000 of cobblestone"),
	icon = "lottores_goldpick.png^lottachievements_level3.png",
	secret = true,
	requires = "miner",
	id = 44,
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 10000,
	}
})

lottachievements.register_achievement("first_time_for_everything", {
	title = SL("First Time for Everything"),
	description = SL("Die once!"),
	secret = true,
	id = 45,
	icon = "lottachievements_skull.png^lottachievements_level1.png",
	trigger = {
		type = "death",
		target = 1,
	}
})

lottachievements.register_achievement("not_again", {
	title = SL("Not Again!"),
	description = SL("Die a second time"),
	icon = "lottachievements_skull.png^lottachievements_level2.png",
	secret = true,
	requires = "first_time_for_everything",
	id = 46,
	trigger = {
		type = "death",
		target = 2,
	}
})

lottachievements.register_achievement("this_is_becoming_a_habit", {
	title = SL("This is becoming a habit..."),
	description = SL("Die 10 times!"),
	icon = "lottachievements_skull.png^lottachievements_level3.png",
	secret = true,
	requires = "not_again",
	id = 47,
	trigger = {
		type = "death",
		target = 10,
	}
})

lottachievements.register_achievement("im_getting_good_at_this", {
	title = SL("I'm getting good at this!"),
	description = SL("Die 20 times, then 5 more."),
	icon = "lottachievements_skull.png^lottachievements_level4.png",
	secret = true,
	requires = "this_is_becoming_a_habit",
	id = 48,
	trigger = {
		type = "death",
		target = 25,
	}
})

lottachievements.register_achievement("this_is_really_too_much", {
	title = SL("This is really too much..."),
	description = SL("Die a grand total of 100 times!"),
	icon = "lottachievements_skull.png^lottachievements_level5.png",
	secret = true,
	requires = "im_getting_good_at_this",
	id = 49,
	trigger = {
		type = "death",
		target = 100,
	}
})

lottachievements.register_achievement("king_of_dying", {
	title = SL("King of Dying"),
	description = SL("Have 500 deaths to your name!"),
	icon = "lottachievements_crowned_skull.png^lottachievements_level6.png",
	secret = true,
	requires = "this_is_really_too_much",
	id = 50,
	trigger = {
		type = "death",
		target = 500,
	}
})

lottachievements.register_achievement("so_dead_im_immortal", {
	title = SL("So dead, I'm immortal!"),
	description = SL("1000 deaths. Yes, 1000!"),
	icon = "lottachievements_skull.png^lottachievements_level7.png",
	secret = true,
	requires = "king_of_dying",
	id = 51,
	trigger = {
		type = "death",
		target = 1000,
	}
})

lottachievements.register_achievement("supersonic_speed", {
	title = SL("Supersonic Speed"),
	description = SL("Craft a palantir"),
	icon = "default_obsidian.png",
	secret = true,
	id = 52,
	trigger = {
		type = "craft",
		item = "lottblocks:palantir",
		target = 1,
		setprivs = function(player,data)
			minetest.set_player_privs(player.get_player_name(),"palantiri")
		end
	}
})

lottachievements.register_achievement("magic", {
	title = SL("A young wizard"),
	description = SL("Craft a book of palantir"),
	icon = "default_book.png^[colorize:darkblue:100",
	secret = true,
	requires = "supersonic_speed",
	id = 53,
	trigger = {
		effect = function(player)
			local grantprivs = minetest.string_to_privs("palantiri")
			local grant_name = player:get_player_name()
			local privs = minetest.get_player_privs(grant_name)
			local privs_unknown = ""
			for priv, _ in pairs(grantprivs) do
				if minetest.check_player_privs(grant_name, grantprivs) then
					print("Your privileges are insufficient.")
					return false
				end
				if not minetest.registered_privileges[priv] then
					privs_unknown = privs_unknown .. "Unknown privilege: " .. priv .. "\n"
				end
				if not priv:match("GAME", 1) then
					privs[priv] = true
	      end
			end
			if privs_unknown ~= "" then
				print(privs_unknown)
				return false
			end
			minetest.chat_send_player(grant_name, minetest.colorize("purple","Теперь вы можете совершать перемещения с помощью палантиров"))
			minetest.set_player_privs(grant_name, privs)
		end,
		item = "lottblocks:palantir_guide",
		type = "craft",
		target = 1,
	}
})

lottachievements.register_achievement("daggins_surname", {
	title = SL("Baggins surname"),
	description = SL("Make 8 large bags"),
	icon = "bags_large.png",
	secret = true,
	id = 54,
	trigger = {
		type = "craft",
		item = "lottinventory:large",
		target = 8
	}
})



--[[lottachievements.register_achievement("a_long_path_to_mushrooms", {
	title = SL("A Long Path to Mushrooms"),
	description = SL("Show a hobbitish love of mushrooms by eating 99!"),
	icon = "lottplants_mushroom_wild.png",
	id = 2,
	trigger = {
		type = "eat",
		item = "lottfarming:brown_mushroom",
		target = 99
	}
})

lottachievements.register_achievement("tasty_taters", {
	title = SL("Tasty Taters"),
	description = SL("Fill your belly with the good ballast of 9 potatoes"),
	icon = "lottfarming_potato_cooked.png",
	id = 3,
	trigger = {
		type = "eat",
		item = "lottfarming:potato_cooked",
		target = 9
	}
})
]]

--[[lottachievements.register_achievement("thief", {
	title = SL("Thief!"),
	description = SL("Use a lockpick to break into a chest of a different race"),
	icon = "lottblocks_steel_lockpick.png",
	id = 4,
})
]]

--[[lottachievements.register_achievement("dwarvern_tomb", {
	title = SL("Dwarvern Tomb"),
	description = SL("Find (and loot!) a dwarvern tomb, deep underground..."),
	icon = "lottblocks_dh_top.png",
	id = 8,
	trigger = {
		type = "dig",
		node = "lottblocks:dwarf_tomb_top",
		target = 1,
	}
})
]]

-- Various biome awards

--[[lottachievements.register_achievement("the_frozen_wastes", {
	title = SL("The Frozen Wastes"),
	description = SL("Visit a frozen biome, and collect some snow"),
	icon = "default_snow.png",
	id = 14,
	trigger = {
		type = "dig",
		node = "default:snowblock",
		target = 1,
	}
})


lottachievements.register_achievement("iron_galore", {
	title = SL("Iron Galore"),
	description = SL("Visit the Iron Hills and start a mine there"),
	icon = "default_stone.png^default_mineral_iron.png",
	id = 15,
	trigger = {
		type = "dig",
		node = "lottmapgen:ironhill_grass",
		target = 1,
	}
})

lottachievements.register_achievement("the_merry_shire", {
	title = SL("The Merry Shire"),
	description = SL("Visit the Shire, and examine its soil"),
	icon = "lottplants_plum.png",
	id = 16,
	trigger = {
		type = "dig",
		node = "lottmapgen:shire_grass",
		target = 1,
	}
})

lottachievements.register_achievement("lorien_the_golden", {
	title = SL("Lorien the Golden"),
	description = SL("Visit the golden forest of Lorien"),
	icon = "lottplants_mallornleaf_inv.png",
	id = 17,
	trigger = {
		type = "dig",
		node = "lottmapgen:lorien_grass",
		target = 1,
	}
})
]]

--[[lottachievements.register_achievement("the_corrupted_greenwood", {
	title = SL("The Corrupted Greenwood"),
	description = SL("Chop down a tree in Mirkwood"),
	icon = "lottplants_mirkleaf_inv.png",
	id = 18,
	trigger = {
		type = "dig",
		node = "default:jungletree",
		target = 1,
	}
})
]]
-- Mob Killings!

--[[
lottachievements.register_achievement("durins_bane", {
	title = SL("Durin's Bane"),
	description = SL("Kill a Balrog"),
	icon = "fire_basic_flame.png",
	id = 27,
	trigger = {
		type = "kill",
		mob = "lottmobs:balrog",
		target = 1,
	}
})

lottachievements.register_achievement("begone_foul_dwimmerlaik", {
	title = SL("Begone, foul dwimmerlaik"),
	description = SL("Kill the king of the Nazgul"),
	icon = "lottachievements_witch_king.png",
	id = 26,
	trigger = {
		type = "kill",
		mob = "lottmobs:witch_king",
		target = 1,
	}
})

lottachievements.register_achievement("living_wood", {
	title = SL("Living Wood"),
	description = SL("Kill an ent"),
	icon = "default_jungletree.png",
	id = 25,
	trigger = {
		type = "kill",
		mob = "lottmobs:ent",
		target = 1,
	}
})

lottachievements.register_achievement("elven_champion", {
	title = SL("Elven Champion"),
	description = SL("Kill 25 Mordor orcs"),
	icon = "tools_sword_elven.png",
	id = 22,
	trigger = {
		type = "kill",
		mob = "lottmobs:orc",
		target = 25,
	}
})

lottachievements.register_achievement("orcish_warlord", {
	title = SL("Orcish Warlord"),
	description = SL("Kill 25 elves"),
	icon = "tools_sword_orc.png",
	id = 23,
	trigger = {
		type = "kill",
		mob = "lottmobs:elf",
		target = 25,
	}
})

lottachievements.register_achievement("spider_hunter", {
	title = SL("Spider Hunter"),
	description = SL("Kill 25 spiders"),
	icon = "lottplants_mirkleaf_inv.png",
	id = 24,
	trigger = {
		type = "kill",
		mob = "lottmobs:spider",
		target = 25,
	}
})
]]

--[[ Advanced Achievements

lottachievements.register_achievement("abandoned_workshop", {
 	title = SL("Abandoned Workshop"),
 	description = SL("Discover a secret Elven Workshop underground"),
 	icon = "default_cracked_stone_brick.png",
 	id = 37,
 	trigger = {
 		type = "dig",
 		node = "default:cracked_stonebrick",
 		target = 1
 	}
 })

lottachievements.register_achievement("ringsilver_crafter", {
 	title = SL("Ringsilver crafter"),
 	description = SL("Form your first ingot of ringsilver!"),
 	icon = "lottother_ringsilver_ingot.png",
 	requires = "abandoned_workshop",
 	id = 38,
 })

lottachievements.register_achievement("the_ring_is_prepared", {
	title = SL("The Ring is Prepared..."),
	description = SL("Make a ring ready to have a gem fitted to it"),
	icon = "lottother_prepared_ring.png",
	requires = "ringsilver_crafter",
	id = 39,
	trigger = {
		type = "craft",
		item = "lottother:prepared_ring",
		target = 1,
	}
})

lottachievements.register_achievement("a_pickaxe_fit_for_a_king", {
 	title = SL("A pickaxe fit for a king"),
 	description = SL("Craft a gem pickaxe"),
 	icon = "lottother_gempick.png",
 	requires = "abandoned_workshop",
 	id = 40,
 	trigger = {
 		type = "craft",
 		item = "lottother:gem_pick",
 		target = 1,
 	}
 })

lottachievements.register_achievement("polisher", {
 	title = SL("Polisher"),
 	description = SL("Polish a gem"),
 	icon = "lottother_redgem.png",
 	requires = "a_pickaxe_fit_for_a_king",
 	id = 41,
 })

lottachievements.register_achievement("ring_smith", {
 	title = SL("Ring Smith"),
 	description = SL("Forge a ring of power"),
 	requires = "polisher",
 	icon = "lottother_narya.png",
 	id = 42,
 })
]]

--[[
--Code to increase award numbers:
local file = io.open("init.lua")
local string = ""
local increase_from = 5 -- The number you want the new award to be.
local increase_amount = 1 -- How many awards you want to add.

for i in file:lines() do
	if i:find("id = %d+,") then
		local pos1, pos2 = i:find("id = %d+,")
		local d = tonumber(i:sub(pos1 + 5, pos2 - 1))
		if d >= increase_from then
			d = d + increase_amount
			i = i:gsub("id = %d+,", "id = " .. d .. ",")
		end
	end
	string = string .. i .. "\n"
end

file:close()
file = io.open("init.lua", "w+")
file:write(string)
file:close()
--Yes, this should be done with sed or awk, but I have no idea how to use them!
]]--
