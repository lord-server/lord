

--- @alias forms.DefaultStyle.elements_config minetest.FormSpec.Style[]|table<string,minetest.FormSpec.Style>

local config = {
	--- @type forms.DefaultStyle.elements_config
	elements = {
		--- @type minetest.FormSpec.Style
		label  = {
			font = 'normal', font_size = '+0', textcolor = '#fffffff0', --[[noclip = 'false'--]]
		},
		--- @type minetest.FormSpec.Style
		button = {
			bgimg        = 'button_bg.png',
			bgimg_middle = 4,
			font         = 'bold',
			textcolor    = '#fffc',
			padding      = '0',
		},
		--- @type minetest.FormSpec.Style
		textarea = {
			font = 'normal', font_size = '+0', textcolor = '#fffffff0',
		},

		-- as for now, this styles is not supported by MT
		--[{'field', 'field:focused', 'field:hovered', 'field:pressed'}] = {
		--	bgcolor = '#600',
		--	bgcolor_hovered = '#000',
		--	bgcolor_pressed = '#000',
		--	padding = 0
		--},
	},

	params = {
		bgcolor     = { '#000c', 'true', },
		background9 = { 5, 5, 1, 1, 'gui_formbg.png', 'true', 10 },
		listcolors  = { '#0007', '#5a5a5a', '#141318', '#1238', '#fffc' },
	},
}


return config
