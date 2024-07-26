local api    = require("object_state.api")

lord_object_state = {}

local function register_api()
	_G.lord_bows = api
end

return {
	init = function()
		register_api()
	end,
}
