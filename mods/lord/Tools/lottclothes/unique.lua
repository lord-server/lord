local S        = minetest.get_mod_translator()
local colorize = minetest.colorize


local legendry_color   = '#fa4'
local phrase_color     = '#aaa'
local collection_color = '#99c'


core.register_tool(':lord_uniq_clothes:mt_guardian_cloak', {
		description     =
			colorize(legendry_color, S('Cloak "Guardian of Minas Tirith"')) .. '\n' ..
			colorize(phrase_color,
				S('When the Guardian squares his shoulders,') .. '\n' ..
				S('    the cloak spreads like the wings of an eagle —') .. '\n' ..
				S('    a herald of the coming victory.')
			) .. '\n\n' ..
			colorize(collection_color, S('Unique collection: "Guardian of Minas Tirith"'))
		,
		inventory_image = 'lord_uniq_clothes_mt_guardian_cloak_inv.png',
		groups          = { clothes = 1, no_preview = 1, clothes_cloak = 1, physics_speed = 0.02 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_helmet', {
		description     =
			colorize(legendry_color, S('Helmet "Guardian of Minas Tirith"')) .. '\n' ..
			colorize(phrase_color,
				S('The burden of the sentry is arduous yet honorable—to peer, day and night,') .. '\n' ..
				S('into the misty distance from beneath the steel brows of a heavy helmet.')
				) .. '\n\n' ..
				colorize(collection_color, S('Unique collection: "Guardian of Minas Tirith"'))
			,
		inventory_image = 'lord_uniq_clothes_mt_guardian_helmet_inv.png',
		groups          = { armor_head = 0, defense_fleshy = 11 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_chestplate', {
		description     =
			colorize(legendry_color, S('Chestplate "Guardian of Minas Tirith"')) .. '\n' ..
			colorize(phrase_color,
				S('Steel pauldrons and breastplates will absorb thousands of blows,') .. '\n' ..
				S('they will not allow a single heavy strike to reach the Tree or the King!')
				) .. '\n\n' ..
				colorize(collection_color, S('Unique collection: "Guardian of Minas Tirith"'))
			,
		inventory_image = 'lord_uniq_clothes_mt_guardian_chestplate_inv.png',
		groups          = { armor_torso = 0, defense_fleshy = 14 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_leggins', {
		description     =
			colorize(legendry_color, S('Leggins "Guardian of Minas Tirith"')).. '\n' ..
			colorize(phrase_color,
				S('They firmly clasped the guard’s strong legs,') .. '\n' ..
				S('accustomed to long watches.')
				) .. '\n\n' ..
				colorize(collection_color, S('Unique collection: "Guardian of Minas Tirith"'))
			,
		inventory_image = 'lord_uniq_clothes_mt_guardian_leggins_inv.png',
		groups          = { armor_legs = 0, defense_fleshy = 8 },
		wear            = 0,
})

core.register_tool(':lord_uniq_clothes:mt_guardian_boots', {
		description     =
			colorize(legendry_color, S('Boots "Guardian of Minas Tirith"')).. '\n' ..
			colorize(phrase_color,
				S('The guardian stands firm, both in marble halls and on the battlefield!')
				) .. '\n\n' ..
				colorize(collection_color, S('Unique collection: "Guardian of Minas Tirith"'))
			,
		inventory_image = 'lord_uniq_clothes_mt_guardian_boots_inv.png',
		groups          = { armor_feet = 0, defense_fleshy = 6 },
		wear            = 0,
})