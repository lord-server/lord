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
