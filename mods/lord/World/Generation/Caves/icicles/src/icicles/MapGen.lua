local minetest_get_node, minetest_set_node, math_min, math_max, math_floor, v
    = minetest.get_node, minetest.set_node, math.min, math.max, math.floor, vector.new

local config = require('icicles.config')

local config_rocks         = config.rocks
local config_icicle_prefix = config.icicle_prefix

local chunks_per_volume = config.map_gen.chunks_per_volume
local chunk_size        = config.map_gen.chunk_size
local icicles_per_chunk = config.map_gen.icicles_per_chunk
local height_min        = config.map_gen.height_min
local height_max        = config.map_gen.height_max


--- @class icicles.MapGen
local MapGen = {}

--- @param callback   fun(dx:number, dy:number, dz:number)
function MapGen.foreach_pos_in_chunk(callback)
	for dx = 0, chunk_size - 1 do
		for dy = 0, chunk_size - 1 do
			for dz = 0, chunk_size - 1 do
				callback(dx, dy, dz)
			end
		end
	end
end

--- @param pos    Position
--- @param length number
function MapGen.make_stalactite(pos, rock_name, length)
	local icicle_name_prefix = config_icicle_prefix[rock_name]
	for i = length, 1, -1 do
		local under_pos = v(pos) + v(0, - i + 1, 0)
		if minetest_get_node(under_pos).name ~= 'air' then
			return
		end

		minetest_set_node(under_pos, { name = icicle_name_prefix .. 5 - i })
	end
end

--- @param pos    Position
--- @param length number
function MapGen.make_stalagmite(pos, rock_name, length)
	local icicle_name_prefix = config_icicle_prefix[rock_name]
	for i = 1, length do
		local above_pos = v(pos) + v(0, i - 1, 0)
		if minetest_get_node(above_pos).name ~= 'air' then
			return
		end

		minetest_set_node(above_pos, { name = icicle_name_prefix .. 5 - i, param2 = 1 })
	end
end

---@param min_pos Position
---@param max_pos Position
---@param seed    number
function MapGen.generate(min_pos, max_pos, seed)
	if max_pos.y < height_min or min_pos.y > height_max then
		return
	end
	local y_min      = math_max(min_pos.y, height_min)
	local y_max      = math_min(max_pos.y, height_max)
	local volume     = (max_pos.x - min_pos.x + 1) * (y_max - y_min + 1) * (max_pos.z - min_pos.z + 1)
	local pr         = PseudoRandom(seed)
	local num_chunks = math_floor(chunks_per_volume * volume)
	local inverse_chance = math_floor(chunk_size * chunk_size * chunk_size / icicles_per_chunk)
	for i = 1, num_chunks do
		local y0 = pr:next(y_min, y_max - chunk_size + 1)
		if y0 >= height_min and y0 <= height_max and (y0 + 2) % 16 ~= 0 then
			local x0 = pr:next(min_pos.x, max_pos.x - chunk_size + 1)
			local z0 = pr:next(min_pos.z, max_pos.z - chunk_size + 1)
			local chunk_start_pos = v(x0, y0, z0)
			MapGen.foreach_pos_in_chunk(function(dx, dy, dz)
				if pr:next(1, inverse_chance) ~= 1 then
					return
				end

				local cur_pos   = chunk_start_pos + v(dx, dy, dz)
				local above_pos = cur_pos + v(0, 1, 0)
				local under_pos = cur_pos - v(0, 1, 0)

				if minetest_get_node(cur_pos).name == 'air' then

					local above_node_name = minetest_get_node(above_pos).name
					if above_node_name:is_one_of(config_rocks) then
						MapGen.make_stalactite(cur_pos, above_node_name, pr:next(2, 4))

						return
					end

					local under_node_name = minetest_get_node(under_pos).name
					if under_node_name:is_one_of(config_rocks) then
						MapGen.make_stalagmite(cur_pos, under_node_name, pr:next(2, 4))

						return
					end

				end
			end)
		end
	end
end


return MapGen
