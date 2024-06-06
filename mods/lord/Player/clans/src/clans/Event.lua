
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


---- Trigger handling: ----

---@param clan clans.Clan
function Event.run_on_clan_creation_callbacks(clan)
	for _, func in ipairs(subscribers.on_clan_created) do
		func(clan)
	end
end
---@param clan clans.Clan
function Event.run_on_clan_deletion_callbacks(clan)
	for _, func in ipairs(subscribers.on_clan_deleted) do
		func(clan)
	end
end
---@param clan        clans.Clan
---@param player_name string
function Event.run_on_clan_player_adding_callbacks(clan, player_name)
	for _, func in ipairs(subscribers.on_clan_player_added) do
		func(clan, player_name)
	end
end
---@param clan        clans.Clan
---@param player_name string
function Event.run_on_clan_player_removing_callbacks(clan, player_name)
	for _, func in ipairs(subscribers.on_clan_player_removed) do
		func(clan, player_name)
	end
end


return Event
