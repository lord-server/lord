
-- moved AS IS from lottpotion.
lottpotion_recipe = {}
lottpotion_recipe.types = {}

function lottpotion_recipe.register_type(typename, origdata)
	lottpotion_recipe.types[typename] = table.overwrite({
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
	local default_time = lottpotion_recipe.types[typename].default_time
	local recipe = { time = data.time or default_time, input = {}, output = data.output }
	for _, stack in ipairs(data.input) do
		recipe.input[ItemStack(stack):get_name()] = ItemStack(stack):get_count()
	end

	lottpotion_recipe.types[typename].recipes[index] = recipe
end

function lottpotion_recipe.register(typename, data)
	minetest.after(0.01, register_recipe, typename, data) -- Handle aliases
end

function lottpotion_recipe.get(typename, items)
	local index  = get_recipe_index(items)
	local recipe = lottpotion_recipe.types[typename].recipes[index]
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
