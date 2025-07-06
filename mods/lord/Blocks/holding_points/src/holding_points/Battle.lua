local HoldingPoint = require('holding_points.HoldingPoint')
local Schedule     = require('holding_points.Battle.Schedule')


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
	--- @type number default duration in minutes.
	DEFAULT_DURATION = 30,
}

---@param name      string
---@param title     string
---@param points    holding_points.HoldingPoint[]
---@param duration  number
---@param schedules holding_points.Battle.Schedule[]
function Battle:new(name, title, points, duration, schedules)
	self = setmetatable({}, { __index = self })
	self.name      = name
	self.title     = title or ''
	self.points    = points or {}
	self.duration  = duration or self.DEFAULT_DURATION
	self.schedules = schedules or { Schedule:new() }

	return self
end

--- @param point holding_points.HoldingPoint
--- @return holding_points.Battle
function Battle:add_point(point)
	self.points[point:get_id()] = point

	return self
end

--- @return holding_points.HoldingPoint|nil
function Battle:remove_point_by_id(id)
	local point = self.points[id]
	self.points[id] = nil

	return point
end

--- @param point holding_points.HoldingPoint
--- @return holding_points.HoldingPoint|nil
function Battle:remove_point(point)
	return self:remove_point_by_id(point:get_id())
end

--- @param position Position
--- @return holding_points.HoldingPoint|nil
function Battle:remove_point_by_position(position)
	return self:remove_point_by_id(HoldingPoint.create_id(position))
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
