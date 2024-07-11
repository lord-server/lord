local Client   = require("http.Client")
local Resource = require("http.Resource")

http = {}

local function register_api(http_api, debug_mode)
	_G.http = {
		Client   = Client.init(http_api, debug_mode),
		Resource = Resource,
	}
end


return {
	init = function(http_api)
		local http_debug_mode = minetest.settings:get_bool("http.debug", false)
		register_api(http_api, http_debug_mode)
	end,
}
