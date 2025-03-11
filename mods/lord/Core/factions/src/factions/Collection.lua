
--- @class factions.Collection
local Collection = {
	--- @private
	--- @type table<string,factions.Faction> items of collection. (List of registered factions)
	items = {},
}

--- @static
--- @param faction factions.Faction
function Collection.add(faction)
	Collection.items[faction.name] = faction
end

--- @static
--- @param name string faction name
--- @return factions.Faction
function Collection.get(name)
	return Collection.items[name]
end

--- @static
--- @return table<string,factions.Faction>
function Collection.all()
	return Collection.items
end


return Collection
