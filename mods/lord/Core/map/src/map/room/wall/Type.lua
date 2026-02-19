local assert
    = assert

--- @enum Voxrame.map.room.wall.Type: string
local WallType = {
	floor   = 'floor',
	ceiling = 'ceiling',
	north   = 'north',
	south   = 'south',
	east    = 'east',
	west    = 'west',
}

--- @type table<Voxrame.map.room.wall.Type, Voxrame.map.room.wall.Type>
local only_values = table.copy(WallType) --- @diagnostic disable-line: assign-type-mismatch
--- @type table<Voxrame.map.room.wall.Type, Voxrame.map.room.wall.Type>
local opposites = {
	[WallType.east]    = WallType.west,
	[WallType.west]    = WallType.east,
	[WallType.north]   = WallType.south,
	[WallType.south]   = WallType.north,
	[WallType.ceiling] = WallType.floor,
	[WallType.floor]   = WallType.ceiling,
}

--- Returns array with only valid wall sides.  \
--- If you need to ierate through all wall sides, use this method.  \
--- Don't use `pairs(WallType)` directly,  \
--- because it also contains functions like `all`, `horizontal`, `is_valid`, `assert_valid`, `of`, `opposite_for`.
--- Also don't use checks like `assert(WallType[side])` directly, because it also contains functions.
--- @static
--- @return table<Voxrame.map.room.wall.Type, Voxrame.map.room.wall.Type>
function WallType.all()
	return only_values
end

--- Returns array with only horizontal wall sides:
--- - `north`
--- - `south`
--- - `east`
--- - `west`
--- @static
--- @param shuffle? boolean Whether to shuffle the array. Default is `false`.
--- @return Voxrame.map.room.wall.Type[]
function WallType.horizontal(shuffle)
	local result = {
		WallType.north,
		WallType.south,
		WallType.east,
		WallType.west,
	}

	if shuffle then
		table.shuffle(result)
	end

	return result
end

--- Checks if the given side is a valid wall side.
--- @static
--- @param side Voxrame.map.room.wall.Type Side to check.
--- @return boolean
function WallType.is_valid(side)
	return only_values[side] ~= nil
end

--- Asserts that the given side is a valid wall side.
--- `assert()` will be called if the side is not valid.
--- @static
--- @param side Voxrame.map.room.wall.Type Side to check.
function WallType.assert_valid(side)
	assert(WallType.is_valid(side), 'Invalid wall side: ' .. side)
end

--- Converts direction vector to wall side type.
--- @static
--- @param direction vector Direction of the side. Must be horizontal.
--- @return Voxrame.map.room.wall.Type?
function WallType.of(direction) -- luacheck: ignore 561 # cyclomatic complexity
	return direction.x > 0 and WallType.east
		or direction.x < 0 and WallType.west
		or direction.z > 0 and WallType.north
		or direction.z < 0 and WallType.south
		or direction.y > 0 and WallType.ceiling
		or direction.y < 0 and WallType.floor
		or nil
end

--- Returns opposite wall side type.
--- @static
--- @param side Voxrame.map.room.wall.Type Side of the room.
--- @return Voxrame.map.room.wall.Type
function WallType.opposite_for(side)
	return opposites[side]
end


return WallType
