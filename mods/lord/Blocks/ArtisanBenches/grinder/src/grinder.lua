local craft   = require('grinder.definition.craft')
local node    = require('grinder.definition.node')
local form    = require('grinder.definition.node.form')
local recipes = require('grinder.definition.recipes')


local function register_craft()
	for _, craftRecipe in pairs(craft.recipes) do
		core.register_craft(craftRecipe)
	end
	for _, item in pairs(craft.items) do
		core.register_craftitem(item.name, item.definition)
	end
end

local function register_recipes()
	for _, data in pairs(recipes) do
		core.register_craft({
			method = core.CraftMethod.GRINDER,
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
		core.CraftMethod.GRINDER,
		{
			inactive = { node_name = 'grinder:grinder',        definition = node.inactive },
			active   = { node_name = 'grinder:grinder_active', definition = node.active   },
		},
		form,
		{ dst = 4 }
	)
end


return {
	--- @param mod core.Mod
	init = function(mod)
		core.CraftMethod.GRINDER = 'grinder'
		core.register_craft_method(core.CraftMethod.GRINDER)
		register_craft()
		register_recipes()
		register_nodes(mod.translator)
	end
}
