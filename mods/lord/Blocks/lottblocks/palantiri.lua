local S = core.get_mod_translator()

-- TODO #1555 remove old code for store in file.
local function deprecated_load_palantiri()
	local content = io.read_from_file(core.get_worldpath() .. "/LORD/palantiri")
	if not content then return nil end

	return core.deserialize(content)[1]
end

local mod_storage = core.get_mod_storage()
local function load_palantiri()
	local tmp = mod_storage:get("serialized_palantiri")
	if tmp then
		return core.deserialize(tmp)
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
	mod_storage:set_string("serialized_palantiri", core.serialize(lottblocks.palantiri))
end

local function check_blocks(pos)
	local minp = { x = pos.x - 2, y = pos.y - 2, z = pos.z - 2 }
	local maxp = { x = pos.x + 2, y = pos.y + 2, z = pos.z + 2 }

	worldedit.keep_loaded(minp, maxp)

	local _, tilkal  = core.find_nodes_in_area(minp, maxp, "lottores:tilkal")
	local _, mithril = core.find_nodes_in_area(minp, maxp, "lottores:mithril_block")
	if tilkal["lottores:tilkal"] < 8 or mithril["lottores:mithril_block"] < 16 then
		return false
	end
	return true
end

core.register_on_shutdown(function()
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
		"background[5,5;1,1;palantir_form-bg.png;true]" ..
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
		form = form .. "label[" .. n .. "," .. h .. ";" .. core.colorize(c, races_p[i]) .. "]"
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
		"background[5,5;1,1;palantir_form-bg.png;true]" ..
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

--- Checks the names given while the palantir configuring.
--- @param fields table form fields
--- @return string|nil error message
local function get_names_error(fields)
	if not fields.network or not fields.palantir
		or fields.network == '' or fields.palantir == '' then
		return S('Both the network and the palantir must have a name!!')
	end
	if fields.palantir == 'owner' or fields.palantir == 'options' then
		return S('Palantir cannot use reserved name!')
	end
	if string.find(fields.palantir, ',') then
		return S('Palantir cannot have commas in its name!')
	end
end

--- Adds the palantir to the network (creates the network if it doesn't exist).
--- @param pos         Position
--- @param fields      table form fields
--- @param player_name string
--- @return string|nil error message
local function add_to_network(pos, fields, player_name)
	if not lottblocks.palantiri[fields.network] then
		lottblocks.palantiri[fields.network]       = {}
		lottblocks.palantiri[fields.network].owner = player_name
	elseif lottblocks.palantiri[fields.network].owner ~= player_name then
		return S('Someone else has a network with this name!')
	end
	if lottblocks.palantiri[fields.network][fields.palantir] then
		return S('A palantir already exists on this network with the same name!')
	end
	lottblocks.palantiri[fields.network][fields.palantir] = pos

	if not lottblocks.palantiri[fields.network].options then
		lottblocks.palantiri[fields.network].options = {}
		local options                                = lottblocks.palantiri[fields.network].options
		for i, race in pairs(races_p) do
			options[i] = 'true'
		end
	end
end

--- First step: the palantir gets a network and a name.
--- @param pos         Position
--- @param meta        MetaDataRef
--- @param fields      table form fields
--- @param player_name string
local function configure_palantir(pos, meta, fields, player_name)
	local error_message = get_names_error(fields) or add_to_network(pos, fields, player_name)
	if error_message then
		core.chat_send_player(player_name, core.colorize('red', error_message))

		return
	end

	meta:set_string('network', fields.network)
	meta:set_string('name', fields.palantir)
	meta:set_string('formspec', options_form(fields.network))
	save_palantiri()
	meta:set_int('configured', 1)
end

--- Second step: the owner chooses the races that are allowed to use the network.
--- @param meta        MetaDataRef
--- @param fields      table form fields
--- @param player_name string
local function update_network_options(meta, fields, player_name)
	local network = meta:get_string('network')
	if not network then
		return
	end
	if player_name == meta:get_string('owner') then
		for i, race in pairs(races_p) do
			if fields[i] ~= nil then
				lottblocks.palantiri[network].options[i] = tostring(fields[i])
			end
		end
	end
	if fields.exit then
		meta:set_string('formspec', formspec_update(meta))
		meta:set_int('configured', 2)
		save_palantiri()
	end
end

--- @param pos Position
--- @return boolean
local function is_walkable_at(pos)
	return core.registered_nodes[core.get_node(pos).name].walkable
end

--- @param sender Player
local function send_wall_message(sender)
	core.chat_send_player(
		sender:get_player_name(),
		core.colorize(purple, S('Sorry, at the point of teleport wall'))
	)
end

--- Teleports the player to the target palantir of the network.
--- @param pos      Position position of the used palantir
--- @param formname string
--- @param fields   table  form fields
--- @param sender   Player
--- @param network  string
local function teleport_to_palantir(pos, formname, fields, sender, network)
	local player_name = sender:get_player_name()
	if fields.teleports == S('Teleport to...') then
		if is_walkable_at({ x = pos.x, y = pos.y + 2, z = pos.z })
			or is_walkable_at({ x = pos.x, y = pos.y + 1, z = pos.z }) then
			send_wall_message(sender)

			return
		end
		sender:set_pos({ x = pos.x, y = pos.y + 1, z = pos.z })
		core.close_formspec(player_name, formname)

		return
	elseif fields.teleports == nil or lottblocks.palantiri[network][fields.teleports] == nil then
		return
	end

	local p = lottblocks.palantiri[network][fields.teleports]
	-- check target (node in the position target) / проверка, что мы телепортируемся не в стену
	if is_walkable_at({ x = p.x + 1, y = p.y - 1, z = p.z })
		or is_walkable_at({ x = p.x + 1, y = p.y, z = p.z })
		or is_walkable_at({ x = p.x + 1, y = p.y + 1, z = p.z }) then
		send_wall_message(sender)

		return
	end
	sender:set_pos({ x = p.x + 1, y = p.y, z = p.z })
	core.close_formspec(player_name, formname)
end

--- Not allowed player is thrown away somewhere and hurt.
--- @param pos    Position
--- @param fields table form fields
--- @param sender Player
local function throw_away(pos, fields, sender)
	if fields.teleports and fields.teleports ~= S('Teleport to...') then
		sender:set_pos({
			x = pos.x + math.random(-50, 50),
			y = pos.y + math.random(20, 50),
			z = pos.z + math.random(-50, 50)
		})
		sender:set_hp(math.random(1, 10))
	end
end

--- @param sender      Player
--- @param meta        MetaDataRef
--- @param network     string
--- @param player_race string
--- @return boolean
local function can_teleport(sender, meta, network, player_race)
	if sender:get_player_name() == meta:get_string('owner') then
		return true
	elseif core.check_player_privs(sender:get_player_name(), { palantiri = true }) then
		return lottblocks.palantiri[network].options[player_race] == 'true'
	end

	return false
end

--- Third step: using of the configured palantir.
--- @param pos         Position
--- @param formname    string
--- @param fields      table form fields
--- @param sender      Player
--- @param player_race string
local function use_palantir(pos, formname, fields, sender, player_race)
	local meta        = core.get_meta(pos)
	local player_name = sender:get_player_name()

	-- проверки перед перемещением
	-- check privs / проверка привилегий
	if not core.check_player_privs(sender, 'palantiri') then
		core.chat_send_player(player_name,
			core.colorize('red', S('You have no skill use the palantir!')))
		return
	end

	if check_blocks(pos) == false then
		core.chat_send_player(player_name,
			core.colorize(purple, S('The palantiri is no longer anchored to the world!')))
		core.remove_node(pos)
		core.add_item(pos, 'lottblocks:palantir')
		return
	end

	local network = meta:get_string('network')
	if not network then
		return
	end

	-- teleportation / собственно телепортация
	if can_teleport(sender, meta, network, player_race) then
		teleport_to_palantir(pos, formname, fields, sender, network)
	else
		throw_away(pos, fields, sender)
	end
end

core.register_privilege("palantiri", {
	description          = S("Allows editing palantiri"),
	give_to_singleplayer = false,
})

core.register_node("lottblocks:palantir", {
	description               = S("Palantir"),
	inventory_image           = "lottblocks_palantir_item.png^[opacity:220",
	wield_image               = "lottblocks_palantir_item.png^[opacity:220",
	drawtype                  = "mesh",
	mesh                      = "lottblocks_palantir.obj",
	tiles                     = { "lottblocks_palantir.png^[opacity:235" },
	use_texture_alpha         = "blend",
	paramtype                 = "light",
	node_placement_prediction = "",
	on_punch                  = function(pos)
		local meta = core.get_meta(pos)
		if meta:get_int("configured") == 2 then
			meta:set_string("formspec", formspec_update(meta))
		end
	end,
	on_rightclick             = function(pos)
		local meta = core.get_meta(pos)
		if meta:get_int("configured") == 2 then
			meta:set_string("formspec", formspec_update(meta))
		end
	end,
	on_place                  = function(itemstack, placer, pointed_thing)
		if not core.check_player_privs(placer, "palantiri") then
			core.chat_send_player(placer:get_player_name(),
				core.colorize("red", S("You have no skill use the palantir!")))
			return
		end
		if check_blocks(pointed_thing.above) == false then
			core.chat_send_player(placer:get_player_name(),
				core.colorize(purple, S("One does not simply set down a palantir...")))
			return
		end
		return core.item_place(itemstack, placer, pointed_thing)
	end,
	after_place_node          = function(pos, placer)
		local meta = core.get_meta(pos)
		meta:set_int("configured", 0)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("formspec", "size[8,5]" ..
			"background[8,5;1,1;palantir_form-bg.png;true]" ..
			"button[2.75,3.5;3,1;exit;" .. S("Proceed") .. "]" ..
			"field[3,1;3,1;network;" .. S("Network Name") .. ";]" ..
			"field[3,2.5;3,1;palantir;" .. S("Palantir Name") .. ";]")
	end,
	on_receive_fields         = function(pos, formname, fields, sender)
		local meta        = core.get_meta(pos)
		local configured  = meta:get_int("configured")
		local player_name = sender:get_player_name()
		local player_race = character.of(sender):get_race()

		if configured == 0 then
			configure_palantir(pos, meta, fields, player_name)
		elseif configured == 1 then
			update_network_options(meta, fields, player_name)
		else
			use_palantir(pos, formname, fields, sender, player_race)
		end
	end,
	on_destruct               = function(pos)
		local meta = core.get_meta(pos)
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

core.register_craft({
	output = "lottblocks:palantir",
	recipe = {
		{ "default:obsidian", "lottores:tilkal", "default:obsidian" },
		{ "lottores:tilkal", "default:obsidian", "lottores:tilkal" },
		{ "default:obsidian", "lottores:tilkal", "default:obsidian" }
	}
})
