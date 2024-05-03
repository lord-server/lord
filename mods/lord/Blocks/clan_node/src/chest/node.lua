--- @type clan_node.chest.node.Form
local Form = require("chest.node.Form")


local S = minetest.get_translator('clan_node')

local definition = {
	description       = S("Clan Chest"),
	tiles             = {
		"default_chest_top.png",
		"default_chest_top.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_front.png"
	},
	sounds            = default.node_sound_wood_defaults(),
	sound_open        = "default_chest_open",
	sound_close       = "default_chest_close",
	groups            = {
		choppy                    = 2,
		oddly_breakable_by_hand   = 2,
		not_in_creative_inventory = 1,
	},
	is_ground_content = false,
	paramtype         = "light",
	paramtype2        = "facedir",

	--- @param itemstack     ItemStack
	--- @param placer        Player
	--- @param pointed_thing pointed_thing
	on_place          = function(itemstack, placer, pointed_thing)
		if not clans.get_by_player(placer) then
			minetest.chat_send_player(
				placer:get_player_name(), S("You can't place this item. This chest is only for clan players.")
			)
			return itemstack, nil
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	--- @param pos Position
	on_construct      = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Clan Chest"))
		meta:set_string("owned_clan", "")
		local inventory = meta:get_inventory()
		inventory:set_size("main", 8 * 4)
	end,
	--- @param pos    Position
	--- @param placer Player
	after_place_node  = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local clan = clans.get_by_player(placer)
		if not clan then
			local node_name = minetest.get_node(pos).name
			minetest.remove_node(pos)
			minetest.add_item(pos, node_name)
		end
		meta:set_string("owned_clan", clan.name)
		meta:set_string("infotext", S("@1 Clan Chest", clan.title))
	end,
	--- @param pos    Position
	--- @param player Player
	can_dig           = function(pos, player)
		return
			clans.get_by_player(player) and
			minetest.get_meta(pos):get_inventory():is_empty("main")
	end,
	on_blast = function() end,
	--- @param pos Position
	--- @param clicker Player
	on_rightclick     = function(pos, node, clicker)
		local chest_clan_name = minetest.get_meta(pos):get_string("owned_clan")
		local is_admin = minetest.check_player_privs(clicker, "server")
		-- open clan chest only if anyone from clan-owner is online
		if (not chest_clan_name or not clans.clan_is_online(chest_clan_name)) and not is_admin then
			return
		end
		local player_clan = clans.get_by_player(clicker)
		local player_clan_name = player_clan and player_clan.name or nil
		if not player_clan then	return end  -- open clan chest only for players from any clans, not for regular players
		if player_clan_name ~= chest_clan_name and not is_admin then
			local chest_clan = clans.get_by_name(chest_clan_name)
			minetest.chat_send_all(minetest.colorize("red", S("Clan @1 is under the raid", chest_clan.title)))
			local sound = minetest.sound_play("clan_node_alert_bell", { gain = 0.5 })
			minetest.after(15, function()
				minetest.sound_fade(sound, 0.05, 0)
			end)
		end
		Form:new(pos, clicker):open()
	end,
}


return {
	definition   = definition,
	form_handler = Form.handler
}
