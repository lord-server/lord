

minetest.mod(function(mod)

	default.gui_bg =     'bgcolor[#080808BB;true]'
	default.gui_bg_img = 'background9[5,5;1,1;gui_formbg.png;true;10]'
	default.gui_slots =  'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'

	local formspec_prepend =
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		'style_type[button;' ..
			'bgimg=button_bg.png;' ..
			'bgimg_middle=4;' ..
			'font=bold;' ..
			'textcolor=#fffb;' ..
			'padding=0' ..
		']' ..
		''


	minetest.register_on_joinplayer(function(player)
		player:set_formspec_prepend(formspec_prepend)
	end)


end)
