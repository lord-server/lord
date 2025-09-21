--- @diagnostic disable: missing-return


--- @class VoxelManip
--- [View in lua_api.txt](https://github.com/minetest/minetest/blob/5.7.0/doc/lua_api.txt#L4244)
VoxelManip = {}

--- Loads a chunk of map into the VoxelManip object
---   containing the region formed by `p1` and `p2`.
---     * returns actual emerged `pmin`, actual emerged `pmax`
--- @param position1 Position min position for load part of map
--- @param position2 Position max position for load part of map
--- @return Position, Position
function VoxelManip:read_from_map(position1, position2) end
--- Writes the data loaded from the `VoxelManip` back to
---   the map.
---     * **important**: data must be set using `VoxelManip:set_data()` before
---       calling this.
---     * if `light` is true, then lighting is automatically recalculated.
---       The default value is true.
---       If `light` is false, no light calculations happen, and you should correct
---       all modified blocks with `minetest.fix_light()` as soon as possible.
---       Keep in mind that modifying the map where light is incorrect can cause
---       more lighting bugs.
--- @param light boolean Default: true
function VoxelManip:write_to_map(light) end
--- Returns a `MapNode` table of the node currently loaded in
---   the `VoxelManip` at that position
function VoxelManip:get_node_at(pos) end
--- Sets a specific `MapNode` in the `VoxelManip` at
---   that position.
function VoxelManip:set_node_at(pos, node) end
--- Retrieves the node content data loaded into the `VoxelManip` object.
---     * returns raw node data in the form of an array of node content IDs
---     * if the param `buffer` is present, this table will be used to store the
---       result instead.
--- @param buffer number[]|nil
--- @return number[]
function VoxelManip:get_data(buffer) end
--- Sets the data contents of the `VoxelManip` object
---     * expects raw node data in the form of an array of node content IDs
---     * the array must be exactly the size of the volume of the `VoxelManip` object
---     * the array must be indexed from `1` to `volume`
---     * the data can be retrieved using `VoxelManip:get_data()`
--- @param data number[]
function VoxelManip:set_data(data) end
--- Sets the data contents of the `VoxelManip` object
--- function VoxelManip:set_data(data) end
--- Does nothing, kept for compatibility.
--- function VoxelManip:update_map() end
--- Set the lighting within the `VoxelManip` to
---   a uniform value.
---     * `light` is a table, `{day=<0...15>, night=<0...15>}`
---     * To be used only by a `VoxelManip` object from
---       `minetest.get_mapgen_object`.
---     * (`p1`, `p2`) is the area in which lighting is set, defaults to the whole
---       area if left out.
function VoxelManip:set_lighting(light, p1, p2) end
--- Gets the light data read into the `VoxelManip` object.
---     * Returns an array (indices 1 to volume) of integers ranging from `0` to
---       `255`.
---     * Each value is the bitwise combination of day and night light values
---       (`0` to `15` each).
---     * `light = day + (night * 16)`
---     * If the param `buffer` is present, this table will be used to store the
---       result instead.
--- @param buffer number[]? [optional]
--- @return number[]
function VoxelManip:get_light_data(buffer) end
--- Sets the `param1` (light) contents of each node in the `VoxelManip`.
---     * expects lighting data in the same format that `get_light_data()` returns
--- @param light_data number[]
function VoxelManip:set_light_data(light_data) end
--- Gets the raw `param2` data read into the `VoxelManip` object.
---     * Returns an array (indices 1 to volume) of integers ranging from `0` to
---       `255`.
---     * If the param `buffer` is present, this table will be used to store the
---       result instead.
--- @param buffer number[]? [optional]
--- @return number[]
function VoxelManip:get_param2_data(buffer) end
--- Sets the `param2` contents of each node in the `VoxelManip`.
--- @param param2_data number[]
function VoxelManip:set_param2_data(param2_data) end
--- Calculate lighting within the `VoxelManip`.
---     * To be used only by a `VoxelManip` object from
---       `minetest.get_mapgen_object`.
---     * (`p1`, `p2`) is the area in which lighting is set, defaults to the whole
---       area if left out or nil. For almost all uses these should be left out
---       or nil to use the default.
---     * `propagate_shadow` is an optional boolean deciding whether shadows in a
---       generated mapchunk above are propagated down into the mapchunk, defaults
---       to `true` if left out.
--- @overload fun(p1:Position, p2:Position)
--- @overload fun(propagate_shadow:boolean)
--- @overload fun()
--- @param p1 Position
--- @param p2 Position
--- @param propagate_shadow boolean
function VoxelManip:calc_lighting(p1, p2, propagate_shadow) end
--- Update liquid flow
function VoxelManip:update_liquids() end
--- Returns `true` or `false` if the data in the voxel
---   manipulator had been modified since the last read from map, due to a call to
---   `minetest.set_data()` on the loaded area elsewhere.
function VoxelManip:was_modified() end
--- Returns actual emerged minimum and maximum positions.
function VoxelManip:get_emerged_area() end
