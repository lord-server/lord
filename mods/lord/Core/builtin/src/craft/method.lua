-- Unexpectedly:
-- minetest.register_craft({ ... type = 'shaped' | 'shapeless' | 'toolrepair' | 'cooking' | 'fuel' })
-- minetest.get_craft_result({ ... method = 'normal' | 'cooking' | 'fuel' })

-- Ok, Lets try fix this. And add custom craft methods.

local assert, pairs, ipairs, next, table_contains, table_copy, table_insert, math_min, typeof
    = assert, pairs, ipairs, next, table.contains, table.copy, table.insert, math.min, type



--- @class minetest.CraftType
minetest.CraftType = {
	NORMAL  = 'normal',
	COOKING = 'cooking',
	FUEL    = 'fuel',
	REPAIR  = 'repair', -- ?
}
--- @class minetest.CraftMethod
minetest.CraftMethod = {
	--- like in minetest itself.
	DEFAULT = 'default',
}
local mt_methods = { 'normal', 'cooking', 'fuel' }


--- @class minetest.CraftRecipe
--- @field type      string     one of minetest.CraftType.<CONST>. default: `"normal"`
--- @field method    string     one of minetest.CraftMethod.<CONST>. default: `"default"` (as in minetest)
--- @field shapeless boolean    default: `false`. Not used as for now. (It will be better, if in MT it will separate)
--- @field input     string[][] array like craft grid slots with tech names of ingredients ({{`"mod:node_name"`}})
--- @field output    string     result item tech name (`"mod:node_name"`)
--- @field recipe    string[][] alias for `input` filed


--- @type minetest.CraftRecipe[][][]|table<string,table<string,minetest.CraftRecipe[]>>
local method_registered_recipes = {
	-- [method] = {
	--     [output] = {
	--         <minetest.CraftRecipe>,
	--         <minetest.CraftRecipe>,
	--         <minetest.CraftRecipe>,
	--         ...
	--     }
	-- }
}

--- @param grid string[][]
--- @param grid string[][]
local function shift_top_left(grid)
	local shift_top_on  = #grid
	local shift_left_on = #grid[1]

	-- find on how many rows & columns to shift
	for i, row in pairs(grid) do
		local row_is_empty = true
		for j, item in pairs(row) do
			if item ~= '' then
				row_is_empty = false
				shift_left_on = math_min(j - 1, shift_left_on)
			end
		end
		if not row_is_empty then
			shift_top_on = math_min(i - 1, shift_top_on)
		end
	end

	-- shift itself
	local result = {}
	for i = 1+shift_top_on, #grid do
		local row = {}
		for j = 1+shift_left_on, #grid[i] do
			row[#row+1] = grid[i][j]
		end
		result[#result+1] = row
	end

	return result
end

--- @param items ItemStack[]
--- @return string[][]
local function to_grid(items, width)
	local grid = {}
	local row = {}
	for i, item in ipairs(items) do
		row[#row+1] = item:get_name()
		if i % width == 0 then
			grid[#grid+1] = row
			row = {}
		end
	end
	if #row ~= 0 then
		grid[#grid+1] = row
		minetest.log('warning', 'Last row is less than others')
	end

	return grid
end

--- @param grid     string[][]
--- @param callback fun(item:string,row:number,col:number):boolean  return `true` for stop traverse
local function foreach_item_in_grid(grid, callback)
	for i, row in pairs(grid) do
		for j, item in pairs(row) do
			if callback(item, i, j) then  break;  end
		end
	end
end

--- Its not necessary to use this function.
--- Just use `minetest.CraftType.YOUR_TYPE = 'your-type``
--- @param name string
function minetest.register_craft_method(name)
	minetest.CraftMethod[name:upper()] = name:lower()
	method_registered_recipes[name] = {}
end


--- @param recipe minetest.CraftRecipe
local function validate_recipe_for_custom_method(recipe)
	assert(
		recipe.type == minetest.CraftType.NORMAL,
		'sorry, only default `"normal"` type currently supported for custom methods'
	)

	assert(typeof(recipe.method) == 'string', '`recipe.method` must be of type `string`')
	assert(table_contains(minetest.CraftMethod, recipe.method), 'unknown craft method: ' .. recipe.method)
	if not method_registered_recipes[recipe.method] then
		method_registered_recipes[recipe.method] = {}
	end

	assert(not recipe.shapeless, 'sorry, only shaped grid currently supported for custom methods')

	assert(next(recipe.input) == 1, '`recipe.input` must of type `table` of `table`s')
	assert(next(recipe.input[1]) == 1, '`recipe.input` must of type `table` of `table`s')
	local any_not_empty = false
	foreach_item_in_grid(recipe.input, function(item)
		assert(typeof(item) == 'string', 'all ingredients of `recipe.input` must be of type `string`')
		if item ~= '' then  any_not_empty = true  end
	end)
	assert(any_not_empty, 'at least one ingredient must be not empty string')

	assert(typeof(recipe.output) == 'string', '`recipe.output` must be of type string')

	assert(recipe.replacements == nil, 'sorry, `recipe.replacements` currently not supported for custom methods')
end

local mt_register_craft = minetest.register_craft

--- Set `recipe.method` to your own to use non MT standard craft system.
--- @param recipe minetest.CraftRecipe
function minetest.register_craft(recipe)
	local method = recipe.method or minetest.CraftMethod.DEFAULT

	-- Minetest
	if method == minetest.CraftMethod.DEFAULT then
		recipe.recipe = recipe.recipe or recipe.input
		recipe.input  = nil
		return mt_register_craft(recipe)
	end

	-- Custom
	recipe.type      = recipe.type or minetest.CraftType.NORMAL
	recipe.shapeless = recipe.shapeless == nil and false
	recipe.input     = recipe.input or recipe.recipe
	recipe.recipe = nil

	validate_recipe_for_custom_method(recipe)

	recipe.input = shift_top_left(recipe.input)

	local output_name = recipe.output:split(' ')[1]
	if (not method_registered_recipes[method][output_name]) then
		method_registered_recipes[method][output_name] = {}
	end
	table_insert(method_registered_recipes[method][output_name], recipe)

	return
end

--- @type RecipeOutput
local EMPTY_OUTPUT = { time = 0, replacements = {}, item = ItemStack("") }

--- @type fun(input: RecipeInput): RecipeOutput, RecipeInput
local mt_get_craft_result = minetest.get_craft_result


--- @param input  RecipeInput
--- @param recipe minetest.CraftRecipe
--- @return RecipeInput|nil
local function decrement_input(input, recipe)
	input = table_copy(input)
	local item_not_taken
	foreach_item_in_grid(recipe.input, function(recipe_item, i, j)
		item_not_taken = true
		for _, stack in pairs(input.items) do
			if recipe_item:starts_with('group:') then
				local group = recipe_item:split(':')[2]
				if minetest.get_item_group(stack:get_name(), group) ~= 0 then
					stack:take_item()
					item_not_taken = false
				end
			else
				if stack:get_name() == recipe_item then
					stack:take_item()
					item_not_taken = false
				end
			end
		end
		if item_not_taken then
			return true -- break `foreach_item_in_grid()`
		end
	end)

	if item_not_taken then
		return nil
	end

	return input
end

--- @param items_grid  string[][]
--- @param recipe_grid string[][]
--- @return boolean
local function items_is_correspond_to_recipe(items_grid, recipe_grid)
	local correspond = true
	foreach_item_in_grid(items_grid, function(item, i, j)
		local recipe_item = recipe_grid[i][j]
		if recipe_item:starts_with('group:') then
			local group = recipe_item:split(':')[2]
			if minetest.get_item_group(item, group) == 0 then
				correspond = false
				return true -- break `foreach_item_in_grid()`
			end
		else
			if item ~= recipe_item then
				correspond = false
				return true -- break `foreach_item_in_grid()`
			end
		end
	end)

	return correspond
end

--- @param input RecipeInput you can use your own `input.method`
--- @return RecipeOutput, RecipeInput
function minetest.get_craft_result(input)
	if not input.method or table_contains(mt_methods, input.method)  then
		return mt_get_craft_result(input)
	end

	if not table_contains(minetest.CraftMethod, input.method) then
		minetest.log('error', 'unknown craft method: ' .. input.method)
		return table_copy(EMPTY_OUTPUT), input
	end

	local shifted_grid = shift_top_left(to_grid(input.items, input.width))

	--- @type RecipeOutput
	local output = table_copy(EMPTY_OUTPUT)
	for output_item, recipes in pairs(method_registered_recipes[input.method]) do
		for i, recipe in pairs(recipes) do
			if items_is_correspond_to_recipe(shifted_grid, recipe.input) then
				local new_input = decrement_input(input, recipe)
				if not new_input then
					return output, input
				end

				output.item = ItemStack(recipe.output)

				return output, new_input
			end
		end
	end

	return output, input
end

-- to-do
--function minetest.get_craft_recipe(output)
--end
