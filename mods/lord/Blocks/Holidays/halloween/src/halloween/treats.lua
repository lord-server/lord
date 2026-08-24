local S        = core.get_mod_translator()
local spec     = core.formspec
local colorize = core.colorize


local function register_treats()
	local candy_treat_title             = colorize('#B380FF', S('Candy Treat'))
	local exchange_it_message           = S('Exchange it for gifts at the spawn store')
	local seasonable_collection_message = colorize('#B380FF', S('Halloween collection'))

	core.register_craftitem('halloween:candy_treat', {
		description     = candy_treat_title .. '\n' .. seasonable_collection_message,
		inventory_image = 'halloween_candy_treat.png',
		on_use          = function(itemstack, user)
			if not user or not user:is_player() then
				return itemstack
			end
			--- @cast user Player -- we checked it above, that user is Player
			local player_name = user:get_player_name()

			if not player_name or player_name == '' then
				return itemstack
			end

			local formspec = spec.formspec_version(4)
				.. spec.size(7, 3)
				.. spec.label(0.5, 0.6, candy_treat_title)
				.. spec.label(0.5, 1.2, exchange_it_message)
				.. spec.button_exit(2, 1.9, 3, 0.8, 'close', 'OK')

			core.show_formspec(player_name, 'candy_treat_message', formspec)

			return itemstack
		end,
	})
end


return {
	register = register_treats,
}
