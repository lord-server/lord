--- @class VoxelArea
--- A helper class for voxel areas.
--- It can be created via `VoxelArea(pmin, pmax)` or
--- `VoxelArea:new({MinEdge = pmin, MaxEdge = pmax})`.
--- The coordinates are *inclusive*, like most other things in Minetest.
VoxelArea = {}

--- @param cuboid { MinEdge: any, MaxEdge: any }
function VoxelArea:new(cuboid) end

--- returns a 3D vector containing the size of the area formed by
---   `MinEdge` and `MaxEdge`.
function VoxelArea:getExtent() end
--- returns the volume of the area formed by `MinEdge` and
---   `MaxEdge`.
function VoxelArea:getVolume() end
--- returns the index of an absolute position in a flat array
---   starting at `1`.
---     * `x`, `y` and `z` must be integers to avoid an incorrect index result.
---     * The position (x, y, z) is not checked for being inside the area volume,
---       being outside can cause an incorrect index result.
---     * Useful for things like `VoxelManip`, raw Schematic specifiers,
---       `PerlinNoiseMap:get2d`/`3dMap`, and so on.
function VoxelArea:index(x, y, z) end
--- same functionality as `index(x, y, z)` but takes a vector.
---     * As with `index(x, y, z)`, the components of `p` must be integers, and `p`
---       is not checked for being inside the area volume.
function VoxelArea:indexp(p) end
--- returns the absolute position vector corresponding to index
---   `i`.
function VoxelArea:position(i) end
--- check if (`x`,`y`,`z`) is inside area formed by
---   `MinEdge` and `MaxEdge`.
function VoxelArea:contains(x, y, z) end
--- same as above, except takes a vector
function VoxelArea:containsp(p) end
--- same as above, except takes an index `i`
function VoxelArea:containsi(i) end
--- returns an iterator that returns
---   indices.
---     * from (`minx`,`miny`,`minz`) to (`maxx`,`maxy`,`maxz`) in the order of
---       `[z [y [x]]]`.
function VoxelArea:iter(minx, miny, minz, maxx, maxy, maxz) end
--- same as above, except takes a vector
function VoxelArea:iterp(minp, maxp) end
