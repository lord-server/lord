local S = minetest.get_translator("lottblocks")

local function deprecated_load_palantiri()
	local file = io.open(minetest.get_worldpath() .. "/LORD/palantiri", "r")
	if file == nil then
		return nil
	end
	local tmp = minetest.deserialize(file:read("*all"))
	file:close()
	return tmp[1]
end

local mod_storage = minetest.get_mod_storage()
local function load_palantiri()
	local tmp = mod_storage:get("serialized_palantiri")
	if tmp then
		return minetest.deserialize(tmp)
	end
	return nil
end

lottblocks.palantiri = load_palantiri() or deprecated_load_palantiri() or {}

local races_p     = {}
races_p["dwarf"]  = S("dwarves")
races_p["elf"]    = S("elves")
races_p["man"]    = S("men")
races_p["orc"]    = S("orcs")
races_p["hobbit"] = S("hobbits")

local function save_palantiri()
	mod_storage:set_string("serialized_palantiri", minetest.serialize(lottblocks.palantiri))
end

local function check_blocks(pos)
	local minp = { x = pos.x - 2, y = pos.y - 2, z = pos.z - 2 }
	local maxp = { x = pos.x + 2, y = pos.y + 2, z = pos.z + 2 }

	worldedit.keep_loaded(minp, maxp)

	local _, tilkal  = minetest.find_nodes_in_area(minp, maxp, "lottores:tilkal")
	local _, mithril = minetest.find_nodes_in_area(minp, maxp, "lottores:mithril_block")
	if tilkal["lottores:tilkal"] < 8 or mithril["lottores:mithril_block"] < 16 then
		return false
	end
	return true
end

minetest.register_on_shutdown(function()
	save_palantiri()
end)

local purple = "#6d54dd"

local function formspec_update(meta)
	local network  = meta:get_string("network")
	if not network then
		return
	end
	local palantir = meta:get_string("name")
	local form     = "size[6,5]" ..
		"background[5,5;1,1;gui_elfbg.png;true]" ..
		"label[1.5,1;" .. S("Network Name") .. ": " .. network .. "]" ..
		"label[1.5,1.5;" .. S("Palantir Name") .. ": " .. palantir .. "]" ..
		"dropdown[1.5,2.5;3;teleports;" .. S("Teleport to...")
	for i, v in pairs(lottblocks.palantiri[network]) do
		if i ~= palantir and i ~= "options" and i ~= "owner" then
			form = form .. "," .. i
		end
	end
	form    = form .. ";1]"
	local n = 1
	local h = 3.5
	for i, v in pairs(lottblocks.palantiri[network]["options"]) do
		local c = "red"
		if v == "true" then
			c = "green"
		end
		form = form .. "label[" .. n .. "," .. h .. ";" .. minetest.colorize(c, races_p[i]) .. "]"
		n    = n + 1.5
		if n == 5.5 then
			n = 1
			h = 4
		end
	end
	return form
end

local function options_form(network)
	local checkbox_pos = 1
	-- checkbox[,;;;;] ^ show a checkbox
	-- 1. x and y position of checkbox
	-- 2. name fieldname data is transferred to Lua
	-- 3. label to be shown left of checkbox
	-- 4. selected (optional) true/false
	-- 5. tooltip (optional)
	local options      = "size[5,5]" ..
		"background[5,5;1,1;gui_elfbg.png;true]" ..
		"label[1,0.5;" .. S("Allowed races") .. ":]" ..
		"button[1,4;2,1;exit;" .. S("Proceed") .. "]"
	for i, race in pairs(races_p) do
		options      = options .. "checkbox[1," .. checkbox_pos .. ";" .. i ..
			";" .. race:gsub("^%l", string.upper) .. ";" ..
			tostring(lottblocks.palantiri[network].options[i]) .. "]"
		checkbox_pos = checkbox_pos + 0.5
	end
	return options
end

minetest.register_privilege("palantiri", {
	description          = S("Allows editing palantiri"),
	give_to_singleplayer = false,
})

minetest.register_node("lottblocks:palantir", {
	description               = S("Palantir"),
	tiles                     = { "default_obsidian.png" },
	paramtype                 = "light",
	drawtype                  = "mesh",
	mesh                      = "lottblocks_palantir.obj",
	node_placement_prediction = "",
	on_punch                  = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("configured") == 2 then
			meta:set_string("formspec", formspec_update(meta))
		end
	end,
	on_rightclick             = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("configured") == 2 then
			meta:set_string("formspec", formspec_update(meta))
		end
	end,
	on_place                  = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer, "palantiri") then
			minetest.chat_send_player(placer:get_player_name(),
				minetest.colorize("red", S("You have no skill use the palantir!")))
			return
		end
		if check_blocks(pointed_thing.above) == false then
			minetest.chat_send_player(placer:get_player_name(),
				minetest.colorize(purple, S("One does not simply set down a palantir...")))
			return
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	after_place_node          = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_int("configured", 0)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("formspec", "size[8,5]" ..
			"background[8,5;1,1;gui_elfbg.png;true]" ..
			"button[2.75,3.5;3,1;exit;" .. S("Proceed") .. "]" ..
			"field[3,1;3,1;network;" .. S("Network Name") .. ";]" ..
			"field[3,2.5;3,1;palantir;" .. S("Palantir Name") .. ";]")
	end,
	on_receive_fields         = function(pos, formname, fields, sender)
		local meta        = minetest.get_meta(pos)
		local configured  = meta:get_int("configured")
		local player_name = sender:get_player_name()
		local player_race = races.get_race(player_name)

		if configured == 0 then
			if not fields.network or not fields.palantir
				or fields.network == "" or fields.palantir == "" then
				minetest.chat_send_player(player_name,
					minetest.colorize("red", S("Both the network and the palantir must have a name!!")))
				return
			end
			if fields.palantir == "owner" or fields.palantir == "options" then
				minetest.chat_send_player(player_name,
					minetest.colorize("red", S("Palantir cannot use reserved name!")))
				return
			end
			if string.find(fields.palantir, ",") then
				minetest.chat_send_player(player_name, minetest.colorize("red",
					S("Palantir cannot have commas in its name!")))
				return
			end
			if not lottblocks.palantiri[fields.network] then
				lottblocks.palantiri[fields.network]       = {}
				lottblocks.palantiri[fields.network].owner = player_name
			else
				if lottblocks.palantiri[fields.network].owner ~= player_name then
					minetest.chat_send_player(player_name,
						minetest.colorize("red", S("Someone else has a network with this name!")))
					return
				end
			end
			if not lottblocks.palantiri[fields.network][fields.palantir] then
				lottblocks.palantiri[fields.network][fields.palantir] = pos
			else
				minetest.chat_send_player(player_name,
					minetest.colorize("red", S("A palantir already exists on this network with the same name!")))
				return
			end
			if not lottblocks.palantiri[fields.network].options then
				lottblocks.palantiri[fields.network].options = {}
				local options                                = lottblocks.palantiri[fields.network].options
				for i, race in pairs(races_p) do
					options[i] = "true"
				end
			end
			meta:set_string("network", fields.network)
			meta:set_string("name", fields.palantir)
			meta:set_string("formspec", options_form(fields.network))
			save_palantiri()
			meta:set_int("configured", 1)
		elseif meta:get_int("configured") == 1 then
			local network = meta:get_string("network")
			if not network then
				return
			end
			if player_name == meta:get_string("owner") then
				for i, race in pairs(races_p) do
					if fields[i] ~= nil then
						lottblocks.palantiri[network].options[i] = tostring(fields[i])
					end
				end
			end
			if fields.exit then
				meta:set_string("formspec", formspec_update(meta))
				meta:set_int("configured", 2)
				save_palantiri()
			end
		else
			-- проверки перед перемещением
			-- check privs / проверка привилегий
			if not minetest.check_player_privs(sender, "palantiri") then
				minetest.chat_send_player(player_name,
					minetest.colorize("red", S("You have no skill use the palantir!")))
				return
			end

			if check_blocks(pos) == false then
				minetest.chat_send_player(player_name,
					minetest.colorize(purple, S("The palantiri is no longer anchored to the world!")))
				minetest.remove_node(pos)
				minetest.add_item(pos, "lottblocks:palantir")
				return
			end

			local can_tp  = false
			local network = meta:get_string("network")
			if not network then
				return
			end

			if player_name == meta:get_string("owner") then
				can_tp = true
			elseif minetest.check_player_privs(player_name, { palantiri = true }) then
				can_tp = lottblocks.palantiri[network].options[player_race] == "true"
			end


			-- teleportation / собственно телепортация
			if can_tp == true then
				if fields.teleports == S("Teleport to...") then
					if
						minetest.registered_nodes[minetest.get_node({ x = pos.x, y = pos.y + 2, z = pos.z }).name].walkable or
						minetest.registered_nodes[minetest.get_node({ x = pos.x, y = pos.y + 1, z = pos.z }).name].walkable
					then
						minetest.chat_send_player(
							sender:get_player_name(),
							minetest.colorize(purple, S("Sorry, at the point of teleport wall"))
						)
						return
					end
					sender:set_pos({ x = pos.x, y = pos.y + 1, z = pos.z })
					minetest.close_formspec(player_name, formname)
					return
				elseif fields.teleports == nil or
					lottblocks.palantiri[meta:get_string("network")][fields.teleports] == nil then
					return
				end
				local p = lottblocks.palantiri[meta:get_string("network")][fields.teleports]
				-- check target (node in the position target) / проверка, что мы телепортируемся не в стену
				if minetest.registered_nodes[minetest.get_node({ x = p.x + 1, y = p.y - 1, z = p.z }).name].walkable or
					minetest.registered_nodes[minetest.get_node({ x = p.x + 1, y = p.y, z = p.z }).name].walkable or
					minetest.registered_nodes[minetest.get_node({ x = p.x + 1, y = p.y + 1, z = p.z }).name].walkable then
					minetest.chat_send_player(
						sender:get_player_name(),
						minetest.colorize(purple, S("Sorry, at the point of teleport wall"))
					)
					return
				end
				sender:set_pos({ x = p.x + 1, y = p.y, z = p.z })
				minetest.close_formspec(player_name, formname)
			elseif can_tp == false then
				if fields.teleports and fields.teleports ~= S("Teleport to...") then
					sender:set_pos({
						x = pos.x + math.random(-50, 50),
						y = pos.y + math.random(20, 50),
						z = pos.z + math.random(-50, 50)
					})
					sender:set_hp(math.random(1, 10))
				end
			end
		end
	end,
	on_destruct               = function(pos)
		local meta = minetest.get_meta(pos)
		local i
		if meta:get_int("configured") >= 1 then
			if not lottblocks.palantiri[meta:get_string("network")] then
				return
			end
			lottblocks.palantiri[meta:get_string("network")][meta:get_string("name")] = nil
			i                                                                         = 0
			-- count element in table / считаем колисечтво элементов в таблице
			for key, value in pairs(lottblocks.palantiri[meta:get_string("network")]) do
				i = i + 1
			end
			-- delete network if not palantir / удалим сеть если в ней не осталось палантиров
			if i <= 2 then
				lottblocks.palantiri[meta:get_string("network")] = nil
			end
			save_palantiri()
		end
	end,
	groups                    = { forbidden = 1, very_hard = 1 },
})

minetest.register_craft({
	output = "lottblocks:palantir",
	recipe = {
		{ "default:obsidian", "lottores:tilkal", "default:obsidian" },
		{ "lottores:tilkal", "default:obsidian", "lottores:tilkal" },
		{ "default:obsidian", "lottores:tilkal", "default:obsidian" }
	}
})
