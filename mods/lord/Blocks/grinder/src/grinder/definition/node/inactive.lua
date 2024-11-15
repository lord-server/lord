local SL = minetest.get_mod_translator()

local common              = require('grinder.definition.node.common')
local inventory_callbacks = require('grinder.definition.node.inventory_callbacks')
local form                = require('grinder.definition.node.form')


return table.merge(common, table.merge(inventory_callbacks, {
	description = SL('Grinder'),
	tiles = {
		'grinder_top.png', 'carts_steam_mechanismn.png',
		'grinder_side_left.png', 'grinder_side_right.png',
		'grinder_side.png', 'grinder_front.png'
	},

	-- backwards compatibility: punch to set formspec
	on_punch = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', SL('Grinder'))
		meta:set_string('formspec', form.get('inactive'))
	end
}))
