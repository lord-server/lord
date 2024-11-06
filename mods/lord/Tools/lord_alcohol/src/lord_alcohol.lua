local api    = require("lord_alcohol.api")
local config = require("lord_alcohol.config")


lord_alcohol = {} -- luacheck: ignore unused global variable lord_alcohol

local function register_api()
	_G.lord_alcohol = api
end

local function register_lord_alcohol()
	for _, alcohol in pairs(config) do
		api.register(alcohol.item_name, alcohol.satiety)
	end
end

local function register_recipes()
	-- just moved AS IS from `lottpotion`. TODO: move to config & API
	local recipes = {
		--Base Potion
		{ "lottfarming:berries 5", "lord_vessels:drinking_glass_water", "lord_alcohol:wine" },
		{ "farming:wheat0 3", "lord_vessels:drinking_glass_water", "lord_alcohol:beer" },
		{ "bees:bottle_honey 6", "lord_vessels:drinking_glass_water", "lord_alcohol:mead", "vessels:glass_bottle 6" },
		{ "default:apple 5", "lord_vessels:drinking_glass_water", "lord_alcohol:cider" },
		{ "lottfarming:barley_seed 6", "lord_vessels:drinking_glass_water", "lord_alcohol:ale" },
	}

	for _, data in pairs(recipes) do
		lottpotion_recipe.register("brew", {
			input = { data[1], data[2] },
			output = data[3],
			time = data[5],
		})
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
