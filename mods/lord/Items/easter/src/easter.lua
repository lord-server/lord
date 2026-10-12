local S = core.get_mod_translator()
local egg_colors = { 'red', 'green', 'blue', 'yellow' }

item_collection.Id.EASTER = 'easter'
item_collection.register(item_collection.Id.EASTER, { title = S('Easter collection'), color = '#F8B' })

for _, color in ipairs(egg_colors) do

	local egg_message_2 = S('Exchange it for gifts at the spawn store')

	core.register_craftitem('easter:'..color..'_egg', {
		description     = S('A colorful Easter egg!'),
		_rank           = item_rank.Type.EPIC,
		_annotation     =
			S('Painted by hobbits for the spring feast.') .. '\n' ..
			S('Nobody in the Shire knows who hides them. Everybody looks for them.'),
		_collection     = item_collection.Id.EASTER,
		inventory_image = 'easter_' .. color .. '_egg.png',
		on_use = function(itemstack, user)

			local player_name = user:get_player_name()
			local formspec = 'formspec_version[4]' ..
							 'size[7,3]' ..
							 'label[0.5,0.6;'..itemstack:get_short_description()..']' ..
							 'label[0.5,1.2;'..egg_message_2..']' ..
							 'button_exit[2,1.9;3,0.8;close;OK]'
			core.show_formspec(player_name, 'egg_message', formspec)

			return itemstack
		end,
	})
end
