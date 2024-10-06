

minetest.mod(function(mod)
	local spec = minetest.formspec

	local formspec_prepend = ''
		.. spec.bgcolor('#000c', 'true')
		.. spec.background9(5, 5, 1, 1, 'gui_formbg.png', 'true', 10)
		.. spec.listcolors('#0007', '#5a5a5a', '#141318', '#1238', '#fffc')
		.. spec.style_type('button', {
			bgimg        = 'button_bg.png',
			bgimg_middle = 4,
			font         = 'bold',
			textcolor    = '#fffc',
			padding      = '0',
		})
		-- as for now, this styles is not supported by MT
		--.. spec.style_type({'field', 'field:focused', 'field:hovered', 'field:pressed'}, {
		--	bgcolor = '#600',
		--	bgcolor_hovered = '#000',
		--	bgcolor_pressed = '#000',
		--	padding = 0
		--})

	minetest.register_on_joinplayer(function(player)
		player:set_formspec_prepend(formspec_prepend)
	end)

end)
