local callbacks = {} -- namespace


---@alias OnClanCreationCallback fun(clan_name:string, clan_title, members:string[])

---@type OnClanCreationCallback[]
local on_clan_create_callbacks = {}

---@param func OnClanCreationCallback
function callbacks.register_on_clan_creation(func)
	table.insert(on_clan_create_callbacks, func)
end

---@param clan_name string
---@param clan_title string
---@param members string[]
function callbacks.run_on_clan_creation_callbacks(clan_name, clan_title, members)
	for _, func in ipairs(on_clan_create_callbacks) do
		func(clan_name, clan_title, members)
	end
end


---@alias OnClanDeletionCallback fun(clan_name:string)

---@type OnClanDeletionCallback[]
local on_clan_deletion_callbacks = {}

---@param func OnClanDeletionCallback
function callbacks.register_on_clan_deletion(func)
	table.insert(on_clan_deletion_callbacks, func)
end

---@param clan_name string
function callbacks.run_on_clan_deletion_callbacks(clan_name)
	for _, func in ipairs(on_clan_deletion_callbacks) do
		func(clan_name)
	end
end


---@alias OnClanPlayerAddingCallback fun(clan_name:string, player_name:string)

---@type OnClanPlayerAddingCallback[]
local on_clan_player_adding_callbacks = {}

---@param func OnClanPlayerAddingCallback
function callbacks.register_on_clan_player_adding(func)
	table.insert(on_clan_player_adding_callbacks, func)
end

---@param clan_name string
---@param player_name string
function callbacks.run_on_clan_player_adding_callbacks(clan_name, player_name)
	for _, func in ipairs(on_clan_player_adding_callbacks) do
		func(clan_name, player_name)
	end
end


---@alias OnClanPlayerRemovingCallback fun(clan_name:string, player_name:string)

---@type OnClanPlayerRemovingCallback[]
local on_clan_player_removing_callbacks = {}

---@param func OnClanPlayerRemovingCallback
function callbacks.register_on_clan_player_removing(func)
	table.insert(on_clan_player_removing_callbacks, func)
end

---@param clan_name string
---@param player_name string
function callbacks.run_on_clan_player_removing_callbacks(clan_name, player_name)
	for _, func in ipairs(on_clan_player_removing_callbacks) do
		func(clan_name, player_name)
	end
end

return callbacks
