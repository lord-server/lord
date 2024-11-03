local api = require("archery.api")

archery = {}

local function register_api()
	_G.archery = api
end

return {
	init = function()
		register_api()
	end,
}
