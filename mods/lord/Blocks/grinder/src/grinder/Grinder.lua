local SL           = minetest.get_mod_translator()
local form         = require('grinder.definition.node.form')

--- @type string
local machine_name = "Grinder"

---
--- @class Grinder
---
local Grinder      = {
	--- @type table<number,number,number>
	position = nil,
	--- @type NodeMetaRef
	meta     = nil
}

--- Constructor
--- @public
--- @param pos table<number,number,number>
--- @return Grinder
function Grinder:new(pos)
	local class = self
	self = {}

	self.position = pos
	self.meta     = nil

	return setmetatable(self, { __index = class })
end

-- -----------------------------------------------------------------------------------------------
-- Private functions:

--- @private
--- @param pos table<number,number,number>
--- @return NodeMetaRef
local function get_initiated_meta(pos)
	local meta = minetest.get_meta(pos)
	for _, name in pairs({
		"fuel_totaltime",
		"fuel_time",
		"src_totaltime",
		"src_time"
	}) do
		if not meta:get_float(name) then
			meta:set_float(name, 0.0)
		end
	end
	return meta
end

--- @param meta NodeMetaRef
local function reset_meta_vars(meta)
	for _, name in pairs({
		"fuel_totaltime",
		"fuel_time",
		"src_totaltime",
		"src_time"
	}) do
		meta:set_float(name, 0.0)
	end
end

--- Swaps node if node is not same and return old node name.
--- @see minetest.swap_node (https://dev.minetest.net/minetest.swap_node)
---
--- @private
--- @param pos table {x,y,z}
--- @param name string
--- @return string
local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name ~= name then
		node.name = name
		minetest.swap_node(pos, node)
	end
	return node.name
end

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- @public
--- @return NodeMetaRef
function Grinder:get_meta()
	return self.meta or get_initiated_meta(self.position)
end

--- Sets Node into active grinder with new hint.
--- @public
--- @param hint_en string A template for hinting in English. Use "%s" for machine name placeholder.
function Grinder:activate(hint_en)
	local meta         = self:get_meta()
	local percent      = math.floor(meta:get_float("fuel_time") / meta:get_float("fuel_totaltime") * 100)
	local item_percent = math.floor(meta:get_float("src_time") / meta:get_float("src_totaltime") * 100)
	swap_node(self.position, "grinder:grinder_active")
	self:get_meta():set_string("infotext", SL((hint_en):format(machine_name)) .. " (" .. percent .. "%)")
	self:get_meta():set_string("formspec", form.get('active', percent, item_percent))
end

--- Sets Node into inactive grinder with new hint.
--- @public
--- @param hint_en string A template for hinting in English. Use "%s" for machine name placeholder.
function Grinder:deactivate(hint_en)
	reset_meta_vars(self:get_meta())
	swap_node(self.position, "grinder:grinder")
	self:get_meta():set_string("infotext", SL((hint_en):format(machine_name)))
	self:get_meta():set_string("formspec", form.get('inactive'))
end

return Grinder
