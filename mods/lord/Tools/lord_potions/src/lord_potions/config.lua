local S = minetest.get_mod_translator()


--- @class lord_potions.PotionPower
--- @field amount   number applying effect value (depends on effect).
--- @field duration number time in seconds.

--- @class lord_potions.PotionGroup
--- @field item_name     string  technical item/node name (`"<mod>:<node>"`).
--- @field title         string  prefix to description of item.
--- @field description   string  some words you want to displayed in tooltip before properties.
--- @field color         string  color of potion liquid (bottle contents).
--- @field effect        string  one of registered `lord_effects.<CONST>` names.
--- @field is_periodical boolean whether effect has action every second or not.
--- @field powers        table<string,lord_potions.PotionPower> applied power params of Effect. (amount, duration)


--- @type lord_potions.PotionGroup[]
local config = {
	-- HEALTH
	{
		item_name = 'lord_potions:athelas_elixir', title = S('Elixir of Athelas'), color = '#bf0',
		effect = lord_effects.HEALTH,
		is_periodical = true,
		powers    = {
			['+1'] = { amount = 1, duration =  20, },
			['+2'] = { amount = 2, duration =  50, },
			['+3'] = { amount = 4, duration = 100, },
		},
		description =
			S('An ancient elixir from the West')..'\n'..
			S('    that restores health and heals wounds.')
		,
	},
	{
		item_name = 'lord_potions:orcish_brew', title = S('Orcish Brew'), color = '#400',
		effect = lord_effects.HEALTH,
		is_periodical = true,
		powers    = {
			['-1'] = { amount = -1, duration =  20, },
			['-2'] = { amount = -2, duration =  50, },
			['-3'] = { amount = -3, duration = 100, },
		},
		description =
			S('Thick toxic brew based on orc pus, corroding both body and spirit.')..'\n'..
			S('Corrodes the body from the inside and covers it with wounds from the outside.')
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
		description =
			S('An extremely refreshing and invigorating drink')..'\n'..
			S('    made from the waters of the Metedras springs.')..'\n'..
			S('A unique drink that grants the speed of the ancient trees.')
	},
	{
		item_name = 'lord_potions:spider_poison', title = S('Shelob\'s Bonds'), color = '#462',
		effect = lord_effects.SPEED,
		powers    = {
			['-1'] = { amount = -1, duration =  20, },
			['-2'] = { amount = -2, duration =  50, },
			['-3'] = { amount = -3, duration = 100, },
		},
		description =
			S('Created from the venom of Shelob\'s web,')..'\n'..
			S('    which she uses to paralyze enemies.')..'\n'..
			S('A venomous potion that binds the body like Shelob’s web.')
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
		description =
			S('А strong stimulating drink of the elves.')..'\n'..
			S('A potion that allows you to jump higher,')..'\n'..
			S('    as if invisible wings were lifting you into the air.')
	},
	{
		item_name = 'lord_potions:dol_guldur_fetters', title = S('Dol Guldur\'s Fetters'), color = '#505',
		effect = lord_effects.JUMP,
		powers    = {
			['-1'] = { amount = -1, duration =  20, },
			['-2'] = { amount = -2, duration =  50, },
			['-3'] = { amount = -3, duration = 100, },
		},
		description =
			S('A dark potion that binds the body')..'\n'..
			S('    like the heavy chains of the dungeons of Dol Guldur.')..'\n'..
			S('It weighs down your legs, making jumping impossible.')
	},
}


return config
