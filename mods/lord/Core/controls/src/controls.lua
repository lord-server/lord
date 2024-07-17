local api = require("controls.api")


local function register_api()
	_G.controls = api
end


return {
	init = function()
		register_api()
	end,
}
