local pairs
	= pairs


--- @static
--- @class clans.Event
local Event = {} -- namespace

--- @class clans.Event.Type
Event.Type = {
	on_clan_created        = "on_clan_created",
	on_clan_deleted        = "on_clan_deleted",
	on_clan_player_added   = "on_clan_player_added",
	on_clan_player_removed = "on_clan_player_removed",
}

--- @alias clans.callbacks.OnClanOperation fun(clan:clans.Clan)
--- @alias clans.callbacks.OnClanPlayerOperation fun(clan:clans.Clan, player_name:string)
--- @alias clans.callback clans.callbacks.OnClanOperation|clans.callbacks.OnClanPlayerOperation

local subscribers = {
	---@type clans.callbacks.OnClanOperation[]
	on_clan_created = {},
	---@type clans.callbacks.OnClanOperation[]
	on_clan_deleted = {},
	---@type clans.callbacks.OnClanPlayerOperation[]
	on_clan_player_added = {},
	---@type clans.callbacks.OnClanPlayerOperation[]
	on_clan_player_removed = {},
}

--- @param event string name of event (One of `clans.Event.Type::<const>`)
---
--- @return fun(callback:clans.callback)
function Event.on(event)
	return function(callback)
		Event.subscribe(event, callback)
	end
end

--- @param event    string name of event (One of `clans.Event.Type::<const>`)
--- @param callback clans.callback
function Event.subscribe(event, callback)
	assert(Event.Type[event], "Unknown clans.Event.Type: " .. event)
	assert(type(callback) == "function")

	table.insert(subscribers[event], callback)
end


function Event.notify(event, ...)
	for _, func in pairs(subscribers[event]) do
		func(...)
	end
end

---@param clan clans.Clan
function Event.run_on_clan_creation_callbacks(clan)
	Event.notify(Event.Type.on_clan_created, clan)
end
---@param clan clans.Clan
function Event.run_on_clan_deletion_callbacks(clan)
	Event.notify(Event.Type.on_clan_deleted, clan)
end
---@param clan        clans.Clan
---@param player_name string
function Event.run_on_clan_player_adding_callbacks(clan, player_name)
	Event.notify(Event.Type.on_clan_player_added, clan, player_name)
end
---@param clan        clans.Clan
---@param player_name string
function Event.run_on_clan_player_removing_callbacks(clan, player_name)
	Event.notify(Event.Type.on_clan_player_removed, clan, player_name)
end


return Event
