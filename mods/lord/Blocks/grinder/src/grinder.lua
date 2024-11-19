local craft   = require('grinder.definition.craft')
local node    = require('grinder.definition.node')
local form    = require('grinder.definition.node.form')
local recipes = require('grinder.definition.recipes')


local function register_craft()
	for _, craftRecipe in pairs(craft.recipes) do
		minetest.register_craft(craftRecipe)
	end
	for _, item in pairs(craft.items) do
		minetest.register_craftitem(item.name, item.definition)
	end
end

local function register_recipes()
	for _, data in pairs(recipes) do
		minetest.register_craft({
			method = minetest.CraftMethod.GRINDER,
			type   = 'cooking',
			input  = data[1],
			output = data[2],
			time   = data[3],
		})
	end
end

local function register_nodes(S)
	fuel_device.register(
		S('Grinder'),
		minetest.CraftMethod.GRINDER,
		{
			inactive = { node_name = 'grinder:grinder',        definition = node.inactive },
			active   = { node_name = 'grinder:grinder_active', definition = node.active   },
		},
		form
	)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		minetest.CraftMethod.GRINDER = 'grinder'
		minetest.register_craft_method(minetest.CraftMethod.GRINDER)
		register_craft()
		register_recipes()
		register_nodes(mod.translator)
	end
}
