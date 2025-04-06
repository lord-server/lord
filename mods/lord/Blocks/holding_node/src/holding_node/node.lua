local S = minetest.get_mod_translator()

local definition = {
	description = S('Holding block'),

	--- @param pos Position
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string ('name', S('-'))
		meta:set_int    ('in_event_list', 1)
		meta:set_int    ('active', 0)
		meta:set_int    ('last_activate_at', 0)
		meta:set_string ('captured_by_clan', S('Nobody'))
		meta:set_int    ('captured_at', 0)
		meta:set_int    ('reward_gived_at', 0)
	end,
}


return {
	definition = definition
}
