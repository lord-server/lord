local S = minetest.get_mod_translator()

--- @class lord_potions.PotionPower
--- @field amount   number applying effect value (depends on effect).
--- @field duration number time in seconds.

--- @class lord_potions.PotionGroup.Crafting.Ingredients
--- @field base  string name of item (+count) used for fist level. ex.: `"lord_potions:ingredient_geodes"`
--- @field mixin string name of item (+count) used for mixing for each level. ex.: `"lottfarming:athelas 3"`

--- @class lord_potions.PotionGroup.Crafting
--- @field ingredients lord_potions.PotionGroup.Crafting.Ingredients
--- @field times       number[]  array of times of cooking for each power level, ex.: `{ 120, 180, 240 }` - default.

--- @class lord_potions.PotionGroup
--- @field item_name     string  technical item/node name (`"<mod>:<node>"`), which used as prefix.
--- @field title         string  prefix to description of item.
--- @field description   string  some words you want to displayed in tooltip before properties.
--- @field color         string  color of potion liquid (bottle contents).
--- @field effect        string  one of registered `lord_effects.<CONST>` names.
--- @field is_periodical boolean whether effect has action every second or not.
--- @field powers        table<string,lord_potions.PotionPower> applied power params of Effect. (amount, duration)
--- @field crafting      {ingredients:{base:string,mixin:string},times:number[]|nil}  default time: 60.


--- @type lord_potions.PotionGroup[]
local config = {
	-- HEALTH
	{
		item_name     = 'lord_potions:athelas_elixir', title = S('Elixir of Athelas'), color = '#bf0',
		effect        = lord_effects.HEALTH,
		is_periodical = true,
		powers        = {
			['+1'] = { amount = 1, duration = 20, },
			['+2'] = { amount = 2, duration = 40, },
			['+3'] = { amount = 3, duration = 60, },
		},
		description   =
			S('An ancient elixir from the West') .. '\n' ..
			S('    that restores health and heals wounds.'),
		crafting      = {
			ingredients = { base = 'lord_potions:ingredient_geodes', mixin = 'lottfarming:athelas 3' },
		}
	},
	{
		item_name     = 'lord_potions:orcish_brew', title = S('Orcish Brew'), color = '#400',
		effect        = lord_effects.HEALTH,
		is_periodical = true,
		powers        = {
			['-1'] = { amount = -1, duration = 20, },
			['-2'] = { amount = -2, duration = 40, },
			['-3'] = { amount = -3, duration = 60, },
		},
		description   =
			S('Thick toxic brew based on orc pus, corroding both body and spirit.') .. '\n' ..
			S('Corrodes the body from the inside and covers it with wounds from the outside.'),
		crafting      = {
			ingredients = { base = 'lord_potions:ingredient_seregon', mixin = 'lottmobs:rotten_meat 5' },
		},
	},

	-- SPEED
	{
		item_name   = 'lord_potions:ent_draught', title = S('Ent Draught'), color = '#0fb',
		effect      = lord_effects.SPEED,
		powers      = {
			['+1'] = { amount = 0.5, duration = 60, },
			['+2'] = { amount = 1.0, duration = 40, },
			['+3'] = { amount = 1.5, duration = 20, },
		},
		description =
			S('An extremely refreshing and invigorating drink') .. '\n' ..
			S('    made from the waters of the Metedras springs.') .. '\n' ..
			S('A unique drink that grants the speed of the ancient trees.'),
		crafting    = {
			ingredients = { base = 'lord_potions:ingredient_geodes', mixin = 'default:leaves 10' },
		},
	},
	{
		item_name   = 'lord_potions:shelob_bonds', title = S('Shelob\'s Bonds'), color = '#462',
		effect      = lord_effects.SPEED,
		powers      = {
			['-1'] = { amount = -.3, duration = 60, },
			['-2'] = { amount = -.5, duration = 40, },
			['-3'] = { amount = -.7, duration = 20, },
		},
		description =
			S('Created from the venom of Shelob\'s web,') .. '\n' ..
			S('    which she uses to paralyze enemies.') .. '\n' ..
			S('A venomous potion that binds the body like Shelob’s web.'),
		crafting    = {
			ingredients = { base = 'lord_potions:ingredient_mordor', mixin = 'lottmobs:spiderpoison 2' },
		},
	},

	-- JUMP
	{
		item_name   = 'lord_potions:miruvor', title = S('Miruvor'), color = '#ff0',
		effect      = lord_effects.JUMP,
		powers      = {
			['+1'] = { amount = 0.5, duration = 60, },
			['+2'] = { amount = 1.0, duration = 40, },
			['+3'] = { amount = 1.5, duration = 20, },
		},
		description =
			S('А strong stimulating drink of the elves.') .. '\n' ..
			S('A potion that allows you to jump higher,') .. '\n' ..
			S('    as if invisible wings were lifting you into the air.'),
		crafting    = {
			ingredients = { base = 'lord_potions:ingredient_mese', mixin = 'lord_trees:yavannamire_fruit 2' },
		},
	},
	{
		item_name   = 'lord_potions:dol_guldur_fetters', title = S('Dol Guldur\'s Fetters'), color = '#505',
		effect      = lord_effects.JUMP,
		powers      = {
			['-1'] = { amount = -.3, duration = 60, },
			['-2'] = { amount = -.5, duration = 40, },
			['-3'] = { amount = -.7, duration = 20, },
		},
		description =
			S('A dark potion that binds the body') .. '\n' ..
			S('    like the heavy chains of the dungeons of Dol Guldur.') .. '\n' ..
			S('It weighs down your legs, making jumping impossible.'),
		crafting    = {
			ingredients = { base = 'lord_potions:ingredient_obsidian', mixin = 'lord_trees:yavannamire_fruit 2' },
		},
	},

	-- BREATH
	{
		item_name   = 'lord_potions:limpe', title = S('Limpe'), color = '#0ff',
		effect      = lord_effects.BREATH,
		powers      = {
			['+1'] = { duration = 60, },
			['+2'] = { duration = 120, },
			['+3'] = { duration = 240, },
		},
		description =
			S('Sacred drink, crafted from the dew of Telperion and Laurelin,') .. '\n' ..
			S('    grants ability to hold their breath.') .. '\n' ..
			S('Legends say it was first gifted to the Elves by Ulmo, the Lord of Waters.'),
		crafting    = {
			ingredients = { base = 'lord_potions:ingredient_mese', mixin = 'lord_trees:white_leaf 10' },
		},
	},
	{
		item_name     = 'lord_potions:morgoth_breath', title = S('Breath of Morgoth'), color = '#222',
		effect        = lord_effects.SUFFOCATION,
		is_periodical = true,
		powers        = {
			['-1'] = { amount = -1, duration = 60, },
			['-2'] = { amount = -2, duration = 40, },
			['-3'] = { amount = -3, duration = 20, },
		},
		description   =
			S('A dangerous potion that blocks breathing and causes suffocation,') .. '\n' ..
			S('    as if darkness is consuming you from within.'),
		crafting      = {
			ingredients = { base = 'lord_potions:ingredient_bonedust', mixin = 'lord_trees:yavannamire_leaf 10' },
		},
	},
}


return config
