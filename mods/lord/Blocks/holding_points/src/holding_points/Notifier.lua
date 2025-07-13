local S        = minetest.get_mod_translator()
local colorize = minetest.colorize

--- @static Singleton
--- @class holding_points.Notifier
local Notifier = {
	--- @type holding_points.config.Notifier.Colors
	color   = nil,
	--- @type string[]
	war_cry = {},
}
local self = Notifier

--- @param config holding_points.config.Notifier
function Notifier.init(config)
	self.color   = config.colors
	self.war_cry = config.war_cry
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

--- @private
--- @param points holding_points.HoldingPoint[]
--- @return string
function Notifier.activated_points_ul(points)
	local color = self.color

	local points_li = {}
	for _, point in pairs(points) do
		points_li[#points_li + 1] =
			colorize(color.POINT, '«' .. point:get_name() .. '»') .. ' ' ..
			colorize(color.POSITION, point:get_id())
	end

	return #points_li
		and ('  • ' .. table.concat(points_li, '\n  • '))
		or  ''
end

--- @private
--- @return string
function Notifier.random_war_cry()
	return self.war_cry[math.random(#self.war_cry)]
end

--- @param battle holding_points.Battle         The battle that started.
--- @param points holding_points.HoldingPoint[] Activated Points.
function Notifier.on_battle_started(battle, points)
	local color = self.color

	minetest.chat_send_all(
		'\n ' ..
		colorize(color.EVENT, ('#%s: '):format(S('Events'))) ..
			S('Battle @1 started! 🚀', colorize(color.BATTLE, '«' .. battle.title .. '»')) .. '\n' ..
		self.activated_points_ul(points) .. '\n \n' ..
		' ' .. colorize(color.WAR_CRY, self.random_war_cry()) .. '\n' ..
		'\n '
	)
end

--- @private
--- @param battle holding_points.Battle The battle that stopped.
--- @return string
function Notifier.battle_results(battle)
	local color = self.color

	local points_li = {}
	for _, point in pairs(battle.points) do
		local clan = clans.clan_get_by_name(point:get_captured_by_clan())

		points_li[#points_li + 1] = S(
			'Point @1 — conquered by clan @2',
			colorize(color.POINT, '«' .. point:get_name() .. '»'),
			colorize(clans.COLOR, '«' .. (clan and clan.title or '???') .. '»')
		)
	end

	return #points_li
		and ('  • ' .. table.concat(points_li, '\n  • '))
		or  ''
end

--- @param battle holding_points.Battle The battle that stopped.
function Notifier.on_battle_stopped(battle)
	local color = self.color

	minetest.chat_send_all(
		'\n ' ..
		colorize(color.EVENT, ('#%s: '):format(S('Events'))) ..
			S('Battle @1 finished!', colorize(color.BATTLE, '«' .. battle.title .. '»')) .. '\n' ..
			self.battle_results(battle) .. '\n '
	)
end

--- @param point holding_points.HoldingPoint The point that was captured.
--- @param clan  clans.Clan
function Notifier.on_point_captured(point, clan)
	local color = self.color

	minetest.chat_send_all(
		colorize(color.EVENT, ('#%s: '):format(S('Events'))) ..
		S(
			'Point @1 captured by clan @2',
			colorize(color.POINT, '«' .. point:get_name() .. '»'),
			colorize(clans.COLOR, '«' .. clan.title .. '»')
		)
	)
end


return Notifier
