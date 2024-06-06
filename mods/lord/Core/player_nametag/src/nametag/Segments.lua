
--- @class nametag.Segments.definition
--- @field color
--- @field default_value

--- @type table<string,nametag.Segments.definition>
local definitions_collection = {}

--- @static
--- @class nametag.Segments
local Segments   = {}

--- @overload fun(name:string)
--- @overload fun(name:string,default_color:string)
--- @param name          string     technical name of nametag segment.
--- @param default_color string|nil default color for segment until you override for the player.
--- @param default_value string|nil default
function Segments.add(name, default_color, default_value)
	definitions_collection[name] = {
		color = default_color,
		value = default_value,
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
