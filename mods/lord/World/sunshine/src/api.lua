

--- @class sunshine.Api
local Api = {
	--- Array for managing volumetric light parameters.
	light = {},

	--- Array for managing bloom effect parameters.
	bloom ={},

	--- Array for setting up default Luanti light parameters.
	reset = {},
}
function Api.light.set_for(player, value)
	player:set_lighting({
		volumetric_light = { strength = value }
	})
end

--- Sets bloom effect parameters for a player.
-- @param i The intensity of the bloom effect.
-- @param s The strength factor of the bloom effect.
-- @param r The radius of the bloom effect.
function Api.bloom.set_for(player, i, s, r)
	player:set_lighting({
		bloom = {
			intensity = i,
			strength_factor = s,
			radius = r,
		},
	})
end

--- Resets lighting parameters for a player to Luanti's default values.
-- @param player The player for whom the lighting parameters are reset.
function Api.reset.set_for(player)
	player:set_lighting({
		shadows = { intensity = 0.5 },
		bloom = {
			intensity = 0.05,
			strength_factor = 1,
			radius = 1,
		},
		volumetric_light = { strength = 0.2 },
	})
end


return Api
