local S = minetest.get_mod_translator()


local function register_candy_cane()
	local candy_cane_message            = minetest.colorize('#B380FF', S('Candy Cane'))
	local exchange_it_message           = S('Exchange it for gifts at the spawn store')
	local seasonable_collection_message = minetest.colorize('#B380FF', S('Christmas сollection'))

	minetest.register_craftitem('christmas:candy_cane', {
		description     = candy_cane_message .. '\n' .. seasonable_collection_message,
		inventory_image = 'christmas_candy_cane.png',
		on_use          = function(itemstack, user)
			local player_name = user:get_player_name()
			if not user or not player_name or player_name == '' then
				return itemstack
			end

			local formspec = 'formspec_version[4]' ..
				'size[7,3]' ..
				'label[0.5,0.6;' .. candy_cane_message .. ']' ..
				'label[0.5,1.2;' .. exchange_it_message .. ']' ..
				'button_exit[2,1.9;3,0.8;close;OK]'

			minetest.show_formspec(player_name, 'candy_cane_message', formspec)

			return itemstack
		end,
	})
end


return {
	register = register_candy_cane,
}
