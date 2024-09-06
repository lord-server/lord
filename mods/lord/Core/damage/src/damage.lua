local api = require("damage.api")


damage = {} -- luacheck: ignore unused global variable damage

local function register_api()
	_G.damage = api
end


return {
	init = function()
		register_api()
	end,
}
