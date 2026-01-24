local S = minetest.get_mod_translator()
local colorize = minetest.colorize
local violet = '#87d'
local grey = '#aaa'

minetest.register_tool('tools:sword_elven', {
	description       =
		colorize(violet, S('"Andúril"'))..' '..colorize(grey, S('("Narsil")'))..'\n'..'\n'..
		colorize(grey,
			S('Reforged from the shards of Narsil.')..'\n'..
			S('The song of its blade is heard only by the dead.')..'\n'..
			S('Fatal to those who broke their oath and found no rest.')
		),
	inventory_image   = 'tools_sword_elven.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 1.60, [2] = 1.30, [3] = 0.90 }, uses = 50, maxlevel = 3 }, },
		damage_groups       = { soul = 4, fleshy = 6.2 },
		full_punch_interval = 1,
	},
	groups            = { bronze_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:sword_orcish', {
	description       =
		colorize(violet, S('"Morgul Blade"'))..'\n'..'\n'..
		colorize(grey,
			S('Forged in the terror of Morgul,')..'\n'..
			S('its edge steeped in the ancient poison of the Black Speech.')..'\n'..
			S('With its wound comes cold and death beyond healing.')..'\n'..
			S('Its wounds do not close – they only kill, slowly.')
		),
	inventory_image   = 'tools_sword_orcish.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 1.60, [2] = 1.30, [3] = 0.90 }, uses = 50, maxlevel = 3 }, },
		damage_groups       = { poison = 4, fleshy = 6 },
		full_punch_interval = 1,
	},
	groups            = { steel_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:battleaxe_dwarven', {
	description       =
		colorize(violet, S('"Durin’s Axe"'))..'\n'..'\n'..
		colorize(grey,
				S('An axe wrought in the depths of Khazad-dûm,')..'\n'..
				S('its weight shatters even stone gates.')..'\n'..
				S('Its strike is like a mountain’s collapse – swift and inevitable.')
			),
	inventory_image   = 'tools_battleaxe_dwarf.png',
	tool_capabilities = {
		max_drop_level      = 1,
		groupcaps           = {
			choppy = { times = { [1] = 2.10, [2] = 0.90, [3] = 0.50 }, uses = 20, maxlevel = 3 },
			snappy = { times = { [1] = 1.90, [2] = 0.90, [3] = 0.30 }, uses = 20, maxlevel = 3 },
		},
		damage_groups       = { fleshy = 25 },
		full_punch_interval = 2.0,
	},
	groups            = { steel_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:sword_human', {
	description       =
		colorize(violet, S('"Flame of Númenor"'))..'\n'..'\n'..
		colorize(grey,
			S('Forged in imitation of the legendary weapons of the West.')..'\n'..
			S('Its blade burns with a heat that scars even stone.')
		),
	inventory_image   = 'tools_sword_human.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 2.25, [2] = 1.80, [3] = 1.30 }, uses = 17, maxlevel = 3 }, },
		damage_groups       = { fire = 2, fleshy = 7.8 },
		full_punch_interval = 1.2,
	},
	groups            = { mithril_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:dagger_hobbit', {
	description         =
		colorize(violet, S('"Took’s Blade"'))..'\n'..'\n'..
		colorize(grey,
			S('Light as a feather and swift as a squirrel.')..'\n'..
			S('For centuries, hobbits guarded it as an heirloom.')..'\n'..
			S('In deft hands, it is as deadly as a warrior’s sword.')..'\n'..
			S('Those who laugh at it die in surprise.')
		),
	inventory_image     = 'tools_dagger_hobbit.png',
	range               = 3,
	tool_capabilities = {
		max_drop_level      = 0,
		groupcaps           = { snappy = { times = { [2] = 2.25, [3] = 1.75 }, uses = 15, maxlevel = 1 }, },
		damage_groups       = { fleshy = 2 },
		full_punch_interval = .2
	},
	groups            = { mithril_item = 1, forbidden = 1 },
})

minetest.register_craft({
	method   = minetest.CraftMethod.ANVIL,
	output   = 'tools:sword_elven',
	for_race = races.name.ELF,
	recipe   = {
		{ '',                     'default:steel_ingot', ''                     },
		{ 'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot' },
		{ 'default:mese_crystal', 'group:stick',         'default:mese_crystal' },
	}
})
minetest.register_craft({
	method   = minetest.CraftMethod.ANVIL,
	output   = 'tools:sword_orcish',
	for_race = races.name.ORC,
	recipe   = {
		{ '', 'default:steel_ingot', '' },
		{ 'default:obsidian_shard', 'default:steel_ingot', 'default:obsidian_shard' },
		{ 'default:mese_crystal', 'bones:bone', 'default:mese_crystal' },
	}
})
minetest.register_craft({
	method   = minetest.CraftMethod.ANVIL,
	output   = 'tools:battleaxe_dwarven',
	for_race = races.name.DWARF,
	recipe   = {
		{ 'lottores:mithril_ingot', 'default:mese_crystal', 'lottores:mithril_ingot' },
		{ 'lottores:mithril_ingot', 'group:stick',          'lottores:mithril_ingot' },
		{ '',                       'group:stick',          '' }
	}
})
minetest.register_craft({
	method   = minetest.CraftMethod.ANVIL,
	output   = 'tools:sword_human',
	for_race = races.name.HUMAN,
	recipe   = {
		{ '',                  'lottores:mithril_ingot', ''                  },
		{ 'lottores:red_gem',  'lottores:mithril_ingot', 'lottores:red_gem'  },
		{ 'lottores:blue_gem', 'group:stick',            'lottores:blue_gem' },
	}
})
minetest.register_craft({
	method   = minetest.CraftMethod.ANVIL,
	for_race = races.name.HOBBIT,
	output   = 'tools:dagger_hobbit',
	recipe   = {
		{ '',                     'default:mese_crystal', ''                     },
		{ 'default:mese_crystal', 'tools:dagger_mithril', 'default:mese_crystal' },
		{ '',                     '',                     ''                     }
	},
})
