local S = minetest.get_mod_translator()


--- @class chests.config.Racial
--- @field title        string node title (in tooltip).
--- @field texture_type string t:`mod_name..'_racial_'..texture_type...`; icon:`texture_type..'_chest_form-icon.png'`.
--- @field race         string which race can open this chest.
--- @field craft        string|table name of craft ingredient (if `string`) or full craft `recipe`.


return {
	--- @type table<string,{}>
	racial = {
		['lord_chests:racial_hobbit']  = {
			title        = S('Hobbit Chest'),
			texture_type = 'hobbit',
			race         = 'hobbit',
			craft        = 'lord_planks:birch',
		},
		['lord_chests:racial_gondor']  = {
			title        = S('Gondorian Chest'),
			texture_type = 'gondor',
			race         = 'man',
			craft        = 'lord_planks:alder',
		},
		['lord_chests:racial_rohan']   = {
			title        = S('Rohirrim Chest'),
			texture_type = 'rohan',
			race         = 'man',
			craft        = 'lord_planks:lebethron',
		},
		['lord_chests:racial_elfloth'] = {
			title        = S('Elven (Lorien) Chest'),
			texture_type = 'elf',
			race         = 'elf',
			craft        = 'lord_planks:mallorn',
		},
		['lord_chests:racial_elfmirk'] = {
			title        = S('Elven (Mirkwood) Chest'),
			texture_type = 'elf',
			race         = 'elf',
			craft        = 'default:junglewood',
		},
		['lord_chests:racial_mordor']  = {
			title        = S('Mordor Chest'),
			texture_type = 'mordor',
			race         = 'orc',
			craft        = 'lord_rocks:mordor_stone',
		},
		['lord_chests:racial_angmar']  = {
			title        = S('Angmar Chest'),
			texture_type = 'angmar',
			race         = 'orc',
			craft        = 'lord_planks:pine',
		},
		['lord_chests:racial_dwarf']   = {
			title        = S('Dwarf Chest'),
			texture_type = 'dwarf',
			race         = 'dwarf',
			craft        = 'default:stone',
		},
	},
}
