--- @alias holding_points.callbacks.OnBattleUpcoming fun(battle:holding_points.Battle, minutes:number)
--- @alias holding_points.callbacks.OnBattleStarted  fun(battle:holding_points.Battle)
--- @alias holding_points.callbacks.OnBattleStopped  fun(battle:holding_points.Battle)
--- @alias holding_points.callbacks.OnPointCaptured  fun(point:holding_points.HoldingPoint, clan:clans.Clan)


--- @class holding_points.Event: base_classes.Event
local Event = base_classes.Event:extended()

--- @class holding_points.Event.Type
Event.Type = {
	on_battle_upcoming = 'on_battle_upcoming',
	on_battle_started  = 'on_battle_started',
	on_battle_stopped  = 'on_battle_stopped',
	on_point_captured  = 'on_point_captured',
}

Event.subscribers = {
	---@type holding_points.callbacks.OnBattleUpcoming[]
	[Event.Type.on_battle_upcoming] = {},
	---@type holding_points.callbacks.OnBattleStarted[]
	[Event.Type.on_battle_started]  = {},
	---@type holding_points.callbacks.OnBattleStopped[]
	[Event.Type.on_battle_stopped]  = {},
	---@type holding_points.callbacks.OnPointCaptured[]
	[Event.Type.on_point_captured]  = {},
}


return Event
