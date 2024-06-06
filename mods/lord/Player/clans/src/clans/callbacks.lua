local callbacks = {} -- namespace


---@alias OnClanCreationCallback fun(clan:clans.Clan)
---@alias OnClanDeletionCallback fun(clan:clans.Clan)
---@alias OnClanPlayerAddingCallback fun(clan:clans.Clan, player_name:string)
---@alias OnClanPlayerRemovingCallback fun(clan:clans.Clan, player_name:string)

---@type OnClanCreationCallback[]
local on_clan_create_callbacks = {}
---@type OnClanDeletionCallback[]
local on_clan_deletion_callbacks = {}
---@type OnClanPlayerAddingCallback[]
local on_clan_player_adding_callbacks = {}
---@type OnClanPlayerRemovingCallback[]
local on_clan_player_removing_callbacks = {}


---- Subscribing: ----

---@param func OnClanCreationCallback
function callbacks.on_clan_created(func)
	table.insert(on_clan_create_callbacks, func)
end
---@param func OnClanDeletionCallback
function callbacks.on_clan_deleted(func)
	table.insert(on_clan_deletion_callbacks, func)
end
---@param func OnClanPlayerAddingCallback
function callbacks.on_clan_player_added(func)
	table.insert(on_clan_player_adding_callbacks, func)
end
---@param func OnClanPlayerRemovingCallback
function callbacks.on_clan_player_removed(func)
	table.insert(on_clan_player_removing_callbacks, func)
end


---- Trigger handling: ----

---@param clan clans.Clan
function callbacks.run_on_clan_creation_callbacks(clan)
	for _, func in ipairs(on_clan_create_callbacks) do
		func(clan)
	end
end
---@param clan clans.Clan
function callbacks.run_on_clan_deletion_callbacks(clan)
	for _, func in ipairs(on_clan_deletion_callbacks) do
		func(clan)
	end
end
---@param clan        clans.Clan
---@param player_name string
function callbacks.run_on_clan_player_adding_callbacks(clan, player_name)
	for _, func in ipairs(on_clan_player_adding_callbacks) do
		func(clan, player_name)
	end
end
---@param clan        clans.Clan
---@param player_name string
function callbacks.run_on_clan_player_removing_callbacks(clan, player_name)
	for _, func in ipairs(on_clan_player_removing_callbacks) do
		func(clan, player_name)
	end
end


return callbacks
