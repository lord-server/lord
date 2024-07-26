--- @alias clans.callbacks.OnClanOperation fun(clan:clans.Clan)
--- @alias clans.callbacks.OnClanPlayerOperation fun(clan:clans.Clan, player_name:string)
--- @alias clans.callback clans.callbacks.OnClanOperation|clans.callbacks.OnClanPlayerOperation


--- @static
--- @class clans.Event: base_classes.Event
local Event = base_classes.Event:extended()

--- @class clans.Event.Type
Event.Type = {
	on_clan_created        = "on_clan_created",
	on_clan_deleted        = "on_clan_deleted",
	on_clan_blocked        = "on_clan_blocked",
	on_clan_unblocked      = "on_clan_unblocked",
	on_clan_player_added   = "on_clan_player_added",
	on_clan_player_removed = "on_clan_player_removed",
	on_clan_player_join    = "on_clan_player_join",
	on_clan_player_leave   = "on_clan_player_leave",
}
--- @type table<string,clans.callback[]>
Event.subscribers = {
	---@type clans.callbacks.OnClanOperation[]
	on_clan_created = {},
	---@type clans.callbacks.OnClanOperation[]
	on_clan_deleted = {},
	---@type clans.callbacks.OnClanOperation[]
	on_clan_blocked = {},
	---@type clans.callbacks.OnClanOperation[]
	on_clan_unblocked = {},
	---@type clans.callbacks.OnClanPlayerOperation[]
	on_clan_player_added = {},
	---@type clans.callbacks.OnClanPlayerOperation[]
	on_clan_player_removed = {},
	---@type clans.callbacks.OnClanPlayerOperation[]
	on_clan_player_join = {},
	---@type clans.callbacks.OnClanPlayerOperation[]
	on_clan_player_leave = {},
}


return Event
