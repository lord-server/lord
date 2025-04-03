local S = minetest.get_mod_translator()
local egg_colors = { 'red', 'green', 'blue', 'yellow' }

for _, color in ipairs(egg_colors) do

	local egg_message_1 = minetest.colorize('#B380FF' , S('A colorful Easter egg!'))
	local egg_message_2 = S('Exchange it for gifts at the spawn store')

	minetest.register_craftitem('easter:'..color..'_egg', {
		description     = egg_message_1,
		inventory_image = 'easter_' .. color .. '_egg.png',
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
