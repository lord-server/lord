local api = require("wield_item.api")


wield_item = {}

local function register_api()
	_G.wield_item = api
end


return {
	init = function()
		register_api()
	end,
}
