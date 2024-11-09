local potions     = require('lord_potions.config.potions')
local ingredients = require('lord_potions.config.ingredients')

--- @class lord_potions.config
--- @field potions     lord_potions.PotionGroup[]
--- @field ingredients lord_potions.Ingredient[]
local config = {
	potions     = potions,
	ingredients = ingredients,
}


return config
