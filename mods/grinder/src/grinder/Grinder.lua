local SL           = lord.require_intllib()

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
	self.position = pos

	return self
end

-- -----------------------------------------------------------------------------------------------
-- Private functions:

--- @private
--- @param pos table<number,number,number>
--- @return NodeMetaRef
local function getInitiatedMeta(pos)
	local meta = minetest.get_meta(pos)
	for _, name in pairs({
		"fuel_totaltime",
		"fuel_time",
		"src_totaltime",
		"src_time" }) do
		-- init with 0.0 if var not set
		if not meta:get_float(name) then
			meta:set_float(name, 0.0)
		end
	end
	return meta
end

--- Swaps node if node is not same and return old node name.
--- @see minetest.swap_node (https://dev.minetest.net/minetest.swap_node)
---
--- @private
--- @param pos table {x,y,z}
--- @param name string
--- @return string
local function swapNode(pos, name)
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
function Grinder:getMeta()
	return self.meta or getInitiatedMeta(self.position)
end

--- Sets Node into active grinder with new hint.
--- @public
--- @param hint_en string A template for hinting in English. Use "%s" for machine name placeholder.
--- @param cooked number !Deprecated
function Grinder:activate(hint_en, cooked)
	local meta         = self:getMeta()
	local percent      = math.floor(meta:get_float("fuel_time") / meta:get_float("fuel_totaltime") * 100)
	local item_percent = math.floor(meta:get_float("src_time") / cooked * 100)
	self:getMeta():set_string("infotext", SL((hint_en):format(machine_name)) .. " (" .. percent .. "%)")
	swapNode(self.position, "grinder:grinder_active")
	self:getMeta():set_string("formspec", grinder.get_grinder_active_formspec(percent, item_percent))
end

--- Sets Node into inactive grinder with new hint.
--- @public
--- @param hint_en string A template for hinting in English. Use "%s" for machine name placeholder.
function Grinder:deactivate(hint_en)
	self:getMeta():set_string("infotext", SL((hint_en):format(machine_name)))
	swapNode(self.position, "grinder:grinder")
	self:getMeta():set_string("formspec", grinder.grinder_inactive_formspec)
end

return Grinder
