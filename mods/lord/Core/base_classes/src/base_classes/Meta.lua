local BaseMeta  = require('base_classes.Meta.Base')
local FieldType = require('base_classes.Meta.FieldType')


--- Facade for accessing and extending Meta functionality.
--- @class base_classes.Meta
local Meta      = {
	--- @type base_classes.Meta.FieldType
	FieldType = FieldType,

	--- @static
	--- @generic GenericMeta: base_classes.Meta.Base
	--- @param child_class GenericMeta
	--- @return GenericMeta
	extended = function(child_class)
		return BaseMeta:extended(child_class)
	end,
}


return Meta
