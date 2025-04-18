local S = minetest.get_mod_translator()

local storage = core.get_mod_storage()

-- Some modified from: Minetest: builtin/static_spawn.lua

spawn = {}

function spawn.pos_from_conf(conf)
	local t = {}

	t.x = tonumber(string.split(minetest.settings:get(conf), ",")[1])
	t.y = tonumber(string.split(minetest.settings:get(conf), ",")[2])
	t.z = tonumber(string.split(minetest.settings:get(conf), ",")[3])

	if t.x and t.y and t.z then
		return t
	else
		return false
	end
end

function spawn.check_conf(config_setting)
	if not minetest.settings:get(config_setting) then
		minetest.log('warning', "The \"" .. config_setting .. "\" setting is not set")
		return false
	end

	if not spawn.pos_from_conf(config_setting) then
		minetest.log('warning', "The " .. config_setting .. " setting is invalid: \""..
				core.settings:get(config_setting).."\"")
		return false
	end
	return true
end

function spawn.put_player_at_spawn(obj, config_setting)
	if not spawn.check_conf(config_setting) then
		return false
	end

	local spawnpoint = spawn.pos_from_conf(config_setting)

	minetest.log('action', "Moving " .. obj:get_player_name() ..
			" to " .. config_setting .. " at "..
			minetest.pos_to_string(spawnpoint))

	obj:set_pos(spawnpoint)

	return true
end

minetest.register_chatcommand("spawn", {
	description = S("Teleport to Spawn"),
	func = function(name, _)
		local player = minetest.get_player_by_name(name)
		local setting = character.of(player):get_race().."_spawn_pos"
		if (minetest.settings:get_bool("dynamic_spawn") ~= true) or (not spawn.check_conf(setting)) then
			local ok = spawn.put_player_at_spawn(player, "common_spawn_pos")
			if ok then
				return true, S("Teleporting to common Spawn...")
			end
		end
		if spawn.put_player_at_spawn(player, setting) then
			return true,
			S("Teleporting to "..character.of(player):get_race().." Spawn...")
		end
		return false, S("Teleport failed")
	end
})

minetest.register_privilege("spawn_to", {
	description = S("Can teleports to any race spawn."),
	give_to_singleplayer = false,
})

minetest.register_chatcommand("spawn_to", {
	params = "<race>",
	privs = { spawn_to = true, },
	description = S("Teleports to specified Spawn."),
	func = function(name, race)
		local player = minetest.get_player_by_name(name)
		local setting = race.."_spawn_pos"
		if spawn.put_player_at_spawn(player, setting) then
			return true,
			S("Teleporting to "..race.." Spawn...")
		end
		return false, S("Teleport failed")
	end
})

minetest.register_privilege("eventing", {
	description = S("Can save position for /event."),
	give_to_singleplayer = false,
})

minetest.register_chatcommand("event.set_pos", {
	privs = { eventing = true },
	description = S("Save current position as spawn point to /event."),
	func = function(name, param)
		if param == "none" then
			storage:set_string("hall_of_event_pos", "")
			minetest.settings:set("hall_of_event_pos", "")
			minetest.unregister_chatcommand("event")
		else
			local player = minetest.get_player_by_name(name)
			local mypos = player:get_pos()
			mypos.x = math.floor(mypos.x)
			mypos.y = math.floor(mypos.y)+0.5
			mypos.z = math.floor(mypos.z)
			storage:set_string("hall_of_event_pos", mypos.x..", "..mypos.y..", "..mypos.z)
			minetest.settings:set("hall_of_event_pos", mypos.x..", "..mypos.y..", "..mypos.z)
			spawn.register_hall("event", "Event")
			return true, S("Event position is set.")
		end
	end
})

--Halls

local function tp_to_hall(hall, obj)
	if not spawn.check_conf("hall_of_"..hall.."_pos") then
		return false
	end

	local hall_pos = spawn.pos_from_conf("hall_of_"..hall.."_pos")

	minetest.log('action', "Moving "..obj:get_player_name()..
			" to "..hall.." at "..
			minetest.pos_to_string(hall_pos))

	obj:set_pos(hall_pos)

	return true
end

function spawn.register_hall(hall, desc)
	if spawn.check_conf("hall_of_"..hall.."_pos") then
		minetest.register_chatcommand(hall, {
			description = S("Teleport to the Hall of "..desc),
			func = function(name, _)
				local ok = tp_to_hall(hall, minetest.get_player_by_name(name))
				if ok then
					return true, S("Teleporting to the Hall of "..desc.."...")
				end
				return false, S("Teleport failed")
			end
		})
	end
end

spawn.register_hall("center", "Dol Guldur")
spawn.register_hall("death", "Death")
--Команда перемещения на Событие (/event) создается при наличии позиции hall_of_event_pos.
--Позиция(текущая) задается в игре командой /event.set_pos при наличии привилегии eventing.
--Значение hall_of_event_pos сохраняется в ModStorage и доступно после перезапуска сервера.
--При инициализации lord_spawn сохраненное значение hall_of_event_pos, помещается в
--minetest.settings для совместимости с функцией spawn.register_hall
--От сохранения позиции в конфиг отказались т.к. при деплое он перезаписывается.
if storage:get("hall_of_event_pos") then
	minetest.settings:set("hall_of_event_pos", (storage:get("hall_of_event_pos")))
	spawn.register_hall("event", "Event")
end
--spawn.register_hall("life", "Life")
minetest.register_chatcommand("life", {
	description = S("Teleport to the Hall of Life"),
	func = function(_, _)
		return true, S("Command reserved. For teleporting to Old Central Spawn use command `/center`")
	end
})
spawn.register_hall("bree", "Bree")

minetest.register_on_newplayer(function(obj)
	return spawn.put_player_at_spawn(obj, "common_spawn_pos")
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	local a
	if beds.spawn[name] == nil then
		if minetest.settings:get_bool("dynamic_spawn")
		and spawn.check_conf(character.of(player):get_race().."_spawn_pos") then
			a = spawn.put_player_at_spawn(player, character.of(player):get_race().."_spawn_pos")
		else
			a = spawn.put_player_at_spawn(player, "common_spawn_pos")
		end
	end
	return a
end)
