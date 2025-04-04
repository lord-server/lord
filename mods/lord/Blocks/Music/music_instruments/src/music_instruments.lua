local api    = require('music_instruments.api')
local config = require('music_instruments.config') -- luacheck: ignore unused local variable config
local adjuster = require('music_instruments.adjuster') -- luacheck: ignore unused local variable adjuster


music_instruments = {} -- luacheck: ignore unused global variable music_instruments

local function register_api()
	_G.music_instruments = api
end


return {
--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
}
