local math_min, math_max, math_floor, math_random, v,          id
    = math.min, math.max, math.floor, math.random, vector.new, core.get_content_id

local config = require('icicles.config')

local config_rocks         = config.rocks
local config_icicle_prefix = config.icicle_prefix

local chunks_per_volume = config.map_gen.chunks_per_volume
local chunk_size        = config.map_gen.chunk_size
local icicles_per_chunk = config.map_gen.icicles_per_chunk
local height_min        = config.map_gen.height_min
local height_max        = config.map_gen.height_max

local id_air = id('air')


--- @class icicles.MapGen
local MapGen = {
	--- @type VoxelArea
	area      = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type integer[]
	data      = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @static
	--- @type integer[string]
	id_icicle = {},
}

--- @param area        VoxelArea
--- @param data        integer[]
---
--- @return self
function MapGen:new(area, data)
	self = setmetatable({}, { __index = self })
	self.area      = area
	self.data      = data

	return self
end

--- @param callback   fun(dx:number, dy:number, dz:number)
function MapGen:foreach_pos_in_chunk(callback)
	for dx = 0, chunk_size - 1 do
		for dy = 0, chunk_size - 1 do
			for dz = 0, chunk_size - 1 do
				callback(dx, dy, dz)
			end
		end
	end
end

--- @param pos    PositionVector
--- @param length number
function MapGen:make_stalactite(pos, rock_name, length)
	local icicle_name_prefix = config_icicle_prefix[rock_name]
	for i = length, 1, -1 do
		local under_pos = pos + v(0, - i + 1, 0)
		if self.area:get_node_id_at(under_pos) ~= id_air then
			return
		end

		self.area:set_node_at(under_pos, self.id_icicle[icicle_name_prefix .. 5 - i])
	end
end

--- @param pos    PositionVector
--- @param length number
function MapGen:make_stalagmite(pos, rock_name, length)
	local icicle_name_prefix = config_icicle_prefix[rock_name]
	for i = 1, length do
		local above_pos = v(pos) + v(0, i - 1, 0)
		if self.area:get_node_id_at(above_pos) ~= id_air then
			return
		end

		self.area:set_node_at(above_pos, self.id_icicle[icicle_name_prefix .. 5 - i], 1)
	end
end

---@param min_pos Position
---@param max_pos Position
---@param seed    number
function MapGen:generate(min_pos, max_pos, seed)
	if max_pos.y < height_min or min_pos.y > height_max then
		return
	end
	local y_min      = math_max(min_pos.y, height_min)
	local y_max      = math_min(max_pos.y, height_max)
	local volume     = (max_pos.x - min_pos.x + 1) * (y_max - y_min + 1) * (max_pos.z - min_pos.z + 1)
	local num_chunks = math_floor(chunks_per_volume * volume)
	local inverse_chance = math_floor(chunk_size * chunk_size * chunk_size / icicles_per_chunk)
	for i = 1, num_chunks do
		local y0 = math_random(y_min, y_max - chunk_size + 1)
		if y0 >= height_min and y0 <= height_max and (y0 + 2) % 16 ~= 0 then
			local x0 = math_random(min_pos.x, max_pos.x - chunk_size + 1)
			local z0 = math_random(min_pos.z, max_pos.z - chunk_size + 1)
			local chunk_start_pos = v(x0, y0, z0)
			self:foreach_pos_in_chunk(function(dx, dy, dz)
				if math_random(1, inverse_chance) ~= 1 then
					return
				end

				local cur_pos   = chunk_start_pos + v(dx, dy, dz)
				local above_pos = cur_pos:above()
				local under_pos = cur_pos:under()

				if self.area:get_node_id_at(cur_pos) == id_air then
					local above_node_name = self.area:get_node_name_at(above_pos) --[[@as string]]
					if above_node_name:is_one_of(config_rocks) then
						self:make_stalactite(cur_pos, above_node_name, math_random(2, 4))

						return
					end

					local under_node_name = self.area:get_node_name_at(under_pos) --[[@as string]]
					if under_node_name:is_one_of(config_rocks) then
						self:make_stalagmite(cur_pos, under_node_name, math_random(2, 4))

						return
					end

				end
			end)
		end
	end
end


return MapGen
