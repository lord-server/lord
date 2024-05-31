local Api = require("lord_web_api.Api")


--- @return http_client.Client
local function init_client()
	return http_client.Client:new(
		-- TODO
	)
end

--- @param client http_client.Client
local function register_api(client)
	_G.lord_web_api = Api:new(client)
end


return {
	init = function()
		local client = init_client()
		register_api(client)
	end,
}
