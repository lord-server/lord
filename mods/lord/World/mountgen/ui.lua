local S = minetest.get_mod_translator()
local esc = minetest.formspec_escape

mountgen = {
	required_priv = "server",
	config = {
		-- for cone:
		TOP_RADIUS = 10,
		MAX_RADIUS = 20,
		-- /for cone

		ANGLE = 60,
		Y0 = 0,
		METHOD = "cone",
		SNOW_LINE = 50,
		SNOW_LINE_RAND = 4,
		GRASS_PERCENT = 10,
		FLOWERS_LINE = 35,
		FLOWERS_PERCENT = 10,
		TREE_LINE = 20,
		TREE_PROMILLE = 4,

		rk_big = 5,
		rk_small = 100,
		rk_thr = 5,

		top_cover = "lord_ground:dirt_dunland",
	},
}

mountgen.show_config_menu = function(user_name, config)
	local formspec = ""
	local width = 8
	local bw = 5 - 0.5
	local pos = 0.5

	formspec = formspec .. "label[3.5," .. (pos - 0.3) .. ";" .. S("Mountain creation tool") .. "]"
	pos = pos + 0.5
	formspec = formspec .. "label[3.5," .. (pos - 0.3) .. ";" .. S("USE WITH CAUTION!") .. "]"
	pos = pos + 1

	-- метод
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Method")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_method;;" .. esc(config.METHOD) .. "]"
	pos = pos + 0.8

	-- угол горы
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Angle")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_angle;;" .. esc(config.ANGLE) .. "]"
	pos = pos + 0.8

	-- основание
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Base height")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_base;;" .. esc(config.Y0) .. "]"
	pos = pos + 0.8

	-- снежная линия
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Snow line")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_snow_line;;" .. esc(config.SNOW_LINE) .. "]"
	pos = pos + 0.8

	-- сглаживание на крупном масштабе
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Smooth big scale")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_rk_big;;" .. esc(config.rk_big) .. "]"
	pos = pos + 0.8

	-- сглаживание на малом масштабе
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Smooth small scale")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_rk_small;;" .. esc(config.rk_small) .. "]"
	pos = pos + 0.8

	-- граница мелкого масштаба (лог2)
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Small scale (log2)")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_rk_thr;;" .. esc(config.rk_thr) .. "]"
	pos = pos + 0.8

	-- грунт сверху
	formspec = formspec .. "label[0.5," .. (pos - 0.3) .. ";" .. esc(S("Top dirt")) .. "]"
	formspec = formspec .. "field[3," .. pos .. ";" .. bw .. ",0.5;edit_top_cover;;" .. esc(config.top_cover) .. "]"
	pos = pos + 0.8


	formspec = formspec .. "button[2.75," .. pos .. ";" .. bw .. ",1;save_main;" .. esc(S("Save")) .. "]"
	pos = pos + 1
	formspec = formspec .. "button[2.75," .. pos .. ";" .. bw .. ",1;generate;" .. esc(S("Generate")) .. "]"
	pos = pos + 1

	formspec = "size[" .. width .. "," .. pos .. "]" .. formspec

	minetest.show_formspec(user_name, "mountgen:configure", formspec)
end

local function validate_config(config)
	for k, v in pairs(config) do
		if v == nil then
			return false
		end
	end
	if config.ANGLE < 15 or config.ANGLE > 90 then
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
		if fields["save_main"] ~= nil or fields["generate"] ~= nil then
			local config     = {}
			config.METHOD    = fields["edit_method"]
			config.ANGLE     = tonumber(fields["edit_angle"]) or 0
			config.Y0        = tonumber(fields["edit_base"]) or 0
			config.SNOW_LINE = tonumber(fields["edit_snow_line"]) or 0
			config.rk_big    = tonumber(fields["edit_rk_big"]) or 0
			config.rk_small  = tonumber(fields["edit_rk_small"]) or 0
			config.rk_thr    = tonumber(fields["edit_rk_thr"]) or 0
			config.top_cover = fields["edit_top_cover"]
			if validate_config(config) then
				mountgen.config.METHOD    = config.METHOD
				mountgen.config.ANGLE     = config.ANGLE
				mountgen.config.Y0        = config.Y0
				mountgen.config.SNOW_LINE = config.SNOW_LINE
				mountgen.config.rk_big    = config.rk_big
				mountgen.config.rk_small  = config.rk_small
				mountgen.config.rk_thr    = config.rk_thr
				mountgen.config.top_cover = config.top_cover
			end
		end

		if fields["generate"] ~= nil then
			local top = clicker:get_pos()
			local config = mountgen.config
			minetest.log("use mount stick at " .. top.x .. " " .. top.y .. " " .. top.z)
			minetest.log("parameters: " .. dump(mountgen.config))
			mountgen.mountgen(top, config)
		end
	end
end)

minetest.register_tool("mountgen:mount_tool", {
	description = S("Mountain tool"),
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, placer, pointed_thing)
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
