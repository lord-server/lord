local public_api = require("archery.public_api")
local processor = require("archery.processor")

archery = {}

local function register_api()
	_G.archery = public_api
end

return {
	init = function()
		register_api()
		return processor
	end
}
