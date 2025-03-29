require('api')


local Eggs = require('config')
local colors = Eggs.colors

for _, color in ipairs(colors) do

	local color_name = color[1]
	local color_code = color[2]
	local color_ratio = color[3]

	minetest.register_craftitem("easter:egg_" .. color_name, {
		description     = 'Сollectible'..' '..color_name:gsub("^%l", string.upper)..' '..'Egg',
		inventory_image = "lottmobs_egg^[colorize:" .. color_code .. ":" .. color_ratio,
		on_use = function(itemstack, user)

			local player_name = user:get_player_name()
			local formspec = "formspec_version[4]" ..
                             "size[5,2]" ..
                             "label[0.5,0.5;You can sell this " .. color_name:gsub("^%l", string.upper) .. " Egg!]" ..
                             "button_exit[1.5,1.2;2,0.8;close;Got it!]"
			minetest.show_formspec(player_name, "egg_message", formspec)

			return itemstack
		end,
	})
end

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	local formspec = "formspec_version[4]" ..
                     "size[5,3]" ..
                     "label[0.8,0.5;Easter egg hunt begins!]" ..
                     "label[0.5,1;Send /event chat command]" ..
                     "label[1.7,1.5; and begin!]" ..
                     "button_exit[1.5,2;2,1;close;Got it!]"

	minetest.show_formspec(player_name, "event_news_message", formspec)
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "event_news_message" and fields.close then

		return
	end
end)
