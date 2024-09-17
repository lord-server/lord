

--- @class effects.Effect
local Effect = {
	--- @type string
	name = nil,
}

--- @param name string
--- @param type string
function Effect:new(name, type)
	local class = self

	self = {}
	self.name  = name

	return setmetatable(self, { __index = class })
end

--- @param start fun(self:effects.Effect,player:Player,amount:number,duration:number)
--- @return effects.Effect
function Effect:on_start(start)
	self.start = start

	return self
end

--- @param stop fun(self:effects.Effect,player:Player)
--- @return effects.Effect
function Effect:on_stop(stop)
	self.stop = stop

	return self
end


function Effect:start()
	error('No start function assign for effect: you have to set the `start()` function before; use `Effect:on_start()`')
end

function Effect:stop()
	error('No start function assign for effect: you have to set the `start()` function before; use `Effect:on_stop()`')
end


return Effect
