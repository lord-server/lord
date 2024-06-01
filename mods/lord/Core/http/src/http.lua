local Client   = require("http.Client")
local Resource = require("http.Resource")

http = {}

local function register_api()
	_G.http = {
		Client   = Client,
		Resource = Resource,
	}
end


return {
	init = function()
		register_api()
	end,
}
