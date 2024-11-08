local api    = require('lord_alcohol.api')
local config = require('lord_alcohol.config')


lord_alcohol = {} -- luacheck: ignore unused global variable lord_alcohol

local function register_api()
	_G.lord_alcohol = api
end

local function register_lord_alcohol()
	for _, alcohol in pairs(config.potions) do
		api.register(alcohol.item_name, alcohol.satiety)
	end
end

local function register_recipes()
	for _, recipe in pairs(config.recipes) do
		lottpotion_recipe.register('brew', recipe)
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		register_lord_alcohol()
		register_recipes()
	end,
}
