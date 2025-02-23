

--- @class sunshine.Api
local Api = {
	light = {},
	bloom ={},
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

return Api
