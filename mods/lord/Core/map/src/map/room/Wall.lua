local Cuboid = require('map.Cuboid')


--- @class Voxrame.map.room.Wall: Voxrame.map.Cuboid
local Wall = {}
setmetatable(Wall, { __index = Cuboid })


return Wall
