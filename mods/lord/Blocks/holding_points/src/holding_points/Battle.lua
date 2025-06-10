--- @class holding_points.Battle.Schedule
--- @field days number[] Дни недели (1=пн, 7=вс)
--- @field time string   time in "HH:MM" format
--- @field week {every:number,offset:number}|nil which weeks to choose. Ex: `{ every = 2, offset = 1 }` - odd week.

--- @class holding_points.Battle
local Battle = {
	--- @type string unique tech name (ID)
	name      = nil,
	--- @type string human-readable title for battle
	title     = nil,
	--- @type holding_points.HoldingPoint[]|table<string,holding_points.HoldingPoint>
	points    = nil,
	--- @type number duration of battle in minutes
	duration  = nil,
	--- @type holding_points.Battle.Schedule[] array of schedules
	schedules = nil,
}

--- @return holding_points.Battle
function Battle:new(name, title, points, duration, schedules)
	self = setmetatable({}, { __index = self })
	self.name      = name
	self.title     = title
	self.points    = points
	self.duration  = duration
	self.schedules = schedules

	return self
end

--- @return holding_points.Battle
function Battle:activate()
	for id, point in pairs(self.points) do
		point:activate()
	end

	return self
end

--- @return holding_points.Battle
function Battle:deactivate()
	for id, point in pairs(self.points) do
		point:activate()
	end

	return self
end


return Battle
