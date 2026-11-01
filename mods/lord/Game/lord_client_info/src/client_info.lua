local string_format, table_concat, tostring
    = string.format, table.concat, tostring


--- Delay before logging: client sends window information some time after join.
local LOG_DELAY = 2

--- @type helpers.Logger
local logger

--- @param info table
--- @return string
local function format_player_info(info)
	return table_concat({
		'ip='       .. tostring(info.address) .. ' (v' .. tostring(info.ip_version) .. ')',
		'client='   .. tostring(info.version_string),
		'protocol=' .. tostring(info.protocol_version),
		'formspec=' .. tostring(info.formspec_version),
		'lang='     .. tostring(info.lang_code),
	}, ', ')
end

--- @param window table|nil
--- @return string
local function format_window_info(window)
	if not window then
		return 'window=unknown'
	end

	return string_format(
		'window=%dx%d, formspec_size=%.2fx%.2f, gui_scaling=%.2f, hud_scaling=%.2f, touch=%s',
		window.size.x, window.size.y,
		window.max_formspec_size.x, window.max_formspec_size.y,
		window.real_gui_scaling, window.real_hud_scaling,
		tostring(window.touch_controls)
	)
end

--- @param player_name string
local function log_client_info(player_name)
	local info = core.get_player_information(player_name)
	if not info then
		return
	end

	logger.action(
		'%s: %s, %s',
		player_name, format_player_info(info), format_window_info(core.get_player_window_information(player_name))
	)
end

--- @param player Player
--- @param cheat  {type:string}
local function log_cheat(player, cheat)
	logger.action(
		'%s: cheat: %s at %s',
		player:get_player_name(), cheat.type, core.pos_to_string(player:get_pos(), 1)
	)
end


return {
	--- @param mod core.Mod
	init = function(mod)
		logger = mod.logger

		core.register_on_joinplayer(function(player)
			core.after(LOG_DELAY, log_client_info, player:get_player_name())
		end)
		core.register_on_cheat(log_cheat)
	end,
}
