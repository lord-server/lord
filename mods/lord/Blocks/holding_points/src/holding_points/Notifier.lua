local S        = minetest.get_mod_translator()
local colorize = minetest.colorize

--- @static Singleton
--- @class holding_points.Notifier
local Notifier = {
	--- @type holding_points.config.Notifier.Colors
	color = nil,
}
local self = Notifier

--- @param config holding_points.config.Notifier
function Notifier.init(config)
	self.color = config.colors
	holding_points.on_battle_upcoming(self.on_battle_upcoming)
	holding_points.on_battle_started(self.on_battle_started)
	holding_points.on_battle_stopped(self.on_battle_stopped)
	holding_points.on_point_captured(self.on_point_captured)
end

--- @param battle  holding_points.Battle The battle that is upcoming.
--- @param minutes number                Minutes until battle starts.
function Notifier.on_battle_upcoming(battle, minutes)
	local color = self.color

	minetest.chat_send_all(
		'\n ' ..
		colorize(color.EVENT, ('#%s: '):format(S('Events'))) ..
		S(
			'Battle @1 will start in @2 minutes',
			colorize(color.BATTLE, '«' .. battle.title .. '»'),
			colorize(color.BATTLE, minutes)
		) ..
		'\n '
	)
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
	-- TODO: in LG-1923: use `point:get_title()`
	minetest.chat_send_all(S('Point "@1" captured by clan "@2"!', point:get_name(), clan.title))
end



return Notifier
