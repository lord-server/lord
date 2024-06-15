local api    = require("lord_wooden_stuff.api")
--local config = require("lord_wooden_stuff.config")

local function register_api()
	_G.lord_wooden_stuff = api
end


return {
	init = function()
		register_api()
	end,
}
