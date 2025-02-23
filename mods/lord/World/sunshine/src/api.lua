

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
	player:set_lighting()
end

return Api
