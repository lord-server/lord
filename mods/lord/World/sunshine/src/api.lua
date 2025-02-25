

--- @class sunshine.Api
local Api = {
	light = {},
	bloom ={},
	reset = {},
}
function Api.light.set_for(player, value)
	player:set_lighting({
		shadows = {},
		bloom = {},
		volumetric_light = { strength = value }
	})
end

function Api.bloom.set_for(player, i, s, r)
	player:set_lighting({
		bloom = {
			intensity = i,
			strength_factor = s,
			radius = r,
		},
	})
end

function Api.reset.set_for(player)
	player:set_lighting({
		shadows = { intensity = 0.5},
		bloom = {
			intensity = 0.05,
			strength_factor = 1,
			radius = 1,
		},
		volumetric_light = { strength = 0.2 },
	})
end

return Api
