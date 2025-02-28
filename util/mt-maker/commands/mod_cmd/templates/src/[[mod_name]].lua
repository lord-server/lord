local api    = require('[[mod_name]].api')
local config = require('[[mod_name]].config')


[[mod_name]] = {} -- luacheck: ignore unused global variable [[mod_name]]

local function register_api()
	_G.[[mod_name]] = api
end


return {
--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
}
