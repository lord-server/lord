
--- @enum (key) Position.OffsetSide
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

--- @param n? integer
--- @return self
function vector:above(n)
	return self:offset(0, n or 1, 0)
end

--- @param n? integer
--- @return self
function vector:under(n)
	return self:offset(0, -(n or 1), 0)
end

--- @param n? integer
--- @return self
function vector:at_north(n)
	return self:offset(0, 0, n or 1)
end

--- @param n? integer
--- @return self
function vector:at_south(n)
	return self:offset(0, 0, -(n or 1))
end

--- @param n? integer
--- @return self
function vector:at_east(n)
	return self:offset(n or 1, 0, 0)
end

--- @param n? integer
--- @return self
function vector:at_west(n)
	return self:offset(-(n or 1), 0, 0)
end

--- @param side Position.OffsetSide
--- @param n?   integer
--- @return self
function vector:at(side, n)
    return self[offset_method[side]](self, n) --- @diagnostic disable-line: param-type-mismatch
end
