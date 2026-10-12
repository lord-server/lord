local S    = core.get_mod_translator()
local spec = core.formspec


local function register_candy_cane()
	core.register_craftitem('christmas:candy_cane', {
		description     = S('Candy Cane'),
		_rank           = item_rank.Type.EPIC,
		_annotation     =
			S('Striped like the scarf of a Bree innkeeper.') .. '\n' ..
			S('Hobbits claim it\'s the sweetest thing after the second breakfast.'),
		_collection     = item_collection.Id.CHRISTMAS,
		inventory_image = 'christmas_candy_cane.png',
		on_use          = function(itemstack, user)
			if not user then
				return itemstack
			end
			local player_name = user--[[@as Player]]:get_player_name()
			if not player_name or player_name == '' then
				return itemstack
			end

			local formspec = spec.formspec_version(4)
				.. spec.size(7, 3)
				.. spec.label(0.5, 0.6, itemstack:get_short_description())
				.. spec.label(0.5, 1.2, S('Exchange it for gifts at the spawn store'))
				.. spec.button_exit(2, 1.9, 3, 0.8, 'close', 'OK')

			core.show_formspec(player_name, 'candy_cane_message', formspec)

			return itemstack
		end,
	})
end


return {
	register = register_candy_cane,
}
