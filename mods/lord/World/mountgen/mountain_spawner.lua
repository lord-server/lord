local S = minetest.get_translator("mountgen")
local esc = minetest.formspec_escape

local function validate_config(config)
	for k, v in pairs(config) do
		if v == "" then
			return false
		end
	end
	if config.ANGLE < 10 then
		return false
	end
	if config.ANGLE >= 160 then
		return false
	end
	return true
end

local show_abort_menu = function (user_name, vertex_pos)
	local formspec = ""
	local width = 9
	local bw = 5 - 0.5
	local pos = 0.5

	formspec = formspec .. "label[3.5," .. (pos - 0.3) .. ";" .. S("Mountain creation tool") .. "]"
	pos = pos + 0.5
	formspec = formspec .. "label[3.5," .. (pos - 0.3) .. ";" .. S("USE WITH CAUTION!") .. "]"
	pos = pos + 1

	formspec = formspec .. "field[3," .. pos .. ";1,1;vertex_x;;" .. vertex_pos.x .. "]"
	formspec = formspec .. "field[5," .. pos .. ";1,1;vertex_y;;" .. vertex_pos.y .. "]"
	formspec = formspec .. "field[7," .. pos .. ";1,1;vertex_z;;" .. vertex_pos.z .. "]"
	pos = pos + 1

	formspec = formspec .. "button_exit[2.75," .. pos .. ";" .. bw .. ",1;abort;" .. esc(S("Abort")) .. "]"
	pos = pos + 1

	formspec = "size[" .. width .. "," .. pos .. "]" .. formspec

	minetest.show_formspec(user_name, "mountgen:configure", formspec)
end

local show_config_menu = function(user_name, config, vertex_pos)
	local formspec = ""
	local width = 9
	local bw = 5 - 0.5
	local pos = 0.5

	formspec = formspec .. "label[3.5," .. (pos - 0.3) .. ";" .. S("Mountain creation tool") .. "]"
	pos = pos + 0.5
	formspec = formspec .. "label[3.5," .. (pos - 0.3) .. ";" .. S("USE WITH CAUTION!") .. "]"
	pos = pos + 1

	-- позиция
	formspec = formspec .. "field[3," .. pos .. ";1,1;vertex_x;;" .. vertex_pos.x .. "]"
	formspec = formspec .. "field[5," .. pos .. ";1,1;vertex_y;;" .. vertex_pos.y .. "]"
	formspec = formspec .. "field[7," .. pos .. ";1,1;vertex_z;;" .. vertex_pos.z .. "]"
	pos = pos + 1

	-- метод
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Method")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_method;;" .. esc(config.METHOD) .. "]"
	pos = pos + 0.8

	-- угол горы
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Angle")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_angle;;" .. esc(config.ANGLE) .. "]"
	pos = pos + 0.8

	-- основание
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Base height")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_base;;" .. esc(config.Y0) .. "]"
	pos = pos + 0.8

	-- снежная линия
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Snow line")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_snow_line;;" .. esc(config.SNOW_LINE) .. "]"
	pos = pos + 0.8

	-- сглаживание на крупном масштабе
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Smooth big scale")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_rk_big;;" .. esc(config.rk_big) .. "]"
	pos = pos + 0.8

	-- сглаживание на малом масштабе
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Smooth small scale")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_rk_small;;" .. esc(config.rk_small) .. "]"
	pos = pos + 0.8

	-- граница мелкого масштаба (лог2)
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Small scale (log2)")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_rk_thr;;" .. esc(config.rk_thr) .. "]"
	pos = pos + 0.8

	-- грунт сверху
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Top dirt")) .. "]"
	formspec = formspec .. "field[4," .. pos .. ";" .. bw .. ",0.5;edit_top_cover;;" .. esc(config.top_cover) .. "]"
	pos = pos + 0.8


	formspec = formspec .. "button[2.75," .. pos .. ";" .. bw .. ",1;save_main;" .. esc(S("Save")) .. "]"
	pos = pos + 1
	formspec = formspec .. "button_exit[2.75," .. pos .. ";" .. bw .. ",1;generate;" .. esc(S("Generate")) .. "]"
	pos = pos + 1

	formspec = "size[" .. width .. "," .. pos .. "]" .. formspec

	minetest.show_formspec(user_name, "mountgen:configure", formspec)
end

minetest.register_on_player_receive_fields(function(clicker, formname, fields)
	if formname ~= "mountgen:configure" then
		return
	end

	-- check your privileges!
	local player = clicker:get_player_name()
	local can_edit = minetest.get_player_privs(player)[mountgen.required_priv]
	if not can_edit then
		return
	end

	-- mountain vertex, where node is located
	local vertex = {
		x = tonumber(fields["vertex_x"]),
		y = tonumber(fields["vertex_y"]),
		z = tonumber(fields["vertex_z"])
	}

	-- handling "abort" button
	if fields["abort"] ~= nil then
		minetest.log("abort generate mountain at " .. vertex.x .. " "
												   .. vertex.y .. " "
												   .. vertex.z)
		local meta = minetest.get_meta(vertex)
		meta:set_int("run", 0)
		return
	end

	-- handling "save" and "generate" button
	if fields["save_main"] == nil and fields["generate"] == nil then
		return
	end

	-- build config from settings
	local config     = {}
	for k,v in pairs(mountgen.config) do
		config[k] = v
	end

	config.METHOD    = fields["edit_method"]
	config.ANGLE     = tonumber(fields["edit_angle"]) or 0
	config.Y0        = tonumber(fields["edit_base"]) or 0
	config.SNOW_LINE = tonumber(fields["edit_snow_line"]) or 0
	config.rk_big    = tonumber(fields["edit_rk_big"]) or 0
	config.rk_small  = tonumber(fields["edit_rk_small"]) or 0
	config.rk_thr    = tonumber(fields["edit_rk_thr"]) or 0
	config.top_cover = fields["edit_top_cover"]

	if not validate_config(config) then
		minetest.log("Incorrect mountgen parameters. Exiting")
		return
	end

	-- save settings to node meta
	local meta = minetest.get_meta(vertex)
	meta:set_string("config", minetest.serialize(config))

	-- save config options for next usage
	mountgen.config = config

	-- start mountain generation
	if fields["generate"] ~= nil then
		minetest.log("start generate mountain at " .. vertex.x .. " " .. vertex.y .. " " .. vertex.z)
		minetest.log("parameters: " .. dump(config))
		local height_map = mountgen.generate_height_map(config, vertex)
		if height_map ~= nil then
			meta:set_string("map", minetest.serialize(height_map))
			meta:set_string("completed_chunks", minetest.serialize({}))
			meta:set_int("run", 1)
		end
	end
end)

local function can_edit(player)
    return minetest.get_player_privs(player:get_player_name())[mountgen.required_priv]
end

local function can_dig(pos, player)
	return can_edit(player)
end

minetest.register_node("mountgen:mountain_spawner", {
	description = S("Mountain spawner"),
	tiles = {
		"mountgen_mountain_spawner.png"
	},
	groups = {cracky=2, not_in_creative_inventory=1},
	can_dig = can_dig,
    on_place = function(itemstack, placer, pointed_thing)
        if (not can_edit(placer)) then
            return itemstack
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,
    after_place_node          = function(pos, placer)
		local meta = minetest.get_meta(pos)
        minetest.log("Meta = "..tostring(meta))
	end,
    on_punch = function (pos, node, puncher, pointed_thing)
        -- show configure menu
        local user_name = puncher:get_player_name()
		if user_name == nil then
			return
		end
        local can_access = minetest.get_player_privs(user_name)[mountgen.required_priv]
        if not can_access then
            return
        end

		-- if we have config at node meta use it
		local meta = minetest.get_meta(pos)
		local config_ser = meta:get_string("config")
		local run = meta:get_int("run") or 0
		local config

		if config_ser ~= nil then
			config = minetest.deserialize(config_ser) or mountgen.config
		else
			config = mountgen.config
		end

		-- show menu
		if run == 0 then
			show_config_menu(user_name, config, pos)
		else
			show_abort_menu(user_name, pos)
		end
	end,
})

minetest.register_abm({
	label = "Generate mountain",
	nodenames = {"mountgen:mountain_spawner"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		local run = meta:get_int("run") or 0
		if run ~= 1 then
			return
		end
		local config_ser = meta:get_string("config")
		local config = minetest.deserialize(config_ser)
		local map = minetest.deserialize(meta:get_string("map"))
		local completed = minetest.deserialize(meta:get_string("completed_chunks"))
		print("ABM Config: "..dump(config))
		completed = mountgen.mountgen(pos, config, map, completed)
		if completed.ready then
			minetest.set_node(pos, {name="air"})
		else
			meta:set_string("completed_chunks", minetest.serialize(completed))
		end
	end
})
