local type, math_floor, math_random, math_is_among, vector_sort, v
    = type, math.floor, math.random, math.is_among, vector.sort, vector.new
local id,                  name_by_id
    = core.get_content_id, core.get_name_from_content_id


local id_air = id('air')

--- Returns just `value` if `is_random` is false,
--- or random value from `value` if `value` is array and `is_random` is true.
---
--- @param value     integer|integer[]
--- @param is_random boolean
--- @param count     integer
--- @return integer
local function get_self_or_random(value, is_random, count)
	return is_random
		and value[math_random(count)]
		or  value--[[@as integer]]
end


--- @param data integer[]
function VoxelArea:set_data(data)
	self.data = data
end

--- @param data_param2 integer[]
function VoxelArea:set_data_param2(data_param2)
	self.data_param2 = data_param2
end

--- @param data_light integer[]
function VoxelArea:set_data_light(data_light)
	self.data_light = data_light
end

--- Iterate over positions in area.
--- Use `data[i]` to set/get node at position.
--- Usage:
--- ```lua
--- vox_area:foreach(function(i, data, data_param2, data_light)
---    data[i] = id('default:stone') -- id('default:stone') <==> core.get_content_id('default:stone')
---
---    return true -- [optional] return true if you want to break `foreach` loop
--- end)
--- ```
--- **Note:** use preloaded ids for better performance.
---
--- @overload fun(callback: fun(i:integer, data:integer[], data_param2:integer[], data_light:integer[]):boolean?):self
--- @param from Position
--- @param to   Position
--- @param callback fun(i:integer, data:integer[], data_param2:integer[], data_light:integer[]):boolean?
--- @return self
function VoxelArea:foreach(from, to, callback)
	if type(from) == 'function' then
		callback = from
		from     = self.MinEdge
		to       = self.MaxEdge
	end

	for i in self:iterp(from, to) do
		if callback(i, self.data, self.data_param2, self.data_light) then
			break
		end
	end

	return self
end

--- Returns the node ID at the specified position.
--- @param position Position
--- @return integer?, integer?, integer?
function VoxelArea:get_node_id_at(position, with_param2, with_light)
	local i = self:indexp(position)

	return
		self.data[i],
		with_param2 and self.data_param2[i],
		with_light  and self.data_light[i]
end

--- Returns the node name at the specified position.
--- Prefer to use `get_node_id_at()` and compare with preloaded node IDs.
---
--- @param position Position
--- @return string?, integer?, integer?
function VoxelArea:get_node_name_at(position, with_param2, with_light)
	local node_id, param2, light = self:get_node_id_at(position, with_param2, with_light)

	return name_by_id(node_id), param2, light
end

--- Sets the node at the specified position to the given node ID.
--- Preloaded node IDs are recommended for better performance; use `core.get_content_id(name)` to preload.
--- @param position Position
--- @param node_id  integer
---
--- @return self
function VoxelArea:set_node_at(position, node_id, param2, light)
	local i = self:indexp(position)
	self.data[i] = node_id
	if param2 then self.data_param2[i] = param2 end
	if light  then self.data_light [i] = light  end

	return self
end

--- Calculates the fraction of the area occupied by the specified node ID(s).
--- @param node_id table|integer if table, counts all IDs in the table.
--- @return number # content of area occupied by the node ID (0..1)
function VoxelArea:content_of(node_id)
	--- @type integer[]
	node_id = type(node_id) == 'table' and node_id or { node_id }

	local count = 0
	self:foreach(function(i, data, data_param2, data_light)
		if table.contains(node_id, data[i]) then
			count = count + 1
		end
	end)

	return count / self:getVolume()
end

--- @protected
--- @param node_id integer|integer[]
--- @param from    Position
--- @param to      Position
--- @param chance  number
--- @param param2? integer|integer[]
---
--- @return self
function VoxelArea:fill_with_chance(node_id, from, to, chance, param2)
	local is_random        = type(node_id) == 'table'
	local is_random_param2 = type(param2) == 'table'
	local nodes_count      = is_random and #node_id or 0
	local param2_count     = is_random_param2 and #param2 or 0

	local data        = self.data
	local data_param2 = self.data_param2

	for i in self:iterp(from, to) do
		if math_random() <= chance then
			data[i] = get_self_or_random(node_id, is_random, nodes_count)
			if param2 then
				data_param2[i] = get_self_or_random(param2, is_random_param2, param2_count)
			end
		end
	end

	return self
end

--- Sets all nodes in the specified area to the given node ID or random IDs.
--- @param node_id integer|integer[] if is array of integers, than area part wil be filled with random nodes from it.
--- @param from?   Position          position from which to start filling.
--- @param to?     Position          position to which to fill.
--- @param chance? number            chance to fill each node (0..1), default is 1 (fill all).
--- @param param2? integer|integer[] if is array of integers, than random param2 will be set from it.
---
--- @return self
function VoxelArea:fill_with(node_id, from, to, chance, param2)
	from   = from   or self.MinEdge
	to     = to     or self.MaxEdge

	if chance and chance < 1 then
		return self:fill_with_chance(node_id, from, to, chance, param2)
	end

	local is_random   = type(node_id) == 'table'
	local nodes_count = is_random and #node_id or 0
	local data        = self.data
	for i in self:iterp(from, to) do
		data[i] = get_self_or_random(node_id, is_random, nodes_count)
	end

	return self
end

--- Checks if the node at the specified position matches the given node ID.
--- @param position       vector|nil if nil, returns false.
--- @param node_id        integer    node ID to check against.
--- @param check_contain? boolean    if true, checks if position is inside area, default is false.
--- @return boolean
function VoxelArea:is(position, node_id, check_contain)
	check_contain = check_contain or false

	return position and (not check_contain or self:containsp(position))
		and self.data[self:indexp(position)] == node_id
		or  false
end

--- Checks if the node at the specified position does not match the given node ID.
--- @param position       vector|nil if nil, returns false.
--- @param node_id        integer    node ID to check against.
--- @param check_contain? boolean    if true, checks if position is inside area, default is false.
--- @return boolean
function VoxelArea:is_not(position, node_id, check_contain)
	check_contain = check_contain or false

	return position and (not check_contain or self:containsp(position))
		and self.data[self:indexp(position)] ~= node_id
		or  false
end

--- Places a pile of nodes randomly within the specified area in cuboid [from, to].
--- Nodes are only placed above non-air nodes, with a 50% chance at each valid position.
--- Note: Preloaded node IDs are recommended for better performance; use `core.get_content_id(name)` to preload.
--- Cubaoid [from, to] is inclusive and will be sorted automatically.
---
--- @param node_id   integer|integer[] if is array, random nodes will be placed.
--- @param from?     Position          position from which to start placing pile.
--- @param to?       Position          position to which to place pile.
--- @param peak?     Position          peak position of the pile.
--- @param fillness? number            fillness of the pile, 0..1 (default is 0.75).
--- @param param2?   integer|integer[] if is array, random param2 will be set.
---
--- @return self
function VoxelArea:place_pile(node_id, from, to, peak, fillness, param2)
	from     = from     or self.MinEdge
	to       = to       or self.MaxEdge
	fillness = fillness or 0.75
	from, to = vector_sort(from, to)

	peak = peak or v(
		math_floor((from.x + to.x) / 2),
		to.y,
		math_floor((from.z + to.z) / 2)
	)
	local height = to.y - from.y + 1
	-- Deltas from peak to sides of base of pile (pyramid)
	local peak_from_dx = peak.x - from.x
	local peak_from_dz = peak.z - from.z
	local peak_to_dx   = to.x - peak.x
	local peak_to_dz   = to.z - peak.z

	local data = self.data

	local is_random        = type(node_id) == 'table'
	local is_random_param2 = type(param2) == 'table'
	local nodes_count      = is_random and #node_id or 0
	local param2_count     = is_random_param2 and #param2 or 0

	self:foreach(from, to, function(i)

		local pos = v(self:position(i))

		-- place above, only if below is not air
		if self:is(pos:under(), id_air, true) then
			return
		end

		local layer = pos.y - from.y -- 0..height-1

		local layer_from_dx = from.x + peak_from_dx * layer / height
		local layer_to_dx   = to.x   - peak_to_dx   * layer / height
		local layer_from_dz = from.z + peak_from_dz * layer / height
		local layer_to_dz   = to.z   - peak_to_dz   * layer / height

		if
			math_is_among(pos.x, layer_from_dx, layer_to_dx) and
			math_is_among(pos.z, layer_from_dz, layer_to_dz) and
			math_random() <= fillness
		then
			data[i] = get_self_or_random(node_id, is_random, nodes_count)
			if param2 then
				self.data_param2[i] = get_self_or_random(param2, is_random_param2, param2_count)
			end
		end
	end)

	return self
end
