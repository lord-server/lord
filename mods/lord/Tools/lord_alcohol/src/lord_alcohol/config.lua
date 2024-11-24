
--- @class lord_alcohol.config.potion
--- @field item_name string
--- @field satiety   number

--- @class lord_alcohol.config.recipe
--- @field item_name string
--- @field satiety   number

--- @class lord_alcohol.config
--- @field potions lord_alcohol.config.potion[]
--- @field recipes {input:string[],output:string}[]


--- @type lord_alcohol.config
local config = {
	potions = {
		{ item_name = 'lord_alcohol:wine',  satiety =  9 },
		{ item_name = 'lord_alcohol:beer',  satiety =  8 },
		{ item_name = 'lord_alcohol:ale',   satiety =  9 },
		{ item_name = 'lord_alcohol:mead',  satiety = 15 },
		{ item_name = 'lord_alcohol:cider', satiety =  9 },
	},
	recipes = {
		{
			input  = { 'lottfarming:berries 5', 'lord_vessels:drinking_glass_water' },
			output = 'lord_alcohol:wine'
		},
		{
			input  = { 'farming:wheat0 3', 'lord_vessels:drinking_glass_water' },
			output = 'lord_alcohol:beer'
		},
		{
			input  = { 'bees:bottle_honey 6', 'lord_vessels:drinking_glass_water' },
			output = 'lord_alcohol:mead'--, 'vessels:glass_bottle 6'
		},
		{
			input  = { 'default:apple 5', 'lord_vessels:drinking_glass_water' },
			output = 'lord_alcohol:cider'
		},
		{
			input  = { 'lottfarming:barley_seed 6', 'lord_vessels:drinking_glass_water' },
			output = 'lord_alcohol:ale'
		},
	},
}


return config
