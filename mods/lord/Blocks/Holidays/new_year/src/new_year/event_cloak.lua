local S = minetest.get_mod_translator()


local function register_new_year_event_cloaks()
	local event_cloak_message = minetest.colorize('#B380FF', S('Cloak of the 2026'))
	local exchange_it_message = S('One of the server\'s mighty guardians') .. '\n' ..
								S('Whose power to send players into oblivion') .. '\n' ..
								S('And turn back time') .. '\n' ..
								S('Whose hands never tire of punishing with the banhammer') .. '\n' ..
								S('. . .') .. '\n' ..
								S('In rare moments of peace') .. '\n' ..
								S('He sewed this wonderful cloak for You') .. '\n' ..
								S('In honor of the New Year 2026!')
	local seasonable_collection_message = S('New Year сollection')

	minetest.register_tool('new_year:cloak_2026', {
		description     = event_cloak_message .. '\n' .. seasonable_collection_message,
		inventory_image = 'new_year_cloak_2026_inv.png',
		groups          = { clothes = 1, no_preview = 1, clothes_cloak = 1 },
		wear            = 0,
		on_use          = function(itemstack, user)

			local player_name = user:get_player_name()

			if not user or not player_name or player_name == '' then
				return itemstack
			end
			local formspec = 'formspec_version[4]' ..
				'size[8,7]' ..
				'label[0.5,0.6;' .. event_cloak_message .. ']' ..
				'label[0.5,1.2;' .. exchange_it_message .. ']' ..
				'button_exit[2.5,5.7;3,0.8;close;OK]'

			minetest.show_formspec(player_name, 'event_cloak_message', formspec)

			return itemstack
		end,
	})
end


return {
	register = register_new_year_event_cloaks,
}
