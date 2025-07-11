local S = minetest.get_mod_translator()


--- @static Singleton
--- @class holding_points.Notifier
local Notifier = {}
local self = Notifier

function Notifier.init()
	holding_points.on_battle_upcoming(self.on_battle_upcoming)
	holding_points.on_battle_started(self.on_battle_started)
	holding_points.on_battle_stopped(self.on_battle_stopped)
	holding_points.on_point_captured(self.on_point_captured)
end

--- @param battle  holding_points.Battle The battle that is upcoming.
--- @param minutes number                Minutes until battle starts.
function Notifier.on_battle_upcoming(battle, minutes)
	minetest.chat_send_all(S('Time left until the battle `@1` starts: @2 minutes', battle.title, minutes))
end

--- @param battle holding_points.Battle The battle that started.
function Notifier.on_battle_started(battle)
	minetest.chat_send_all(S('Battle `@1` started', battle.title))
end

--- @param battle holding_points.Battle The battle that stopped.
function Notifier.on_battle_stopped(battle)
	minetest.chat_send_all(S('Battle `@1` finished', battle.title))
end

--- @param point holding_points.HoldingPoint The point that was captured.
--- @param clan  clans.Clan
function Notifier.on_point_captured(point, clan)
	minetest.chat_send_all(S('Point "@1" captured by clan "@2"!', point:ti(), clan.title))
end



return Notifier
