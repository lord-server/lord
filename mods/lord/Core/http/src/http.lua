local Client = require("http.Client")

http = {}

local function register_api()
	_G.http = {
		Client = Client,
	}
end


return {
	init = function()
		register_api()
	end,
}
