local items,                 colorize
    = core.registered_items, core.colorize


--- @param item_string string
--- @return string|nil
return function(item_string)
	local annotation = items[item_string]._annotation
	if not annotation or annotation == '' then return nil end

	return '\n' .. colorize('#aaa', annotation)
end
