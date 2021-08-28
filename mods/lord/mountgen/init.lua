local S = minetest.get_translator("mountgen")
local esc = minetest.formspec_escape

mountgen = {
	required_priv = "server",
	config = {
		ANGLE=60,
		HEAD_ANGLE = 120,
		TOP_H = 0.3,
		Y0 = 0,
		USE_DIAMOND_SQUARE = true,
		SNOW_LINE = 50,
		SNOW_LINE_RAND = 4,
		GRASS_PERCENT = 10,
		FLOWERS_LINE = 35,
		FLOWERS_PERCENT = 10,
		TREE_LINE = 20,
		TREE_PROMILLE = 4,

		rk_big = 2,
		rk_small = 6,
		rk_thr = 4,

		top_cover = "lottmapgen:dunland_grass",
	},
}

mountgen.show_config_menu = function(user_name, config)
	local formspec = ""
	local width = 8
        local bw = 5 - 0.5
        local pos = 0.5

	formspec = formspec.."label[3.5,"..(pos-0.3)..";"..S("Mountain creation tool").."]"
	pos = pos + 0.5
	formspec = formspec.."label[3.5,"..(pos-0.3)..";"..S("USE WITH CAUTION!").."]"
	pos = pos + 1

	-- угол основной части горы
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Angle")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_angle;;"..esc(config.ANGLE).."]"
	pos = pos + 0.8

	-- угол вершины
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Head angle")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_head_angle;;"..esc(config.HEAD_ANGLE).."]"
	pos = pos + 0.8

	-- основание
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Base height")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_base;;"..esc(config.Y0).."]"
	pos = pos + 0.8

	-- доля вершины
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Head fraction")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_head_fraction;;"..esc(config.TOP_H).."]"
	pos = pos + 0.8

	-- снежная линия
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Snow line")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_snow_line;;"..esc(config.SNOW_LINE).."]"
	pos = pos + 0.8

	-- сглаживание на крупном масштабе
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Smooth big scale")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_rk_big;;"..esc(config.rk_big).."]"
	pos = pos + 0.8

	-- сглаживание на малом масштабе
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Smooth small scale")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_rk_small;;"..esc(config.rk_small).."]"
	pos = pos + 0.8

	-- граница мелкого масштаба (лог2)
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Small scale (log2)")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_rk_thr;;"..esc(config.rk_thr).."]"
	pos = pos + 0.8

	-- грунт сверху
	formspec = formspec.."label[0.5,"..(pos-0.3)..";"..esc(S("Top dirt")).."]"
	formspec = formspec.."field[3,"..pos..";"..bw..",0.5;edit_top_cover;;"..esc(config.top_cover).."]"
	pos = pos + 0.8


	formspec = formspec.."button[2.75,"..pos..";"..bw..",1;save_main;"..esc(S("Save")).."]"
	pos = pos + 1

	formspec = "size["..width..","..pos.."]"..formspec

	minetest.show_formspec(user_name, "mountgen:configure", formspec)
end

local function validate_config(config)
	for k, v in pairs(config) do
		if v == nil then
			return false
		end
	end
	if config["HEAD_ANGLE"] > config["ANGLE"] then
		return false
	end
	if config.TOP_H < 0 or config.TOP_H >= 1 then
		return false
	end
	return true
end

minetest.register_on_player_receive_fields(function(clicker, formname, fields)
        local player = clicker:get_player_name()
        local can_edit = minetest.get_player_privs(player)[mountgen.required_priv]
	if not can_edit then
		return
	end

	if formname == "mountgen:configure" then
		-- handling main form
		if fields["save_main"] ~= nil then
			local config = {}
			config.ANGLE			= tonumber(fields["edit_angle"])
			config.HEAD_ANGLE		= tonumber(fields["edit_head_angle"])
			config.Y0			= tonumber(fields["edit_base"])
			config.TOP_H			= tonumber(fields["edit_head_fraction"])
			config.SNOW_LINE		= tonumber(fields["edit_snow_line"])
			config.rk_big			= tonumber(fields["edit_rk_big"])
			config.rk_small			= tonumber(fields["edit_rk_small"])
			config.rk_thr			= tonumber(fields["edit_rk_thr"])
			config.top_cover		= fields["edit_top_cover"]
			if validate_config(config) then
				mountgen.config.ANGLE			= config.ANGLE
				mountgen.config.HEAD_ANGLE		= config.HEAD_ANGLE
				mountgen.config.Y0			= config.Y0
				mountgen.config.TOP_H			= config.TOP_H
				mountgen.config.SNOW_LINE		= config.SNOW_LINE
				mountgen.config.rk_big			= config.rk_big
				mountgen.config.rk_small		= config.rk_small
				mountgen.config.rk_thr			= config.rk_thr
				mountgen.config.top_cover		= config.top_cover
			end
		end
	end
end)

minetest.register_tool("mountgen:mount_tool", {
	description = "Горный посох",
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, user, pointed_thing)
		local user_name = user:get_player_name()
		local can_access = minetest.get_player_privs(user_name)[mountgen.required_priv]
		if not can_access then
			return
		end
		local top = user:get_pos()
		local config = mountgen.config
		minetest.log("use mount stick at "..top.x.." "..top.y.." "..top.z)

		local fun
		if config.USE_DIAMOND_SQUARE then
			fun = mountgen.diamond_square
		else
			fun = mountgen.cone
		end

		mountgen.mountgen(top, fun, config)
		return itemstack
	end,
	on_place = function(itemstack, placer, pointed_thing)
		-- show configure menu
		local user_name = placer:get_player_name()
		local can_access = minetest.get_player_privs(user_name)[mountgen.required_priv]
		if not can_access then
			return
		end
		mountgen.show_config_menu(user_name, mountgen.config)
	end,
	group = {},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

dofile(minetest.get_modpath("mountgen").."/map.lua")
dofile(minetest.get_modpath("mountgen").."/height_map.lua")
dofile(minetest.get_modpath("mountgen").."/cone.lua")
dofile(minetest.get_modpath("mountgen").."/diamond_square.lua")
dofile(minetest.get_modpath("mountgen").."/mountgen.lua")

