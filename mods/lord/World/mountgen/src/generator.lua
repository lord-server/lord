local math_floor, math_ceil, math_tan, id
    = math.floor, math.ceil, math.tan, minetest.get_content_id

local ChunksIterator = require('generator.ChunksIterator')
local Node           = require('generator.Node')


local stone_id = id('default:stone')
local air_id   = id('air')

local can_place_dirt = function(data)
	if data ~= stone_id then
		return true
	end

	return false
end

local can_place_plant = function(data)
	if data == air_id then
		return true
	end

	return false
end

mountgen.mountgen = function(top, config)
	local method_name = config.METHOD
	top.x = math_floor(top.x + 0.5)
	top.y = math_floor(top.y + 0.5)
	top.z = math_floor(top.z + 0.5)

	if top.y <= config.Y0 then
		minetest.log('Trying to build negative mountain')
		return
	end

	--- @type mountgen.generator.HeightMap
	local height_map, width, center
	if method_name == 'cone' then

		height_map, width, center = mountgen.cone(top, config)

	elseif method_name == 'diamond-square' then

		local H = top.y - config.Y0
		local W = math_ceil(2 * H * math_tan(math.rad(90 - config.ANGLE))) + 3
		height_map, width, center = mountgen.diamond_square(W, H,
			config.rk_thr,
			config.rk_small,
			config.rk_big)

	else
		minetest.log('error', 'unknown method: ' .. tostring(method_name))
		return
	end

	local p1 = { x = top.x + 1 - center, y = config.Y0, z = top.z + 1 - center }
	local p2 = { x = top.x + width - center, y = top.y + 16, z = top.z + width - center }

	ChunksIterator.foreach_pos_in(p1, p2, function(data, i, position)
		if
			position.z >= 1 and position.z <= width and
			position.x >= 1 and position.x <= width and
			position.y >= 1
		then

			local height = math_floor(height_map.map[position.z][position.x] + 0.5)

			if height > 0 then
				if position.y < height then
					data[i] = Node.get_rock(position, config)
				elseif position.y == height then
					if can_place_dirt(data[i], stone_id) then
						data[i] = Node.get_coverage(position, config)
					end
				elseif position.y == height + 1 then
					if can_place_plant(data[i], air_id) then
						local plant_node_id = Node.get_plant(position, config)
						if plant_node_id ~= nil then
							data[i] = plant_node_id
						end
					end
				end
			end
		end
	end)
end
