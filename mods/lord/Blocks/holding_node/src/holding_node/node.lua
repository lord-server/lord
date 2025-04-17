local S = minetest.get_mod_translator()
local Form = require('holding_node.form')

local definition = {
	description = S('Holding block'),

	--- @param pos Position
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)

		meta:set_string ('name', S('-'))
		meta:set_int    ('in_event_list', 1)
		meta:set_int    ('active', 0)
		meta:set_int    ('last_activate_at', 0)
		meta:set_string ('captured_by_clan', S('Nobody'))
		meta:set_int    ('captured_at', 0)
		meta:set_int    ('reward_gived_at', 0)
		meta:set_string ('battle_stat', minetest.serialize({}))
		local inventory = meta:get_inventory()
		inventory:set_size('reward', 8)
	end,

--[[	after_place_node = function(pos, placer)

		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"formspec_version[4]" ..
				"size[5,4]" ..
				"field[1,1;3,1;name;Name;]" ..
				"button_exit[1,2.5;3,1;exit;Save]")

		minetest.show_formspec(placer:get_player_name(), "holding_block:holding_block", meta:get_string("formspec"))

		-- debug formspec
		minetest.log("action", "Formspec set: " .. meta:get_string("formspec"))
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.get_meta(pos)

		if fields.name then
			meta:set_string('name', fields.name) -- Обновляем метаданную name
		end
	end,]]

	--- @param player Player
	on_punch = function(pos, node, player, pointed_thing)

		if not clans.clan_get_by_player(player) then
			return
		end

		local meta = minetest.get_meta(pos)

		-- BATTLE STAT: starting

		local battle_stat = minetest.deserialize(meta:get_string('battle_stat')) or {}
		local clan_id = clans.clan_get_by_player(player).name

		-- set meta to table
		if clan_id then
			table.insert(battle_stat, {clan = clan_id, time = os.time()})
		else
			minetest.log("warning", "Clan ID is nil, not adding to battle_stat.") return
		end

		-- serialize table battle_stat to meta as string
		meta:set_string('battle_stat', minetest.serialize(battle_stat))

		-- BATTLE STAT: ending

		if clan_id then
			meta:set_string ('captured_by_clan', clan_id)
		else
			minetest.log("warning", "Clan ID is nil, not adding to captured_by_clan.")
		end

		-- debug meta
		minetest.log("action", "Meta is: " .. (dump(meta:to_table())))


	end,

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if minetest.check_player_privs(clicker, {server=true}) then
			Form:new(clicker, pos):open()
		end
	end
}


return {
	definition = definition
}
