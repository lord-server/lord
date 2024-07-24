local Event = require("base_classes.Event")
local Form  = require("base_classes.Form")


base_classes = {} -- luacheck: ignore unused global variable base_classes

local function register_api()
	_G.base_classes = {
		Event = Event,
		Form  = Form,
	}
end


return {
	init = function()
		register_api()
	end,
}
