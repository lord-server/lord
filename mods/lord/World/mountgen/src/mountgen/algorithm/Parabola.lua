local math_min, math_limit, math_abs, math_floor, math_ceil, math_sqrt
    = math.min, math.limit, math.abs, math.floor, math.ceil, math.sqrt

local HeightMap = require('mountgen.generator.HeightMap')
local FieldType = require('mountgen.config.FieldType')

local S = minetest.get_mod_translator()


--- @class mountgen.algorithm.Parabola.ConfigValues: mountgen.config.ValuesTable
--- @field multiplier number coefficient `k` in formula `y = - k * x^2 + b`
--- @field shift_up   number coefficient `b` in formula `y = - k * x^2 + b`
--- @field max_radius number maximum radius of generated mountain

--- @alias mountgen.ParabolaCfgValues mountgen.algorithm.Parabola.ConfigValues

--- @class mountgen.algorithm.Parabola: mountgen.AlgorithmInterface
local Parabola = {
	--- @public
	--- @const
	--- @type string
	NAME = 'parabola',
	--- @private
	--- @const
	--- @type mountgen.config.FieldDefinition[]
	CONFIG_FIELDS = {
		multiplier = {
			name        = 'multiplier',
			type        = FieldType.NUMBER,
			label       = S('Multiplier coefficient (k)'),
			description =
				S('This makes vertical stretching/compression of mountain.') .. '\n' ..
				S('Coefficient `k` in formula `y = - k * x^2 + b`')
			,
		},
		shift_up = {
			name        = 'shift_up',
			type        = FieldType.NUMBER,
			label       = S('Shift up (b)'),
			description =
				S('How much the generated mountain will be shifted up.') .. '\n' ..
				S('The mountain will be cut off at the player\'s position;') .. ' ' ..
				S('and no mountain will be generated above the player.') .. '\n' ..
				S('Parameter `b` in formula `y = - k * x^2 + b`')
			,
		},
		max_radius = {
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
		multiplier = 0.02,
		--- @type number
		shift_up   = 1,
		--- @type number
		max_radius = 20,
	}
}

--- @return string
function Parabola.get_description()
	return
		S('The `Parabola` algorithm builds a part of the mountain in the form of inverted (upside down) parabola.') .. '\n' ..
		S('It is well suited on a small scale for more detailed landscape construction.') .. '\n' ..
		S('Used formula: `y = -k * x^2 + b + mountain_height`.')
end

--- @return mountgen.config.FieldDefinition[]
function Parabola.get_config_fields()
	return Parabola.CONFIG_FIELDS
end

--- @return table
function Parabola.get_config_defaults()
	return Parabola.CONFIG_DEFAULTS
end

--- Generate mountain as cone
--- @param top_pos Position
--- @param config  mountgen.algorithm.Parabola.ConfigValues
--- @return mountgen.generator.HeightMap, number, number "height map, map size, center_coordinate"
function Parabola.build_height_map(top_pos, config)
	-- Used formula: `y = -k * x^2 + b + mountain_height`
	local n = 2                 -- pow
	local k = config.multiplier
	local b = config.shift_up

	-- Inverse formula: x = sqrt{n}((y - b - mountain_top) / -k)
	-- Inverse formula: x = ((y - b - mountain_top) / -k) ^ (1/2)
	local H = top_pos.y - config.foot_height
	-- Lets `x = 0`, so we can to calc width of mountain at the foot
	local W = math_ceil(2 * math_abs(((0 - b - H) / -k) ^ (1/n)))

	local height   = H

	local height_map_size   = math_min(W, 2 * config.max_radius)
	local height_map_radius = math_floor(height_map_size / 2)
	local height_map        = HeightMap:new(height_map_size)

	for z = 0, height_map_size - 1 do
		for x = 0, height_map_size - 1 do
			local px = x - height_map_radius
			local pz = z - height_map_radius

			local dfc = math_sqrt(px^2 + pz^2) -- distance from the center

			if dfc <= height_map_radius then
				-- Used formula: `y = -k * x^2 + b + mountain_height`
				local h = - k * dfc^n + b + height
				height_map:set_value(z, x, math_limit(h, 0, H))
			end
		end
	end

	return height_map, height_map_size, height_map_radius
end


return Parabola
