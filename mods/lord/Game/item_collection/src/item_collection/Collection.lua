--- @class item_collection.Collection
--- @field id    string unique collection id, used as value of `_collection` field of item definition.
--- @field title string translated title, displayed in item tooltip.
--- @field color string color of the title in item tooltip.
local Collection = {
	--- @static
	--- @type string
	DEFAULT_COLOR = '#99c',
}

--- @param id    string
--- @param title string
--- @param color string|nil
--- @return item_collection.Collection
function Collection:new(id, title, color)
	local class = self

	self = {
		id    = id,
		title = title,
		color = color or Collection.DEFAULT_COLOR,
	}

	return setmetatable(self, { __index = class })
end


return Collection
