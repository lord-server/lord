

--- @class sunshine.Api
local Api = {
	light = {},
}
function Api.light.set_for(player, value)
	player:set_lighting({
		shadows = {},
		bloom = {},
		volumetric_light = { strength = value }
	})
end


return Api
