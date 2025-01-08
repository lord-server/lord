local Generator = require('mountgen.Generator')

local S      = minetest.get_mod_translator()
local Logger = minetest.get_mod_logger()
local spec   = minetest.formspec


mountgen.show_config_menu = function(user_name, config)
	local formspec = ""
	local width = 8
	local bw = 5 - 0.5
	local pos = 0.5

	formspec = formspec .. spec.label(3.5, pos - 0.3, S("Mountain creation tool"))
	pos = pos + 0.5
	formspec = formspec .. spec.label(3.5, pos - 0.3, S("USE WITH CAUTION!"))
	pos = pos + 1

	-- метод
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Method"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_method', '', config.METHOD)
	pos = pos + 0.8
	-- угол горы
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Angle"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_angle', '', config.ANGLE)
	pos = pos + 0.8
	-- основание
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Foot height"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_base', '', config.Y0)
	pos = pos + 0.8
	-- снежная линия
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Snow line"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_snow_line', '', config.SNOW_LINE)
	pos = pos + 0.8
	-- сглаживание на крупном масштабе
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Big scale smooth"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_rk_big', '', config.rk_big)
	pos = pos + 0.8
	-- сглаживание на малом масштабе
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Small scale smooth"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_rk_small', '', config.rk_small)
	pos = pos + 0.8
	-- граница мелкого масштаба (лог2)
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Small scale (log2)"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_rk_thr', '', config.rk_thr)
	pos = pos + 0.8

	-- грунт сверху
	formspec = formspec .. spec.label(0.5, pos - 0.3, S("Top dirt"))
	formspec = formspec .. spec.field(3, pos, bw, 0.5, 'edit_top_cover', '', config.top_cover)
	pos = pos + 0.8


	formspec = formspec .. spec.button(1, pos, 3, 1, 'save_main', S("Save"))
	formspec = formspec .. spec.button(4, pos, 3, 1, 'generate', S("Generate"))
	pos = pos + 1

	formspec = spec.size(width, pos) .. formspec

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
			local top_position = clicker:get_pos()
			local config       = mountgen.config
			Logger.action("use mount stick at " .. top_position.x .. " " .. top_position.y .. " " .. top_position.z)
			Logger.action("parameters: " .. dump(mountgen.config))
			Generator:new(top_position, config):run()
		end
	end
end)
