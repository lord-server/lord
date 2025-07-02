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


return Storage
