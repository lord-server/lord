local DefaultStyle = require('forms.DefaultStyle')
local spec         = minetest.formspec


local formspec_prepend = ''


local function build_formspec_prepend()
	formspec_prepend = ''
		.. spec.bgcolor(DefaultStyle.get_params_for('bgcolor'))
		.. spec.background9(DefaultStyle.get_params_for('background9'))
		.. spec.listcolors(DefaultStyle.get_params_for('listcolors'))

	for selectors, style in DefaultStyle.list() do
		formspec_prepend = formspec_prepend
			.. spec.style_type(selectors, DefaultStyle.get(selectors))
	end
end


return {
	register = function()
		minetest.register_on_mods_loaded(build_formspec_prepend)

		minetest.register_on_joinplayer(function(player)
			player:set_formspec_prepend(formspec_prepend)
		end)
	end,
}
