local api = require('music_instruments.music_node.api')


music_instruments = {} -- luacheck: ignore unused global variable music_instruments

local function register_api()
	_G.music_instruments = api
end


return {
--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
	require('music_instruments.adjuster'),
	require('music_instruments.music_node.config'),
}
