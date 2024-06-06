local callbacks = {} -- namespace


---@alias OnClanCreationCallback fun(clan:clans.Clan)

---@type OnClanCreationCallback[]
local on_clan_create_callbacks = {}

---@param func OnClanCreationCallback
function callbacks.on_clan_created(func)
	table.insert(on_clan_create_callbacks, func)
end

---@param clan clans.Clan
function callbacks.run_on_clan_creation_callbacks(clan)
	for _, func in ipairs(on_clan_create_callbacks) do
		func(clan)
	end
end


---@alias OnClanDeletionCallback fun(clan:clans.Clan)

---@type OnClanDeletionCallback[]
local on_clan_deletion_callbacks = {}

---@param func OnClanDeletionCallback
function callbacks.on_clan_deleted(func)
	table.insert(on_clan_deletion_callbacks, func)
end

---@param clan clans.Clan
function callbacks.run_on_clan_deletion_callbacks(clan)
	for _, func in ipairs(on_clan_deletion_callbacks) do
		func(clan)
	end
end


---@alias OnClanPlayerAddingCallback fun(clan:clans.Clan, player_name:string)

---@type OnClanPlayerAddingCallback[]
local on_clan_player_adding_callbacks = {}

---@param func OnClanPlayerAddingCallback
function callbacks.on_clan_player_added(func)
	table.insert(on_clan_player_adding_callbacks, func)
end

---@param clan        clans.Clan
---@param player_name string
function callbacks.run_on_clan_player_adding_callbacks(clan, player_name)
	for _, func in ipairs(on_clan_player_adding_callbacks) do
		func(clan, player_name)
	end
end


---@alias OnClanPlayerRemovingCallback fun(clan:clans.Clan, player_name:string)

---@type OnClanPlayerRemovingCallback[]
local on_clan_player_removing_callbacks = {}

---@param func OnClanPlayerRemovingCallback
function callbacks.on_clan_player_removed(func)
	table.insert(on_clan_player_removing_callbacks, func)
end

---@param clan        clans.Clan
---@param player_name string
function callbacks.run_on_clan_player_removing_callbacks(clan, player_name)
	for _, func in ipairs(on_clan_player_removing_callbacks) do
		func(clan, player_name)
	end
end

return callbacks
