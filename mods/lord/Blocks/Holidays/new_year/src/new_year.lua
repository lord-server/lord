local event_cloak = require('new_year.event_cloak')

local S = core.get_mod_translator()


return {
	--- @param mod core.Mod
	init = function(mod)
		item_collection.Id.NEW_YEAR = 'new_year'
		item_collection.register(item_collection.Id.NEW_YEAR, {
			title = S('New Year collection'),
			color = '#F8B',
		})
		event_cloak.register()
	end,
}
