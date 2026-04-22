local colorize,      color_escape
    = core.colorize, core.get_color_escape_sequence


local COLOR = {
	success        = '#44bb55',
	error          = '#ff2222',
	alert          = '#ff6633',
	player_line    = '#ffff00',
	player_name    = '#00ff00',
	property_name  = '#ffffaa',
	property_value = '#dd8822',
	nil_value      = '#888888',
	bool_value     = '#4488ff',
	number_value   = '#00ffff',
}

--- @class debugtools.commands.character.Colorize
local Colorize = {}

--- @param value any
--- @return string
function Colorize.get_color_by_type(value)
	local value_type = type(value)

	return
		value_type == 'boolean' and COLOR.bool_value or
		value_type == 'number'  and COLOR.number_value or
		COLOR.property_value
end

--- @param value any
--- @param color string|nil
--- @param reset_color string|nil
--- @return string
function Colorize.value(value, color, reset_color)
	reset_color = reset_color or '#ffffff'

	local value_color = value == nil
		and COLOR.nil_value
		or  (color or Colorize.get_color_by_type(value))

	if type(value) == 'string' then
		value = '\'' .. value .. '\''
	end
	value = value == nil and 'nil' or tostring(value)

	return color_escape(value_color) .. value .. color_escape(reset_color)
end

--- @param color string
--- @param message string
--- @param ... any
--- @return string
function Colorize.format(color, message, ...)
	local colorized_args = table.map({ ... }, function(arg)
		return Colorize.value(arg, nil, color)
	end)

	return colorize(color, string.format(message, unpack(colorized_args)))
end

--- @param message string
--- @param ...     any
--- @return string
function Colorize.success(message, ...)
	return Colorize.format(COLOR.success, message, ...)
end

--- @param message string
--- @param ...     any
--- @return string
function Colorize.error(message, ...)
	return Colorize.format(COLOR.error, message, ...)
end

--- @param message string
--- @param ...     any
--- @return string
function Colorize.alert(message, ...)
	return Colorize.format(COLOR.alert, message, ...)
end

--- @param name string
--- @return string
function Colorize.player_line(name)
	local value_color = name == nil and COLOR.nil_value or COLOR.player_name

	return colorize(COLOR.player_line, 'Player ') .. Colorize.value(name, value_color) .. colorize(COLOR.player_line, ':')
end

--- @param name string
--- @param value string|number|boolean|nil
--- @param color string|nil
--- @return string
function Colorize.property(name, value, color)
	return colorize(COLOR.property_name, name) .. ': ' .. Colorize.value(value, color)
end


return Colorize
