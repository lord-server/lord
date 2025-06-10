local os_time, os_date, pairs, math_is_in_range, math_floor, tonumber
    = os.time, os.date, pairs, math.is_in_range, math.floor, tonumber

local MINUTE        = 60
local TICK          = 1 * MINUTE
local NOTIFY_BEFORE = { 30, 10, 5, 3, 1 }

--- Map for os.date format (1=sun, 2=mon, ..., 7=sat)
local WEEKDAY_MAP = {
	[1] = 2, -- mon -> 2
	[2] = 3, -- tue -> 3
	[3] = 4, -- wed -> 4
	[4] = 5, -- thu -> 5
	[5] = 6, -- fri -> 6
	[6] = 7, -- sat -> 7
	[7] = 1, -- sun -> 1
}

--- @alias holding_points.Scheduler.on_upcoming fun(battle:holding_points.Battle, minutes:number)
--- @alias holding_points.Scheduler.on_start    fun(battle:holding_points.Battle)
--- @alias holding_points.Scheduler.on_finish   fun(battle:holding_points.Battle)

--- @class holding_points.Scheduler
local Scheduler = {
	--- @type number
	tick    = TICK,
	--- @type holding_points.Battle[]
	battles = nil,
	--- @type holding_points.Scheduler.on_upcoming
	notify_upcoming = nil,
	--- @type holding_points.Scheduler.on_start
	notify_start    = nil,
	--- @type holding_points.Scheduler.on_finish
	notify_finish   = nil,
}

--- @overload fun():holding_points.Scheduler
--- @param battles holding_points.Battle[]
--- @return holding_points.Scheduler
function Scheduler:new(battles)
	self = setmetatable({}, { __index = self })
	self.battles = battles or {}

	return self
end

--- @param battles holding_points.Battle[]
--- @return holding_points.Scheduler
function Scheduler:set_battles(battles)
	self.battles = battles

	return self
end

--- @param callback holding_points.Scheduler.on_upcoming
--- @return holding_points.Scheduler
function Scheduler:on_upcoming(callback)
	self.notify_upcoming = callback

	return self
end

--- @param callback holding_points.Scheduler.on_start
--- @return holding_points.Scheduler
function Scheduler:on_start(callback)
	self.notify_start = callback

	return self
end

--- @param callback holding_points.Scheduler.on_finish
--- @return holding_points.Scheduler
function Scheduler:on_finish(callback)
	self.notify_finish = callback

	return self
end

function Scheduler:run()
	local next_tick_in = self.tick - (os_time() % self.tick)
	minetest.after(next_tick_in, self.on_tick, self)
end

--- @private
function Scheduler:on_tick()
	local now = os_time()
	      now = now - (now % MINUTE)

	self:check_all_battles(now)

	self:run()
end

--- @private
--- @param current_time number
function Scheduler:check_all_battles(current_time)
	for _, battle in pairs(self.battles) do
		self:check_battle(battle, current_time)
	end
end

--- @private
--- @param battle       holding_points.Battle
--- @param current_time number
function Scheduler:check_battle(battle, current_time)
	for _, schedule in pairs(battle.schedules) do
		if self:is_week_match(schedule.week, current_time) then
			local hour, min = self:parse_time(schedule.time)

			for _, day in pairs(schedule.days) do
				local battle_time = self:get_battle_time(day, hour, min, current_time)
				local minutes_left_until = (battle_time - current_time) / MINUTE

				if math_is_in_range(minutes_left_until, 0, 30) then
					for _, minutes in pairs(NOTIFY_BEFORE) do
						if minutes_left_until == minutes then
							self.notify_upcoming(battle, minutes)
						end
					end
				elseif minutes_left_until == 0 then
					self.notify_start(battle)
				elseif minutes_left_until == -battle.duration then
					self.notify_finish(battle)
				end
			end

		end
	end
end

--- @private
--- @param week         {every:number,offset:number}
--- @param current_time number
--- @return boolean
function Scheduler:is_week_match(week, current_time)
	if not week or week.every == 1 then
		return true
	end

	local current_date = os_date("*t", current_time)
	local year_start   = os_time({ year = current_date.year, month = 1, day = 1, hour = 0, min = 0, sec = 0})
	local week_num     = math_floor((current_time - year_start) / (7 * 86400))

	if week.offset then
		week_num = week_num - week.offset
	end

	return (week_num % week.every) == 0
end

--- @private
--- @param time_str string time in "HH:MM" format
--- @return number|nil, number|nil hour, minute
function Scheduler:parse_time(time_str)
	local parts = time_str:split(':')

	return tonumber(parts[1]), tonumber(parts[2])
end

--- @private
--- @param day          number day of week (1-7)
--- @param hour         number
--- @param min          number
--- @param current_time number
--- @return number timestamp
function Scheduler:get_battle_time(day, hour, min, current_time)
	local current_date   = os_date("*t", current_time)
	local target_wday    = WEEKDAY_MAP[day]
	local days_to_battle = (target_wday - current_date.wday) % 7

	local battle_date = {
		year  = current_date.year,
		month = current_date.month,
		day   = current_date.day + days_to_battle,
		hour  = hour,
		min   = min,
		sec   = 0
	}

	return os_time(battle_date)
end


return Scheduler
