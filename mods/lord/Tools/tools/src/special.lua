local S = minetest.get_mod_translator()

minetest.register_tool('tools:sword_urukhai', {
	description       = S('Uruk-hai Scimitar'),
	inventory_image   = 'tools_sword_urukhai.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 2.25, [2] = 1.80, [3] = 1.30 }, uses = 17, maxlevel = 3 }, },
		damage_groups       = { poison = 1.2, fleshy = 7.8 },
		full_punch_interval = 1.2,
	},
	groups            = { steel_item = 1, forbidden = 1 },
})
minetest.register_mirrored_crafts({
	--method   = minetest.CraftMethod.DEFAULT,
	output   = 'tools:sword_urukhai',
	for_race = races.name.ORC,
	recipe   = {
		{ '', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'default:steel_ingot', '' },
		{ '', 'default:mese_crystal', '' },
	}
})
