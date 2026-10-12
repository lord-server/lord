local S = core.get_mod_translator()


item_collection.Id.GUARDIAN_OF_MINAS_TIRITH = 'guardian_of_minas_tirith'
item_collection.register(item_collection.Id.GUARDIAN_OF_MINAS_TIRITH, {
	title = S('Unique collection: "Guardian of Minas Tirith"'),
	color = '#99c',
})

core.register_tool(':lord_uniq_clothes:mt_guardian_cloak', {
		description     = S('Cloak "Guardian of Minas Tirith"'),
		_rank           = item_rank.Type.LEGENDARY,
		_annotation     =
			S('When the Guardian squares his shoulders,') .. '\n' ..
			S('    the cloak spreads like the wings of an eagle —') .. '\n' ..
			S('    a herald of the coming victory.'),
		_collection     = item_collection.Id.GUARDIAN_OF_MINAS_TIRITH,
		inventory_image = 'lord_uniq_clothes_mt_guardian_cloak_inv.png',
		groups          = { clothes = 1, no_preview = 1, clothes_cloak = 1, physics_speed = 0.02 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_helmet', {
		description     = S('Helmet "Guardian of Minas Tirith"'),
		_rank           = item_rank.Type.LEGENDARY,
		_annotation     =
			S('The burden of the sentry is arduous yet honorable—to peer, day and night,') .. '\n' ..
			S('into the misty distance from beneath the steel brows of a heavy helmet.'),
		_collection     = item_collection.Id.GUARDIAN_OF_MINAS_TIRITH,
		inventory_image = 'lord_uniq_clothes_mt_guardian_helmet_inv.png',
		groups          = { armor_head = 0, defense_fleshy = 11 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_chestplate', {
		description     = S('Chestplate "Guardian of Minas Tirith"'),
		_rank           = item_rank.Type.LEGENDARY,
		_annotation     =
			S('Steel pauldrons and breastplates will absorb thousands of blows,') .. '\n' ..
			S('they will not allow a single heavy strike to reach the Tree or the King!'),
		_collection     = item_collection.Id.GUARDIAN_OF_MINAS_TIRITH,
		inventory_image = 'lord_uniq_clothes_mt_guardian_chestplate_inv.png',
		groups          = { armor_torso = 0, defense_fleshy = 14 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_leggins', {
		description     = S('Leggins "Guardian of Minas Tirith"'),
		_rank           = item_rank.Type.LEGENDARY,
		_annotation     =
			S('They firmly clasped the guard’s strong legs,') .. '\n' ..
			S('accustomed to long watches.'),
		_collection     = item_collection.Id.GUARDIAN_OF_MINAS_TIRITH,
		inventory_image = 'lord_uniq_clothes_mt_guardian_leggins_inv.png',
		groups          = { armor_legs = 0, defense_fleshy = 8 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_boots', {
		description     = S('Boots "Guardian of Minas Tirith"'),
		_rank           = item_rank.Type.LEGENDARY,
		_annotation     =
			S('The guardian stands firm, both in marble halls and on the battlefield!'),
		_collection     = item_collection.Id.GUARDIAN_OF_MINAS_TIRITH,
		inventory_image = 'lord_uniq_clothes_mt_guardian_boots_inv.png',
		groups          = { armor_feet = 0, defense_fleshy = 6 },
		wear            = 0,
})
