local setmetatable, pairs, math_floor
    = setmetatable, pairs, math.floor


---
--- @class fuel_device.Device
---
local Device = {
	--- @static
	--- @type string
	NAME       = nil,
	--- @static
	--- @type number
	TIMER_TICK = 1,
	--- @static
	--- @generic GenericForm: fuel_device.node.Form
	--- @type GenericForm
	form       = nil,
	--- @static
	--- @type {inactive:string,active:string}
	node_name  = {
		inactive = nil,
		active   = nil,
	},
	--- @static
	--- @type {src:number,dst:number}
	size_of = { fuel = 1, src = 1, dst = 1, },

	-- dynamic:
	--- @type Position
	position   = nil,
	--- @type NodeMetaRef
	meta       = nil,
}

--- @public
--- @generic GenericDevice: fuel_device.Device
--- @param child_class GenericDevice
--- @return GenericDevice
function Device:extended(child_class)
	return setmetatable(child_class or {}, { __index = self })
end

--- Constructor
--- @public
--- @param pos table<number,number,number>
--- @return fuel_device.Device
function Device:new(pos)
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
local function reset_meta_times(meta)
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
function Device:get_meta()
	if not self.meta then
		self.meta = get_initiated_meta(self.position)
	end

	return self.meta
end

--- @public
function Device:init()
	self:get_meta():set_string('formspec', self.form.get_spec('inactive'))
	self:get_meta():set_string('infotext', self.NAME)
	local inventory = self:get_meta():get_inventory()
	inventory:set_size('fuel', self.size_of.fuel or 1)
	inventory:set_size('src', self.size_of.src or 1)
	inventory:set_size('dst', self.size_of.dst or 1)
end

--- @public
--- @return boolean
function Device:is_empty()
	local inventory = self:get_meta():get_inventory()

	return inventory:is_empty('fuel') and inventory:is_empty('src') and inventory:is_empty('dst')
end

--- Sets Node into active device with new hint.
--- @public
--- @param hint string text shown in `infotext` after `"<Device.NAME>: "`
function Device:activate(hint)
	local meta         = self:get_meta()
	local percent      = math_floor(meta:get_float('fuel_time') / meta:get_float('fuel_totaltime') * 100)
	local item_percent = math_floor(meta:get_float('src_time') / meta:get_float('src_totaltime') * 100)
	minetest.swap_node_if_not_same(self.position, self.node_name.active)
	self:get_meta():set_string('infotext', self.NAME .. ': ' .. hint .. ' (' .. percent .. '%)')
	self:get_meta():set_string('formspec', self.form.get_spec('active', percent, item_percent))
	minetest.get_node_timer(self.position):start(self.TIMER_TICK)
end

--- Sets Node into inactive device with new hint.
--- @public
--- @param hint string text shown in `infotext` after `"<Device.NAME>: "`
function Device:deactivate(hint)
	minetest.get_node_timer(self.position):stop()
	reset_meta_times(self:get_meta())
	minetest.swap_node_if_not_same(self.position, self.node_name.inactive)
	self:get_meta():set_string('infotext', self.NAME .. ': ' .. hint)
	self:get_meta():set_string('formspec', self.form.get_spec('inactive'))
end


return Device
