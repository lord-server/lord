local math_floor, math_ceil, math_tan, id
    = math.floor, math.ceil, math.tan, minetest.get_content_id

local ChunksIterator = require('generator.ChunksIterator')
local Node           = require('generator.Node')
local Logger         = minetest.get_mod_logger()


local stone_id = id('default:stone')
local air_id   = id('air')

--- @param node_id number
--- @return boolean
local can_place_dirt = function(node_id)
	return node_id ~= stone_id
end

--- @param node_id number
--- @return boolean
local can_place_plant = function(node_id)
	return node_id == air_id
end


--- @class mountgen.Generator
local Generator = {
	--- @type vector
	top_position = nil,
	--- @type table
	config       = nil,
}


--- @param top_position Position
--- @param config       table
--- @return mountgen.Generator
function Generator:new(top_position, config)
	local class = self
	self = {}

	self.top_position = top_position and vector.new(top_position) or self.top_position
	self.config       = config or self.config

	return setmetatable(self, { __index = class })
end

function Generator:run()
	local top    = self.top_position
	local config = self.config
	local method_name = config.METHOD

	top = top:add(0.5):floor()

	if top.y <= config.Y0 then
		Logger.warning('Trying to build negative mountain')
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
			config.rk_big
		)

	else
		Logger.error('unknown method: ' .. tostring(method_name))
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
					if can_place_dirt(data[i]) then
						data[i] = Node.get_coverage(position, config)
					end
				elseif position.y == height + 1 then
					if can_place_plant(data[i]) then
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


return Generator
