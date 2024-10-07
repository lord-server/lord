

--- @alias forms.DefaultStyle.config minetest.FormSpec.Style[]|table<string,minetest.FormSpec.Style>

--- @type forms.DefaultStyle.config
local config = {
	--- @type minetest.FormSpec.Style
	label  = { font = 'normal', font_size = '+0', textcolor = '#fff', --[[noclip = 'false'--]] },
	button = {
		bgimg        = 'button_bg.png',
		bgimg_middle = 4,
		font         = 'bold',
		textcolor    = '#fffc',
		padding      = '0',
	},
	--- @type minetest.FormSpec.Style
	some = {

	}

	-- as for now, this styles is not supported by MT
	--.. spec.style_type({'field', 'field:focused', 'field:hovered', 'field:pressed'}, {
	--	bgcolor = '#600',
	--	bgcolor_hovered = '#000',
	--	bgcolor_pressed = '#000',
	--	padding = 0
	--})
}


return config
