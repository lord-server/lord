local S = minetest.get_mod_translator()

local form = require('grinder.definition.node.form')

return {
	paramtype2            = 'facedir',
	drop                  = 'grinder:grinder',
	groups                = { cracky = 2 },
	legacy_facedir_simple = true,
	is_ground_content     = false,
	sounds                = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('formspec', form.get('inactive'))
		meta:set_string('infotext', S('Grinder'))
		local inv = meta:get_inventory()
		inv:set_size('fuel', 1)
		inv:set_size('src', 1)
		inv:set_size('dst', 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty('fuel') then
			return false
		elseif not inv:is_empty('dst') then
			return false
		elseif not inv:is_empty('src') then
			return false
		end
		return true
	end,
}
