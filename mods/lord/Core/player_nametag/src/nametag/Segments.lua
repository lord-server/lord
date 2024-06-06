
--- @class nametag.Segments.definition
--- @field color  string|nil
--- @field value  string|nametag.NameTag.Segment.value_getter
--- @field format string|nil

--- @type table<string,nametag.Segments.definition>
local definitions_collection = {}

--- @static
--- @class nametag.Segments
local Segments   = {}

--- @overload fun(name:string)
--- @overload fun(name:string,default_color:string)
--- @overload fun(name:string,default_color:string,value_format:string)
--- @param name          string        technical name of nametag segment.
--- @param default_color string|nil    default color for segment until you override for the player.
--- @param value_format  string|nil    segment template in format as for `string.format()` function.
--- @param default_value string|nametag.NameTag.Segment.value_getter|nil default value for segment.
function Segments.add(name, default_color, value_format, default_value)
	definitions_collection[name] = {
		color  = default_color,
		value  = default_value,
		format = value_format,
	}
end

--- @return table<string,nametag.Segments.definition>|nametag.Segments.definition[]
function Segments.list()
	return definitions_collection
end

--- @return boolean
function Segments.exists(name)
	return definitions_collection[name] ~= nil
end


return Segments
