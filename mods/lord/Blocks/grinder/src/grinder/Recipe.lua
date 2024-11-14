
---
--- @class Recipe
---
local Recipe             = {}

--- @type table let save here grinding recipes
local registered_recipes = {}

-- -----------------------------------------------------------------------------------------------
-- Private functions:

local function get_recipe_index(items)
	local l
	for _, stack in ipairs(items) do
		l = stack:get_name()
	end
	return l
end

--- @param data string|string[]
--- @return string|string[]
local function to_ItemStack_names(data)
	if type(data) ~= "table" then
		return ItemStack(data):get_name()
	end

	local stacks = {}
	for i, _ in ipairs(data) do
		stacks[i] = ItemStack(data[i]):get_name()
	end

	return stacks
end

--- @param recipe minetest.CraftRecipe
local function register_craft(recipe)
	recipe.time = recipe.time or 120

	-- Handle aliases
	recipe.input  = to_ItemStack_names(recipe.input)
	recipe.output = to_ItemStack_names(recipe.output)

	local index = ItemStack(recipe.input):get_name()
	-- создаем таблицу рецептов, в качестве индекса имя исходного материала
	registered_recipes[index] = { time = recipe.time, input = recipe.input, output = recipe.output }
end

local function find_recipe(items)
	return registered_recipes[get_recipe_index(items)]
end

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- Returns `table {time = recipe.time, new_input = new_input, output = recipe.output}`
--- or returns `nil` if recipe not found or there is not enough items
--- @static
--- @param input RecipeInput you can use your own `input.method`
--- @return RecipeOutput|nil, RecipeInput|nil
function Recipe.get_grinding_result(input)
	local items = input.items
	if (items == nil) then
		return nil, nil
	end
	local recipe = find_recipe(items)
	-- Recipe not found
	if not recipe then
		return nil, nil
	end

	local new_input = {}
	local num_item = ItemStack(recipe.input):get_count() or 1
	for _, stack in ipairs(items) do
		if stack:get_count() < num_item then
			-- В стеке не хватает предметов
			return nil, nil
		else
			-- Будет изъято num_item
			new_input = ItemStack(stack)
			new_input:take_item(num_item)
		end
	end

	--return {time = recipe.time, new_input = new_input, output = recipe.output}
	return
		{ item = recipe.output, time = recipe.time, replacements = {} },
		{ items = { new_input }, width = 1, method = 'cooking' }
end

--- Registers grinding recipes
---
--- @static
--- @param recipes table<table>
function Recipe.register_recipes(recipes)
	for _, data in pairs(recipes) do
		register_craft({
			method = 'grinder',
			type   = 'cooking',
			input  = data[1],
			output = data[2],
			time   = data[3],
		})
	end
end

return Recipe
