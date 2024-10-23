local S = minetest.get_translator(minetest.get_current_modname())


--- @class lord_potions.PotionGroup
--- @field item_name string
--- @field title     string
--- @field color     string
--- @field effect    string one of `lord_effects.<CONST>`
--- @field powers    table<string,{amount:number,duration:number}>


--- @type lord_potions.PotionGroup[]
local config = {
	-- HEALTH
	{
		item_name = 'lord_potions:athelas_brew', title = S('Athelas Brew'), color = '#bf0',
		effect = lord_effects.HEALTH,
		powers    = {
			['+1'] = { amount = 1, duration =  20, },
			['+2'] = { amount = 2, duration =  50, },
			['+3'] = { amount = 4, duration = 100, },
		},
	},
	{
		item_name = 'lord_potions:orc_draught', title = S('Orc Draught'), color = '#200',
		effect = lord_effects.HEALTH,
		powers    = {
			['-1'] = { amount = -1, duration =  20, },
			['-2'] = { amount = -2, duration =  50, },
			['-3'] = { amount = -3, duration = 100, },
		},
	},

	-- SPEED
	{
		item_name = 'lord_potions:ent_draught', title = S('Ent Draught'), color = '#0fb',
		effect = lord_effects.SPEED,
		powers    = {
			['+1'] = { amount = 1, duration =  20, },
			['+2'] = { amount = 2, duration =  50, },
			['+3'] = { amount = 3, duration = 100, },
		},
	},
	{
		item_name = 'lord_potions:spider_poison', title = S('Shelob\'s Bonds'), color = '#462',
		effect = lord_effects.SPEED,
		powers    = {
			['-1'] = { amount = -1, duration =  20, },
			['-2'] = { amount = -2, duration =  50, },
			['-3'] = { amount = -3, duration = 100, },
		},
	},

	-- JUMP
	{
		item_name = 'lord_potions:miruvor', title = S('Miruvor'), color = '#ff0',
		effect = lord_effects.JUMP,
		powers    = {
			['+1'] = { amount = 1, duration =  20, },
			['+2'] = { amount = 2, duration =  50, },
			['+3'] = { amount = 4, duration = 100, },
		},
	},
	{
		item_name = 'lord_potions:dol_guldur_fetters', title = S('Dol Guldur\'s Fetters'), color = '#404',
		effect = lord_effects.JUMP,
		powers    = {
			['-1'] = { amount = -1, duration =  20, },
			['-2'] = { amount = -2, duration =  50, },
			['-3'] = { amount = -3, duration = 100, },
		},
	},
}


return config
