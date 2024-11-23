-- Unexpectedly:
-- minetest.register_craft({ ... type = 'shaped' | 'shapeless' | 'toolrepair' | 'cooking' | 'fuel' })
-- minetest.get_craft_result({ ... method = 'normal' | 'cooking' | 'fuel' })

-- Ok, Lets try fix this. And add custom craft methods.

local assert, pairs, ipairs, next, table_copy, table_insert, math_min, typeof
    = assert, pairs, ipairs, next, table.copy, table.insert, math.min, type



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
--- @field recipe    string[][] alias for `input` filed.
--- @field time      number     time required for cooking. Use only for type `"cooking"`. In seconds.
--- @field cooktime  number     alias for `time` filed.


--- @type minetest.CraftRecipe[][][][]|table<string,table<string,table<string,minetest.CraftRecipe[]>>>
local method_registered_recipes = {
	-- [method] = {
	--     [type] = {
	--         [output] = {
	--             <minetest.CraftRecipe>,
	--             <minetest.CraftRecipe>,
	--             <minetest.CraftRecipe>,
	--             ...
	--         }
	--     }
	-- }
}

--- @param grid ItemStack[][]|string[][]
--- @param grid ItemStack[][]|string[][]
local function shift_top_left(grid)
	local shift_top_on  = #grid
	local shift_left_on = #grid[1]

	-- find on how many rows & columns to shift
	for i, row in pairs(grid) do
		local row_is_empty = true
		for j, item in pairs(row) do
			local str = type(item) == 'string' and item or item:get_name()
			if str ~= '' then
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
--- @return ItemStack[][]
local function to_grid(items, width)
	if not items or not width or width == 0 then
		minetest.log('error', 'Args `items` or `width` comes as `nil` or `0`')
		return {}
	end

	local grid = {}
	local row = {}
	for i, item in ipairs(items) do
		row[#row+1] = item
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

--- @param grid     ItemStack[][]|string[][]
--- @param callback fun(item:ItemStack|string,row:number,col:number):boolean  return `true` for stop traverse
local function foreach_item_in_grid(grid, callback)
	local stop_propagation = false
	for i, row in pairs(grid) do
		for j, item in pairs(row) do
			stop_propagation = callback(item, i, j)
			if stop_propagation then  break;  end
		end
		if stop_propagation then  break;  end
	end
end

--- Its not necessary to use this function.
--- Just use `minetest.CraftType.YOUR_TYPE = 'your-type``
--- @param name string
function minetest.register_craft_method(name)
	minetest.CraftMethod[name:upper()] = name:lower()
	method_registered_recipes[name:lower()] = {}
end


--- @param recipe minetest.CraftRecipe
local function validate_recipe_for_custom_method(recipe)
	assert(
		recipe.type:is_one_of({minetest.CraftType.NORMAL, minetest.CraftType.COOKING}),
		'sorry, only `"normal"` & `"cooking"` type currently supported for custom methods'
	)

	assert(typeof(recipe.method) == 'string', '`recipe.method` must be of type `string`')
	assert(recipe.method:is_one_of(minetest.CraftMethod), 'unknown craft method: ' .. recipe.method)
	if not method_registered_recipes[recipe.method] then
		method_registered_recipes[recipe.method] = {}
	end
	if not method_registered_recipes[recipe.method][recipe.type] then
		method_registered_recipes[recipe.method][recipe.type] = {}
	end

	assert(not recipe.shapeless, 'sorry, only shaped grid currently supported for custom methods')

	assert(
		next(recipe.input) == 1 and next(recipe.input[1]) == 1,
		'`recipe.input` must of type `string`, or `string[], or `string[][]'
	)
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
	recipe.recipe    = nil

	if typeof(recipe.input) == 'string' then recipe.input = { { recipe.input } } end
	if next(recipe.input[1]) ~= 1       then recipe.input =   { recipe.input }   end
	validate_recipe_for_custom_method(recipe)

	recipe.input = shift_top_left(recipe.input)

	local output_name = recipe.output:split(' ')[1]
	if (not method_registered_recipes[method][recipe.type][output_name]) then
		method_registered_recipes[method][recipe.type][output_name] = {}
	end
	table_insert(method_registered_recipes[method][recipe.type][output_name], recipe)

	return
end

--- @type RecipeOutput
local EMPTY_OUTPUT = { time = 0, replacements = {}, item = ItemStack("") }

--- @type fun(input: RecipeInput): RecipeOutput, RecipeInput
local mt_get_craft_result = minetest.get_craft_result


--- @param stack       ItemStack
--- @param recipe_item string
local function take_item(stack, recipe_item)
	recipe_item = recipe_item:split(' ')
	local recipe_item_name  =          recipe_item[1]
	local recipe_item_count = tonumber(recipe_item[2]) or 1

	if recipe_item_name:starts_with('group:') then
		local group = recipe_item_name:split(':')[2]
		if
			minetest.get_item_group(stack:get_name(), group) == 0 or
			stack:take_item(recipe_item_count):get_count() ~= recipe_item_count
		then
			return false
		end
	else
		if
			stack:get_name() ~= recipe_item_name or
			stack:take_item(recipe_item_count):get_count() ~= recipe_item_count
		then
			return false
		end
	end

	return true
end

--- @param input  RecipeInput
--- @param recipe minetest.CraftRecipe
--- @return RecipeInput|nil
local function decrement_input(input, recipe)
	input = table_copy(input)

	local item_not_taken = false

	foreach_item_in_grid(recipe.input, function(recipe_item, i, j)
		recipe_item = recipe_item or ''
		if recipe_item == '' then
			return -- skip `foreach_item_in_grid()` iteration with empty item
		end

		local stack = input.items[(i - 1) * input.width + j]
		if not stack then
			minetest.log('error', 'get_craft_result(): decrement_input() failed')
			item_not_taken = true
			return true -- break `foreach_item_in_grid()` cycle
		end

		if not take_item(stack, recipe_item) then
			item_not_taken = true
			return true -- break `foreach_item_in_grid()` cycle
		end
	end)

	if item_not_taken then
		return nil
	end

	return input
end

--- @param items_grid  ItemStack[][]
--- @param recipe_grid string[][]
--- @return boolean
local function items_is_correspond_to_recipe(items_grid, recipe_grid)
	local correspond = true
	--- @param item ItemStack
	foreach_item_in_grid(items_grid, function(item, i, j)
		local recipe_item = recipe_grid[i][j] or ''
		recipe_item = recipe_item:split(' ')
		local recipe_item_name  =          recipe_item[1]  or ''
		local recipe_item_count = tonumber(recipe_item[2]) or 1

		if recipe_item_name:starts_with('group:') then
			local group = recipe_item_name:split(':')[2]
			if
				minetest.get_item_group(item:get_name(), group) == 0 or
				item:get_count() < recipe_item_count
			then
				correspond = false
				return true -- break `foreach_item_in_grid()`
			end
		else
			if
				item:get_name() ~= recipe_item_name or
				(item:get_count() < recipe_item_count and recipe_item_name ~= '')
			then
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
	if not input.method or input.method:is_one_of(mt_methods) then
		return mt_get_craft_result(input)
	end

	if not input.method:is_one_of(minetest.CraftMethod) then
		minetest.log('error', 'unknown craft method: ' .. input.method)
		return table_copy(EMPTY_OUTPUT), input
	end

	input.type = input.type or minetest.CraftType.NORMAL

	local shifted_grid = shift_top_left(to_grid(input.items, input.width))

	--- @type RecipeOutput
	local output = table_copy(EMPTY_OUTPUT)
	for output_item, recipes in pairs(method_registered_recipes[input.method][input.type]) do
		for i, recipe in pairs(recipes) do
			if items_is_correspond_to_recipe(shifted_grid, recipe.input) then
				local new_input = decrement_input(input, recipe)
				if not new_input then
					return output, input
				end

				output.item = ItemStack(recipe.output)
				if input.type == minetest.CraftType.COOKING then
					output.time = recipe.time
				end

				return output, new_input
			end
		end
	end

	return output, input
end

-- to-do
--function minetest.get_craft_recipe(output)
--end
