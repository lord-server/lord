local Form = require('holding_node.Form')


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
		local inv = meta:get_inventory()
		inv:set_size('reward', 8)
	end,

	--- @param placer Player
	--- @param itemstack ItemStack
	--- @param pointed_thing pointed_thing
	on_place = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer, 'server') then
			minetest.chat_send_player(placer:get_player_name(), S('It\'s for admins only! How did you get this thing?!'))

			return itemstack, nil
		end
		-- Если проверка пройдена, возвращаем стандартное поведение
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,

	--- @param pos Position
	--- @param placer Player
	after_place_node = function(pos, placer)
		if not minetest.check_player_privs(placer, 'server') then
				minetest.chat_send_player(placer:get_player_name(), S('It\'s for admins only! How did you get this thing?!'))

				return nil
		end
		Form:new(placer, pos):open()
	end,

	--- @param pos Position
	--- @param player Player
	--- @param pointed_thing pointed_thing
	--- @param node Node
	on_punch = function(pos, node, player, pointed_thing)

		-- чтоб код не падал если ноду ударит не игрок
		if not player or not minetest.is_player(player) then
			return
		end

		-- чтоб код не падал если ноду ударит игрок без клана
		local clan = clans.clan_get_by_player(player)

		if not clan then
			minetest.chat_send_player(player:get_player_name(), S('For clan players only'))
			return
		end

		-- нужно проверить наличие клана игрока в таблице статистики, обновить время захвата при наличии
		local meta = minetest.get_meta(pos)
		local battle_stat = minetest.deserialize(meta:get_string('battle_stat')) or {}
		local current_time = os.time()

		battle_stat[clan.name] = current_time

		-- обновить метаданные ноды
		meta:set_string('battle_stat', minetest.serialize(battle_stat))
		meta:set_string('captured_by_clan', clan.name)
		meta:set_int('captured_at', current_time)
	end,

	--- @param pos Position
	--- @param node Node
	--- @param clicker Player
	--- @param itemstack ItemStack
	--- @param pointed_thing pointed_thing
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

	end
}


return {
	definition = definition
}
