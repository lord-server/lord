
minetest.register_chatcommand('crafting_from', {
	params = '<ingredient:itemstring> <search_recursively:bool>',
	func   = function(name, param)
		if not param or param == '' then
			return false, '<ingredient> not specified'
		end
		param = param:split(' ')
		if not minetest.registered_items[param[1]] then
			return false, 'Unknown/unregistered `ingredient`: ' .. param[1]
		end
		local recursively = param[2] and param[2] == 'true' and true or false

		local output = ''
		for i, recipe in pairs(minetest.get_all_craft_recipes_from('lottores:salt', recursively)) do
			local out_item_name = recipe.output:split(' ')[1]
			output = output .. out_item_name .. '   (' .. minetest.colorize('grey', recipe.method) .. ')\n'
		end

		return true, output
	end
})
