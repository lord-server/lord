
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

---@param name      string
---@param title     string
---@param points    holding_points.HoldingPoint[]
---@param duration  number
---@param schedules holding_points.Battle.Schedule[]
function Battle:new(name, title, points, duration, schedules)
	self = setmetatable({}, { __index = self })
	self.name      = name
	self.title     = title
	self.points    = points
	self.duration  = duration
	self.schedules = schedules

	return self
end

--- @param schedule holding_points.Battle.Schedule
--- @return holding_points.Battle
function Battle:add_schedule(schedule)
	self.schedules[#self.schedules + 1] = schedule

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
		point:deactivate()
	end

	return self
end


return Battle
