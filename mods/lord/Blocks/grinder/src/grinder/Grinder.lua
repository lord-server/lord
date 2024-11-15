local setmetatable, pairs, math_floor
    = setmetatable, pairs, math.floor

local S    = minetest.get_mod_translator()
local form = require('grinder.definition.node.form')


---
--- @class Grinder
---
local Grinder = {
	--- @static
	--- @type string
	NAME       = S('Grinder'),
	--- @static
	--- @type number
	TIMER_TICK = 1,
	--- @static
	form       = form,
	--- @static
	--- @type {inactive:string,active:string}
	node_name  = {
		inactive = 'grinder:grinder',
		active   = 'grinder:grinder_active',
	},
	--- @type Position
	position   = nil,
	--- @type NodeMetaRef
	meta       = nil,
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
		'fuel_totaltime',
		'fuel_time',
		'src_totaltime',
		'src_time'
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
		'fuel_totaltime',
		'fuel_time',
		'src_totaltime',
		'src_time'
	}) do
		meta:set_float(name, 0.0)
	end
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
--- @param hint string A template for hinting in English. Use '%s' for machine name placeholder.
function Grinder:activate(hint)
	local meta         = self:get_meta()
	local percent      = math_floor(meta:get_float('fuel_time') / meta:get_float('fuel_totaltime') * 100)
	local item_percent = math_floor(meta:get_float('src_time') / meta:get_float('src_totaltime') * 100)
	minetest.swap_node_if_not_same(self.position, self.node_name.active)
	self:get_meta():set_string('infotext', self.NAME .. ': ' .. hint .. ' (' .. percent .. '%)')
	self:get_meta():set_string('formspec', self.form.get_spec('active', percent, item_percent))
	minetest.get_node_timer(self.position):start(self.TIMER_TICK)
end

--- Sets Node into inactive grinder with new hint.
--- @public
--- @param hint string A template for hinting in English. Use '%s' for machine name placeholder.
function Grinder:deactivate(hint)
	minetest.get_node_timer(self.position):stop()
	reset_meta_vars(self:get_meta())
	minetest.swap_node_if_not_same(self.position, self.node_name.inactive)
	self:get_meta():set_string('infotext', self.NAME .. ': ' .. hint)
	self:get_meta():set_string('formspec', self.form.get_spec('inactive'))
end


return Grinder
