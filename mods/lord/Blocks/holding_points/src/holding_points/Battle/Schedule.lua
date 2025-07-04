
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


return Schedule
