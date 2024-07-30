local minetest_registered_items
    = minetest.registered_items


local function foreach_items_with_recipes(items, callback)
	for name, item in pairs(items) do
		local recipes = minetest.get_all_craft_recipes(name)
		if recipes then
			callback(name, item, recipes)
		end
	end
end

local function foreach_recipe_with_ingredient(recipes, ingredient, callback)
	for i, recipe in pairs(recipes) do
		if recipe.items and table.contains(recipe.items, ingredient) then
			callback(recipe)
		end
	end
end

--- Returns all recipes from `item_name` ingredient.
---
--- @param ingredient  string  item technical name (fro ex. `"default:apple"`)
--- @param recursively boolean whether to search recursively or not
--- @param max_depth   number  max search depth, when search recursively. [default: `10`]
--- @param except      table   mostly internal var to no recursion in graph. This items will be ignored.
---
--- @return RecipeEntryTable[]
function minetest.get_all_craft_recipes_from(ingredient, recursively, max_depth, except)
	recursively = recursively or false
	max_depth   = max_depth   or 10
	except      = except      or {}

	local found_recipes = {}
	foreach_items_with_recipes(minetest_registered_items, function(_, _, recipes)
		foreach_recipe_with_ingredient(recipes, ingredient, function(recipe)

			local out_item_name = recipe.output:split(' ')[1]
			found_recipes[out_item_name] = recipe
			if recursively and max_depth > 0 and not except[out_item_name] then
				except[out_item_name] = true
				found_recipes = table.overwrite(
					found_recipes,
					minetest.get_all_craft_recipes_from(out_item_name, true, max_depth - 1, except)
				)
			end

		end)
	end)

	return found_recipes
end
