local Client   = require("http.Client")
local Resource = require("http.Resource")

http = {}

local function register_api(http_api)
	_G.http = {
		Client   = Client.init(http_api),
		Resource = Resource,
	}
end


return {
	init = function(http_api)
		register_api(http_api)
	end,
}
