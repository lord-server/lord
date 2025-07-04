local S = minetest.get_mod_translator()

local WEEKDAY_NAME_SHORT = {
	[1] = S('mon'),
	[2] = S('tue'),
	[3] = S('wed'),
	[4] = S('thu'),
	[5] = S('fri'),
	[6] = S('sat'),
	[7] = S('sun'),
}


--- @class holding_points.Battle.Schedule
local Schedule = {
	--- @type number[] array of days of week (1=mon). Дни недели (1=пн, 7=вс).
	days = nil,
	--- @type string   time in `"HH:MM"` format.
	time = nil,
	--- @type {every:number,offset:number}|nil which weeks to choose. Ex: `{ every = 2, offset = 1 }` - odd week.
	week = nil,
	--- @type number[] default `days` param for new Schedule.
	DEFAULT_DAYS = { 7 },
	--- @type string default `time` param for new Schedule. Format: `"HH:MM"`
	DEFAULT_TIME = '14:00',
}

--- @param days number[]|nil                     default: `[7]`; array of days of week (1=mon). Дни недели (1=пн, 7=вс).
--- @param time string|nil                       default: `"14:00"; time in `"HH:MM"` format.
--- @param week {every:number,offset:number}|nil which weeks to choose. Ex: `{ every = 2, offset = 1 }` - odd week.
--- @return holding_points.Battle.Schedule
function Schedule:new(days, time, week)
	self = setmetatable({}, { __index = self })
	self.days = days or Schedule.DEFAULT_DAYS
	self.time = time or Schedule.DEFAULT_TIME
	self.week = week or {}

	return self
end

--- @param data holding_points.Storage.ScheduleData
--- @return holding_points.Battle.Schedule
function Schedule:from_data(data)
	return self:new(data.days, data.time, data.week)
end

--- @return holding_points.Storage.ScheduleData
function Schedule:to_data()
	--- @type holding_points.Storage.ScheduleData
	local data = {
		days = self.days,
		time = self.time,
		week = self.week,
	}

	return data
end

--- @return string
function Schedule:get_days_string()
	table.sort(self.days)
	local str = ''

	local i = 1
	while i <= #self.days do
		local start  = self.days[i]
		local finish = start
		while i < #self.days and self.days[i + 1] == finish + 1 do
			finish = self.days[i + 1]
			i = i + 1
		end

		str = str
			.. (#str > 0 and str .. ',' or '')
			.. (start == finish
				and WEEKDAY_NAME_SHORT[start]
				or WEEKDAY_NAME_SHORT[start] .. '-' .. WEEKDAY_NAME_SHORT[finish]
			)

		i = i + 1
	end

	return str
end

--- @return string
function Schedule:get_week_string()
	if not (self.week and self.week.every and self.week.every > 1) then
		return ''
	end

	return self.week.every == 2
		and
			S('@1 week', self.week.offset == 1 and S('odd') or S('even'))
		or
			self.week.offset .. '/' .. self.week.every .. ' ' .. S('week')
end

--- @return string
function Schedule:to_string()
	local days_str = self:get_days_string()
	local week_str = self:get_week_string()

	return ''
		.. (days_str or '--') .. '; '
		.. self.time
		.. (week_str and ' (' .. week_str .. ')' or '')
end


return Schedule
