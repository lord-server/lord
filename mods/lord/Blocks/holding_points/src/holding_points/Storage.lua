local Battle       = require('holding_points.Battle')
local HoldingPoint = require('holding_points.HoldingPoint')
local Schedule     = require('holding_points.Battle.Schedule')

local FieldType = base_classes.Meta.FieldType


--- @class holding_points.Storage.ScheduleData
--- @field days number[] Дни недели (1=пн,.. 7=вс)
--- @field time string   time in "HH:MM" format
--- @field week {every:number,offset:number}|nil which weeks to choose. Ex: `{ every = 2, offset = 1 }` - odd week.

--- @class holding_points.Storage.BattleData
--- @field name      string                               unique tech name (ID)
--- @field title     string                               human-readable title for battle
--- @field points    Position[]                           points positions in world
--- @field duration  number                               duration of battle in minutes
--- @field schedules holding_points.Storage.ScheduleData[] array of schedules

--- @class holding_points.Storage: base_classes.Meta.Base
--- @field battles holding_points.Storage.BattleData[]
local Storage = base_classes.Meta.extended({
	--- @type StorageRef
	meta       = nil,
	--- @type table<string,string> key - name of field, value - field-type (one of base_classes.Meta.FieldType::<CONST>)
	field_type = {
		battles = FieldType.TABLE
	},
})

--- @private
--- @param positions Position[]
--- @return holding_points.HoldingPoint[]
function Storage:points_from_positions(positions)
	local points = {}
	for _, position in pairs(positions) do
		local point = HoldingPoint:new(position)
		points[point:get_id()] = point
	end

	return points
end

--- @private
--- @param points holding_points.HoldingPoint[]
--- @return Position[]
function Storage:points_to_positions(points)
	local positions = {}
	for _, point in pairs(points) do
		positions[#positions + 1] = point.position
	end

	return positions
end

--- @private
--- @param schedules_data holding_points.Storage.ScheduleData[]
--- @return holding_points.Battle.Schedule[]
function Storage:schedules_from_data(schedules_data)
	local schedules = {}
	for _, data in pairs(schedules_data) do
		schedules[#schedules + 1] = Schedule:from_data(data)
	end

	return schedules
end

--- @private
--- @param schedules holding_points.Battle.Schedule[]
--- @return holding_points.Storage.ScheduleData[]
function Storage:schedules_to_data(schedules)
	local schedules_data = {}
	for _, schedule in pairs(schedules) do
		schedules_data[#schedules_data + 1] = schedule:to_data()
	end

	return schedules_data
end


--- @return holding_points.Battle[]
function Storage:load_battles()
	local stored_battles = self.battles
	if not stored_battles then
		return {}
	end

	local battles = {}
	for _, battle in pairs(stored_battles) do
		battles[#battles + 1] = Battle:new(
			battle.name,
			battle.title,
			self:points_from_positions(battle.points or {}),
			battle.duration,
			self:schedules_from_data(battle.schedules or {})
		)
	end

	return battles
end

--- @param battles holding_points.Battle[]
function Storage:save_battles(battles)
	--- @type holding_points.Storage.BattleData[]
	local battles_to_store = {}

	for _, battle in pairs(battles) do
		battles_to_store[#battles_to_store + 1] = {
			name      = battle.name,
			title     = battle.title,
			points    = self:points_to_positions(battle.points),
			duration  = battle.duration,
			schedules = self:schedules_to_data(battle.schedules),
		}
	end

	self.battles = battles_to_store
end



return Storage
