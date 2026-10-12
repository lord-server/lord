--- @class item_collection.Registry
local Registry = {
	--- @static
	--- @type table<string, item_collection.Collection>
	all = {},
}

--- @static
--- @param collection item_collection.Collection
function Registry.add(collection)
	assert(not Registry.all[collection.id], 'Collection `' .. collection.id .. '` is already registered.')

	Registry.all[collection.id] = collection
end

--- @static
--- @param id string
--- @return item_collection.Collection|nil
function Registry.get(id)
	return Registry.all[id]
end


return Registry
