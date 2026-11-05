local string_format, table_concat, tostring
    = string.format, table.concat, tostring


--- Logs information about clients.
--- @static
--- @class client.Info
local Info = {
	--- @static
	--- @private
	--- @type helpers.Logger
	logger = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- @static
--- @param logger helpers.Logger
function Info.init(logger)
	Info.logger = logger
end

--- @static
--- @private
--- @param info PlayerInformation
--- @return string
function Info.format_player_info(info)
	return table_concat({
		'ip='       .. tostring(info.address) .. ' (v' .. tostring(info.ip_version) .. ')',
		'client='   .. tostring(info.version_string),
		'protocol=' .. tostring(info.protocol_version),
		'formspec=' .. tostring(info.formspec_version),
		'lang='     .. tostring(info.lang_code),
	}, ', ')
end

--- @static
--- @private
--- @param window PlayerWindowInformation|nil
--- @return string
function Info.format_window_info(window)
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

--- @static
--- @param player_name string
--- @param player_info PlayerInformation
--- @param window_info PlayerWindowInformation|nil
function Info.log(player_name, player_info, window_info)
	Info.logger.action(
		'%s: %s, %s',
		player_name, Info.format_player_info(player_info), Info.format_window_info(window_info)
	)
end

--- @static
--- @param player Player
--- @param cheat  {type:string}
function Info.log_cheat(player, cheat)
	Info.logger.action(
		'%s: cheat: %s at %s',
		player:get_player_name(), cheat.type, core.pos_to_string(player:get_pos(), 1)
	)
end


return Info
