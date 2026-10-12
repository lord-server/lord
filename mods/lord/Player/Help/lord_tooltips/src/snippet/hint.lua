local items,                 colorize
    = core.registered_items, core.colorize


local HINT_COLOR = '#a98'


--- @param item_string string
--- @return string|nil
return function(item_string)
	local hint = items[item_string]._hint
	if not hint or hint == '' then return nil end

	return '\n' .. colorize(HINT_COLOR, hint)
end
