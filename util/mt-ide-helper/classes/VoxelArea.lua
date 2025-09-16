--- @diagnostic disable: missing-return


--- @class VoxelArea
--- A helper class for voxel areas.
--- It can be created via `VoxelArea(pmin, pmax)` or
--- `VoxelArea:new({MinEdge = pmin, MaxEdge = pmax})`.
--- The coordinates are *inclusive*, like most other things in Minetest.
VoxelArea = {}

--- The coordinates are *inclusive*, like most other things in Minetest.
---
--- Also you can create an instance via `VoxelArea(pmin, pmax)`
---
--- @param cuboid { MinEdge: any, MaxEdge: any }
function VoxelArea:new(cuboid) end

--- returns a 3D vector containing the size of the area formed by `MinEdge` and `MaxEdge`.
--- @return Position
function VoxelArea:getExtent() end
--- returns the volume of the area formed by `MinEdge` and `MaxEdge`.
--- @return number
function VoxelArea:getVolume() end
--- returns the index of an absolute position in a flat array starting at `1`.
---     * `x`, `y` and `z` must be integers to avoid an incorrect index result.
---     * The position (x, y, z) is not checked for being inside the area volume,
---       being outside can cause an incorrect index result.
---     * Useful for things like `VoxelManip`, raw Schematic specifiers,
---       `PerlinNoiseMap:get2d`/`3dMap`, and so on.
--- @param x number
--- @param y number
--- @param z number
--- @return number
function VoxelArea:index(x, y, z) end
--- same functionality as `index(x, y, z)` but takes a vector.
---     * As with `index(x, y, z)`, the components of `p` must be integers, and `p`
---       is not checked for being inside the area volume.
--- @param position Position
--- @return number
function VoxelArea:indexp(position) end
--- returns the absolute position vector corresponding to index `i`.
--- @param i number
--- @return Position
function VoxelArea:position(i) end
--- check if (`x`,`y`,`z`) is inside area formed by `MinEdge` and `MaxEdge`.
--- @param x number
--- @param y number
--- @param z number
--- @return boolean
function VoxelArea:contains(x, y, z) end
--- check if Position(`x`,`y`,`z`) is inside area formed by `MinEdge` and `MaxEdge`.
--- @param position Position
--- @return boolean
function VoxelArea:containsp(position) end
--- same as above, except takes an index `i`
function VoxelArea:containsi(i) end
--- returns an iterator that returns indices.
---     * from (`min_x`,`min_y`,`min_z`) to (`max_x`,`max_y`,`max_z`) in the order of `[z [y [x]]]`.
--- @param min_x number
--- @param min_y number
--- @param min_z number
--- @param max_x number
--- @param max_y number
--- @param max_z number
--- @return fun(tbl: table<number, number>): number, number
function VoxelArea:iter(min_x, min_y, min_z, max_x, max_y, max_z) end
--- returns an iterator that returns indices.
---     * from (`min_x`,`min_y`,`min_z`) to (`max_x`,`max_y`,`max_z`) in the order of `[z [y [x]]]`.
--- @param min_pos Position
--- @param max_pos Position
--- @return fun(tbl: table<number, number>): number, number
function VoxelArea:iterp(min_pos, max_pos) end
