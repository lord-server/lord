local jack_o_lantern = require('halloween.jack_o_lantern')


return {
	--- @param mod minetest.Mod
	init = function(mod)
		jack_o_lantern.register()
	end,
}
