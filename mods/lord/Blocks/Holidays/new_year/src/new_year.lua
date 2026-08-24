local event_cloak = require('new_year.event_cloak')


return {
	--- @param mod core.Mod
	init = function(mod)
		event_cloak.register()
	end,
}
