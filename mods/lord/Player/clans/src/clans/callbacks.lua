local callbacks = {} -- namespace


---@alias OnClanCreationCallback fun(clan:clans.Clan)
---@alias OnClanDeletionCallback fun(clan:clans.Clan)
---@alias OnClanPlayerAddingCallback fun(clan:clans.Clan, player_name:string)
---@alias OnClanPlayerRemovingCallback fun(clan:clans.Clan, player_name:string)


local subscribers = {}
---@type OnClanCreationCallback[]
subscribers.on_clan_created = {}
---@type OnClanDeletionCallback[]
subscribers.on_clan_deleted = {}
---@type OnClanPlayerAddingCallback[]
subscribers.on_clan_player_added = {}
---@type OnClanPlayerRemovingCallback[]
subscribers.on_clan_player_removed = {}


---- Subscribing: ----

---@param func OnClanCreationCallback
function callbacks.on_clan_created(func)
	table.insert(subscribers.on_clan_created, func)
end
---@param func OnClanDeletionCallback
function callbacks.on_clan_deleted(func)
	table.insert(subscribers.on_clan_deleted, func)
end
---@param func OnClanPlayerAddingCallback
function callbacks.on_clan_player_added(func)
	table.insert(subscribers.on_clan_player_added, func)
end
---@param func OnClanPlayerRemovingCallback
function callbacks.on_clan_player_removed(func)
	table.insert(subscribers.on_clan_player_removed, func)
end


---- Trigger handling: ----

---@param clan clans.Clan
function callbacks.run_on_clan_creation_callbacks(clan)
	for _, func in ipairs(subscribers.on_clan_created) do
		func(clan)
	end
end
---@param clan clans.Clan
function callbacks.run_on_clan_deletion_callbacks(clan)
	for _, func in ipairs(subscribers.on_clan_deleted) do
		func(clan)
	end
end
---@param clan        clans.Clan
---@param player_name string
function callbacks.run_on_clan_player_adding_callbacks(clan, player_name)
	for _, func in ipairs(subscribers.on_clan_player_added) do
		func(clan, player_name)
	end
end
---@param clan        clans.Clan
---@param player_name string
function callbacks.run_on_clan_player_removing_callbacks(clan, player_name)
	for _, func in ipairs(subscribers.on_clan_player_removed) do
		func(clan, player_name)
	end
end


return callbacks
