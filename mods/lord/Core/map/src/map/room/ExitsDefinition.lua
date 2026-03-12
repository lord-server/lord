
--- @class Voxrame.map.room.ExitsDefinition
--- @field count?  integer|range                   Possible number of exits or range of exits. Default: 2-4
--- @field walls?  Voxrame.map.room.wall.Type[]    List of allowed sides for exits. Default: `Type.horizontal()`
--- @field size?   { width: range, height: range } Size of exits. Default: 1x2
--- @field shift?  range                           Range of random shift for exit position. Default: -2 to 2

--- @class Voxrame.map.room.ExitsDefinitionResolved: Voxrame.map.room.ExitsDefinition
--- @field count   range                           Possible number of exits or range of exits. Default: 2-4
--- @field walls   Voxrame.map.room.wall.Type[]    List of allowed sides for exits. Default: `Type.horizontal()`
--- @field size    { width: range, height: range } Size of exits. Default: 1x2
--- @field shift   range                           Range of random shift for exit position. Default: -2 to 2
