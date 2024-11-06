
lottpotion.type_recipes = {}

function lottpotion.register_recipe_type(typename, origdata)
	lottpotion.type_recipes[typename] = table.overwrite({
		input_size   = 1,
		output_size  = 1,
		recipes      = {},
		default_time = 1,
	}, origdata)
end

local function get_recipe_index(items)
	local l = {}
	if items ~= nil then
		for i, stack in ipairs(items) do
			l[i] = ItemStack(stack):get_name()
		end
	end
	table.sort(l)
	return table.concat(l, "/")
end

local function convert_aliases(data)
	for i, stack in ipairs(data.input) do
		data.input[i] = ItemStack(stack):to_string()
	end
	if type(data.output) == "table" then
		for i, v in ipairs(data.output) do
			data.output[i] = ItemStack(data.output[i]):to_string()
		end
	else
		data.output = ItemStack(data.output):to_string()
	end
end

local function register_recipe(typename, data)
	convert_aliases(data)

	local index  = get_recipe_index(data.input)
	local default_time = lottpotion.type_recipes[typename].default_time
	local recipe = { time = data.time or default_time, input = {}, output = data.output }
	for _, stack in ipairs(data.input) do
		recipe.input[ItemStack(stack):get_name()] = ItemStack(stack):get_count()
	end

	lottpotion.type_recipes[typename].recipes[index] = recipe
end

print(__FILE_LINE__())
function lottpotion.register_recipe(typename, data)
	minetest.after(0.01, register_recipe, typename, data) -- Handle aliases
end
print(dump(lottpotion))
print(__FILE_LINE__())

function lottpotion.get_recipe(typename, items)
	local index  = get_recipe_index(items)
	local recipe = lottpotion.type_recipes[typename].recipes[index]
	if not recipe then
		return nil
	end

	local new_input = {}
	for i, stack in ipairs(items) do
		if stack:get_count() < recipe.input[stack:get_name()] then
			return nil
		end
		new_input[i] = ItemStack(stack)
		new_input[i]:take_item(recipe.input[stack:get_name()])
	end

	return {
		time      = recipe.time,
		new_input = new_input,
		output    = recipe.output,
	}
end
