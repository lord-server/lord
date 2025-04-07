local S = minetest.get_mod_translator()

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
	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"formspec_version[4]" ..
				"size[5,4]" ..
				"field[1,1;3,1;name;Name;]" ..
				"button_exit[1,2.5;3,1;exit;Save]")

		-- Отладочное сообщение
		minetest.log("action", "Formspec set: " .. meta:get_string("formspec"))
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.get_meta(pos)

		if fields.name then
			meta:set_string('name', fields.name) -- Обновляем метаданную name
		end
	end,

	--- @param player Player
	on_punch = function(pos, node, player, pointed_thing)
		local meta = minetest.get_meta(pos)

		-- *** BATTLE STAT *** starting
		local battle_stat = minetest.deserialize(meta:get_string('battle_stat')) or {}
		local clan_id = clans.clan_get_by_player(player).name
		-- set meta to table
		table.insert(battle_stat, {clan = clan_id, time = os.time()})

		-- serialize table battle_stat to meta as string
		meta:set_string('battle_stat', minetest.serialize(battle_stat))
		-- *** BATTLE STAT *** ending

		meta:set_string ('captured_by_clan', clan_id)

		-- debug meta
		minetest.log("action", "Meta is: " .. (dump(meta:to_table())))


	end
}


return {
	definition = definition
}
