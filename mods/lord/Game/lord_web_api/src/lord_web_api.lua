local Api    = require("lord_web_api.Api")
local config = require('lord_web_api.config')

web_api = {}

--- @param conf lord_web_api.config
--- @return http.Client
local function init_client(conf)
	return http.Client:new(conf.base_url)
end

--- @param client http.Client
local function register_api(client)
	_G.web_api = Api:new(client)
end


return {
	init = function()
		if not config then
			return
		end

		local client = init_client(config)
		register_api(client)
	end,
}
