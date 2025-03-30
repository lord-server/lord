local S = minetest.get_mod_translator()
local colors = require('config')

for _, color in ipairs(colors) do

	local color_name = color[1]
	local color_code = color[2]
	local color_ratio = color[3]
	local egg_message_1 = S('A colorful Easter egg!')
	local egg_message_2 = S('Exchange it for gifts at the spawn store')

	minetest.register_craftitem('easter:egg_' .. color_name, {
		description     = egg_message_1,
		inventory_image = 'lottmobs_egg^[colorize:' .. color_code .. ':' .. color_ratio,
		on_use = function(itemstack, user)

			local player_name = user:get_player_name()
			local formspec = 'formspec_version[4]' ..
                             'size[7,3]' ..
                             'label[0.5,0.6;'..egg_message_1..']' ..
                             'label[0.5,1.2;'..egg_message_2..']' ..
                             'button_exit[2,1.9;3,0.8;close;OK]'
			minetest.show_formspec(player_name, 'egg_message', formspec)

			return itemstack
		end,
	})
end
