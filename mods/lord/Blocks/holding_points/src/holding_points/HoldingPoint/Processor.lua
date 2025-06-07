local TICK_SECONDS = 10
local MINUTE       = 60

--- @type table<string,holding_points.HoldingPoint.Processor>
local processors = {}

--- @class holding_points.HoldingPoint.Processor
local Processor = {
	--- @type string
	id   = nil,
	--- @type job
	job  = nil,
	--- @type number process every `tick` seconds
	tick = TICK_SECONDS,
}

--- @private
--- @param holding_point holding_points.HoldingPoint
--- @return string
function Processor.create_id(holding_point)
	return minetest.pos_to_string(holding_point.position)
end

--- @param holding_point holding_points.HoldingPoint
--- @return holding_points.HoldingPoint.Processor
function Processor.get_for(holding_point)
	local id = Processor.create_id(holding_point)
	if not processors[id] then
		processors[id] = Processor:new(id, holding_point)
	end

	return processors[id]
end

--- @private
--- @param id            string
--- @param holding_point holding_points.HoldingPoint
--- @return holding_points.HoldingPoint.Processor
function Processor:new(id, holding_point)
	local class = self

	self = {}
	self.id            = id
	self.holding_point = holding_point

	return setmetatable(self, { __index = class })
end

function Processor:remove()
	processors[self.id] = nil
end

--- @return holding_points.HoldingPoint.Processor
function Processor:start()
	self.job = minetest.after(10, Processor.on_tick, self)

	return self
end

--- @return holding_points.HoldingPoint.Processor
function Processor:stop()
	if not self.job then
		return
	end

	self.job:cancel()
	self.job = nil

	return self
end

--- @private
function Processor:on_tick()
	self.job = nil

	self.holding_point:add_score(5)
	local holding_time = self.holding_point:get_holding_time()
	if holding_time >= 3 * MINUTE then
		local holding_time_tail = holding_time % (3 * MINUTE)
		if holding_time_tail >= 0 and holding_time_tail < 10 then
			self.holding_point:add_score(150)
		end
	end

	self:start()
end


return Processor
