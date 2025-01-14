local math_min, math_max, math_floor, math_ceil, math_sqrt, math_tan, math_rad
    = math.min, math.max, math.floor, math.ceil, math.sqrt, math.tan, math.rad

local HeightMap = require('mountgen.generator.HeightMap')
local FieldType = require('mountgen.config.FieldType')

local S = minetest.get_mod_translator()


local MIN_CONE_FOOT_DIAMETER = 3

--- @class mountgen.algorithm.Cone: mountgen.AlgorithmInterface
local Cone = {
	--- @public
	--- @const
	--- @type string
	NAME = 'cone',
	--- @private
	--- @const
	--- @type mountgen.config.FieldDefinition[]
	CONFIG_FIELDS = {
		{
			name        = 'top_radius',
			type        = FieldType.NUMBER,
			label       = S('Truncation radius'),
			description = S('Radius of top platform of truncated cone.'),
		},
		{
			name        = 'max_radius',
			type        = FieldType.NUMBER,
			label       = S('Max radius'),
			description = S('Maximum radius of generated cone.'),
		}
	},
	--- @private
	--- @const
	--- @type table
	CONFIG_DEFAULTS = {
		--- @type number
		top_radius = 7,
		--- @type number
		max_radius = 20,
	}
}

--- @return mountgen.config.FieldDefinition[]
function Cone.get_config_fields()
	return Cone.CONFIG_FIELDS
end

--- @return table
function Cone.get_config_defaults()
	return Cone.CONFIG_DEFAULTS
end

--- Generate mountain as cone
--- @param top_pos Position
--- @param config  table
--- @return mountgen.generator.HeightMap, number, number "height map, map size, center_coordinate"
function Cone.build_height_map(top_pos, config)
	local H = top_pos.y - config.foot_height               -- height of truncated cone
	local W = 2 * (config.top_radius + math_ceil(          -- width (diameter) of cone foot
		H * math_tan( math_rad(90 - config.angle) )
	))

	local diameter = math_max(W, MIN_CONE_FOOT_DIAMETER)
	local radius   = diameter / 2
	local height   = math_ceil( radius * math_tan( math_rad(config.angle) ) )  -- height of full cone (not truncated)

	local height_map_size   = math_min(W, 2 * config.max_radius)
	local height_map_radius = math_floor(height_map_size / 2)
	local height_map        = HeightMap:new(height_map_size)

	local l0 = math_sqrt(radius^2 + radius^2)

	for z = 0, height_map_size - 1 do
		for x = 0, height_map_size - 1 do
			local px = x - height_map_radius
			local pz = z - height_map_radius

			local l  = math_sqrt(px^2 + pz^2)
			if l <= height_map_radius then
				local h  = height * (1 - 2 * l / l0)
				height_map:set_value(z, x, math_min(h, H))
			end
		end
	end

	return height_map, height_map_size, height_map_radius
end


return Cone
