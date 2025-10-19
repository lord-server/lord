local skull_candle = require('lamps.skull_candle')


return {
	--- @param mod minetest.Mod
	init = function(mod)
		skull_candle.register()
	end,
}
