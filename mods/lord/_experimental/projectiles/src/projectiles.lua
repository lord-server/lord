local api = require("projectiles.api")

projectiles = {}

local function register_api()
	_G.projectiles = api
end

return {
	init = function()
		register_api()
	end,
}
