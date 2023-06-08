
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

local function register_recipe(data)
	data.time = data.time or 120

	-- Handle aliases
	if type(data.input) == "table" then
		for i, _ in ipairs(data.input) do
			data.input[i] = ItemStack(data.input[i]):to_string()
		end
	else
		data.input = ItemStack(data.input):to_string()
	end

	if type(data.output) == "table" then
		for i, _ in ipairs(data.output) do
			data.output[i] = ItemStack(data.output[i]):to_string()
		end
	else
		data.output = ItemStack(data.output):to_string()
	end

	local recipe = {time = data.time, input = data.input, output = data.output}
	local index = ItemStack(data.input):get_name()
	-- создаем таблицу рецептов, в качестве индекса имя исходного материала
	registered_recipes[index] = recipe
end

local function find_recipe(items)
	return registered_recipes[get_recipe_index(items)]
end

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- Returns `table {time = recipe.time, new_input = new_input, output = recipe.output}`
--- or returns `nil` if recipe not found or there is not enough items
--- @static
--- @param items ItemStack
--- @return table|nil
function Recipe.get_grinding_result(items)
	local recipe = find_recipe(items)
	-- Recipe not found
	if not recipe then
		return {time = 0, new_input = items, output = ""}
	end

	local new_input = {}
	local num_item = ItemStack(recipe.input):get_count() or 1
	for _, stack in ipairs(items) do
		local new_item = ItemStack(stack)
		if stack:get_count() >= num_item then
			-- Будет изъято num_item
			new_item:take_item(num_item)
		end
		new_input[#new_input+1] = new_item
	end

	return {time = recipe.time, new_input = new_input, output = recipe.output}
end

--- Registers grinding recipes
---
--- @static
--- @param recipes table<table>
function Recipe.register_recipes(recipes)
	for _, data in pairs(recipes) do
		register_recipe({input = data[1], output = data[2], time = data[3]})
	end
end

return Recipe
