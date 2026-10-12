local items,                 colorize
    = core.registered_items, core.colorize


--- @param item_string string
--- @return string|nil
return function(item_string)
	local id = items[item_string]._collection
	if not id then return nil end

	local collection = item_collection.get(id)
	if not collection then
		core.log('warning', 'Unknown collection `' .. id .. '` in `_collection` of `' .. item_string .. '`.')

		return nil
	end

	return '\n' .. colorize(collection.color, collection.title)
end
