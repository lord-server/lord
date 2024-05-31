local Client = require("http_client.Client")

local function register_api()
	_G.http_client = {
		Client = Client,
	}
end


return {
	init = function()
		register_api()
	end,
}
