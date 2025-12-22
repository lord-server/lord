local event_cloak = require('new_year.event_cloak')


new_year = {} -- luacheck: ignore unused global variable new_year


return {
	--- @param mod minetest.Mod
	init = function(mod)
		event_cloak.register()
	end,
}
