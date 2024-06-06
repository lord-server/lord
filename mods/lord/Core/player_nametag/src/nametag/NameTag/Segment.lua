local setmetatable
	= setmetatable


--- @class nametag.NameTag.Segment
local Segment = {
	--- @type nametag.NameTag
	name_tag = nil,
	--- @type string
	value = "",
	--- @type string|nil
	color = nil,
}

--- @param definition nametag.Segments.definition
--- @param name_tag   nametag.NameTag
---
--- @return nametag.NameTag.Segment
function Segment:new(definition, name_tag)
	local class = self
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

--- @param text  string that will be displayed in this segment of NameTag. You can use `minetest.colorize()` for parts.
--- @param color string override color for this segment of NameTag. Default sets by `nametag.segments.add()`
---
--- @return nametag.NameTag.Segment
function Segment:set_value(text, color)
	self.value = text
	self.color = color

	return self
end

--- Updates displaying name-tag
--- @overload fun()
--- @overload fun(text:string)
--- @param text  string that will be displayed in this segment of NameTag. You can use `minetest.colorize()` for parts.
--- @param color string override color for this segment of NameTag. Default sets by `nametag.segments.add()`
function Segment:update(text, color)
	if text then self.set_value(text, color) end

	self.name_tag:force_refresh()
end


return Segment
