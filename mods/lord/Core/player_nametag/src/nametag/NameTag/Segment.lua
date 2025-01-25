local setmetatable
	= setmetatable

--- @alias nametag.NameTag.Segment.value_getter fun(segment:nametag.NameTag.Segment):string

--- @class nametag.NameTag.Segment
local Segment = {
	--- @type nametag.NameTag
	name_tag = nil,
	--- @type string|nametag.NameTag.Segment.value_getter
	value    = nil,
	--- @type string|nil
	color    = nil,
	--- @type string|nil
	format   = nil
}

--- @param definition nametag.Segments.definition
--- @param name_tag   nametag.NameTag
---
--- @return nametag.NameTag.Segment
function Segment:new(definition, name_tag)
	local class = table.copy(self)
	self = {}

	self.name_tag = name_tag

	return setmetatable(self, { __index = setmetatable(class, { __index = definition }) })
end

--- @param color string override color for this segment of NameTag. Default sets by `nametag.segments.add()`
---
--- @return nametag.NameTag.Segment
function Segment:set_color(color)
	self.color = color

	return self
end

--- You can use `minetest.colorize()` for parts of your value.
--- Also yuu can use callback function for calculate your value.
--- @param value string|nametag.NameTag.Segment.value_getter that will be displayed in this segment of NameTag.
--- @param color string|nil override color for this segment of NameTag. Default sets by `nametag.segments.add()`
---
--- @return nametag.NameTag.Segment
function Segment:set_value(value, color)
	self.value = value
	self.color = color

	return self
end

--- @return string
function Segment:get_value()
	return type(self.value) == "function"
		and self.value(self)
		or  self.value
end

--- Returns built segment text ready for display.
--- Applies color and template (`string.format()`).
--- @return string
function Segment:build()
	local value = self:get_value()
	if not value then return "" end

	local displayed_value = self.format
		and string.format(self.format, value)
		or  value

	return self.color
		and minetest.colorize(self.color, displayed_value)
		or  displayed_value
end

--- Updates displaying name-tag
--- @overload fun()
--- @overload fun(value:string|nametag.NameTag.Segment.value_getter)
--- @param value string that will be displayed in this segment of NameTag. You can use `minetest.colorize()` for parts.
--- @param color string override color for this segment of NameTag. Default sets by `nametag.segments.add()`
function Segment:update(value, color)
	if value then self:set_value(value, color) end

	self.name_tag:force_refresh()
end


return Segment
