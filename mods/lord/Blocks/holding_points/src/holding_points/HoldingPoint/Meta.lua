local FieldType = base_classes.Meta.FieldType


--- @class holding_points.HoldingPoint.Meta: base_classes.Meta.Base
--- @field name              string
--- @field in_event_list     boolean
--- @field active            boolean
--- @field last_activated_at number
--- @field captured_by_clan  string
--- @field captured_at       number
--- @field reward_given_at   number
--- @field battle_stat       table<string,number>
local Meta = base_classes.Meta.extended({
	--- @protected
	--- @type NodeMetaRef
	meta = nil,
	--- @protected
	--- @type table<string,string> key - name of field, value - field-type (one of base_classes.Meta.FieldType::<CONST>)
	field_type = {
		name              = FieldType.STRING,
		in_event_list     = FieldType.BOOLEAN,
		active            = FieldType.BOOLEAN,
		last_activated_at = FieldType.INTEGER,
		captured_by_clan  = FieldType.STRING,
		captured_at		  = FieldType.INTEGER,
		reward_given_at   = FieldType.INTEGER,
		battle_stat       = FieldType.TABLE,
	}
})


return Meta
