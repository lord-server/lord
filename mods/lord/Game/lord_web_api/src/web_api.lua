local Api    = require("web_api.Api")
local config = require("web_api.config")

web_api = nil

--- @param conf lord_web_api.config
--- @return http.Client
local function register_api()
	if not config then
		minetest.log("warning", "Can't initialize `web_api`: `config` not loaded.")
		return
	end

	local client = http.Client:new(config.base_url)

	_G.web_api = Api:new(client)
end


return {
	init = function()
		register_api()
	end,
}
