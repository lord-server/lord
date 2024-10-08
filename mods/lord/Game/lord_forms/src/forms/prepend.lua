local DefaultStyle = require('forms.DefaultStyle')
local spec         = minetest.formspec


local formspec_prepend = ''


local function build_formspec_prepend()
	formspec_prepend = ''
		.. spec.bgcolor('#000c', 'true')
		.. spec.background9(5, 5, 1, 1, 'gui_formbg.png', 'true', 10)
		.. spec.listcolors('#0007', '#5a5a5a', '#141318', '#1238', '#fffc')

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
