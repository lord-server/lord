local math_max, math_abs, v
    = math.max, math.abs, vector.new


--- @experimental
--- @unstable
--- @enum WorldSide: string
local WorldSide = {
	ceiling = 'ceiling',
	floor   = 'floor',
	north   = 'north',
	south   = 'south',
	east    = 'east',
	west    = 'west',
}

--- @enum (key) Position.OffsetSide: WorldSide
local offset_method = {
	ceiling = 'above',
	floor   = 'under',
	north   = 'at_north',
	south   = 'at_south',
	east    = 'at_east',
	west    = 'at_west',
	-- additional "aliases"
	up      = 'above',
	down    = 'under',
	above   = 'above',
	under   = 'under',
	below   = 'under',
	['x+']  = 'at_east',
	['x-']  = 'at_west',
	['y+']  = 'above',
	['y-']  = 'under',
	['z+']  = 'at_north',
	['z-']  = 'at_south',
}

--- Returns position above this one by `n` nodes.
--- @param n? integer default is `1`
--- @return self
function vector:above(n)
	return self:offset(0, n or 1, 0)
end

--- Returns position below this one by `n` nodes.
--- @param n? integer default is `1`
--- @return self
function vector:under(n)
	return self:offset(0, -(n or 1), 0)
end

--- Returns position to the north of this one by `n` nodes.
--- @param n? integer default is `1`
--- @return self
function vector:at_north(n)
	return self:offset(0, 0, n or 1)
end

--- Returns position to the south of this one by `n` nodes.
--- @param n? integer default is `1`
--- @return self
function vector:at_south(n)
	return self:offset(0, 0, -(n or 1))
end

--- Returns position to the east of this one by `n` nodes.
--- @param n? integer default is `1`
--- @return self
function vector:at_east(n)
	return self:offset(n or 1, 0, 0)
end

--- Returns position to the west of this one by `n` nodes.
--- @param n? integer default is `1`
--- @return self
function vector:at_west(n)
	return self:offset(-(n or 1), 0, 0)
end

--- Returns position to the specified `side` of this one by `n` nodes.
--- @param side Position.OffsetSide|WorldSide
--- @param n?   integer default is `1`
--- @return self
function vector:at(side, n)
    return self[offset_method[side]](self, n) --- @diagnostic disable-line: param-type-mismatch
end

--- Returns the dominant axis direction as a vector, normalized to 1 and kept direction sign.
--- @return self
function vector:direction_axis()
	-- keep only max coordinate, make others 0, keep sign
	local max = math_max(math_abs(self.x), math_abs(self.y), math_abs(self.z))
	if math_abs(self.x) == max then
		return v(self.x, 0, 0):sign()
	elseif math_abs(self.y) == max then
		return v(0, self.y, 0):sign()
	else
		return v(0, 0, self.z):sign()
	end
end

--- Returns the dominant axis direction as a side string.
--- @return WorldSide
function vector:direction_side()
	local axis = self:direction_axis()
	if axis.x ~= 0 then
		return axis.x > 0 and WorldSide.east or WorldSide.west
	elseif axis.y ~= 0 then
		return axis.y > 0 and WorldSide.ceiling or WorldSide.floor
	else
		return axis.z > 0 and WorldSide.north or WorldSide.south
	end
end
