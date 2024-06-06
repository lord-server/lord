
--- @static
--- @class clans.Event
local Event       = {} -- namespace


---@alias clans.callbacks.OnClanCreated fun(clan:clans.Clan)
---@alias clans.callbacks.OnClanDeleted fun(clan:clans.Clan)
---@alias clans.callbacks.OnClanPlayerAdded fun(clan:clans.Clan, player_name:string)
---@alias clans.callbacks.OnClanPlayerRemoved fun(clan:clans.Clan, player_name:string)


local subscribers = {
	---@type clans.callbacks.OnClanCreated[]
	on_clan_created = {},
	---@type clans.callbacks.OnClanDeleted[]
	on_clan_deleted = {},
	---@type clans.callbacks.OnClanPlayerAdded[]
	on_clan_player_added = {},
	---@type clans.callbacks.OnClanPlayerRemoved[]
	on_clan_player_removed = {},
}


---- Subscribing: ----

---@param func clans.callbacks.OnClanCreated
function Event.on_clan_created(func)
	table.insert(subscribers.on_clan_created, func)
end
---@param func clans.callbacks.OnClanDeleted
function Event.on_clan_deleted(func)
	table.insert(subscribers.on_clan_deleted, func)
end
---@param func clans.callbacks.OnClanPlayerAdded
function Event.on_clan_player_added(func)
	table.insert(subscribers.on_clan_player_added, func)
end
---@param func clans.callbacks.OnClanPlayerRemoved
function Event.on_clan_player_removed(func)
	table.insert(subscribers.on_clan_player_removed, func)
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
