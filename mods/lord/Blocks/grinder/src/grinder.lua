local craft     = require('grinder.definition.craft')
local node      = require('grinder.definition.node')
local recipes   = require('grinder.definition.recipes')

local Recipe    = require('grinder.Recipe')


local function register_craft()
	for _, craftRecipe in pairs(craft.recipes) do
		minetest.register_craft(craftRecipe)
	end
	for _, item in pairs(craft.items) do
		minetest.register_craftitem(item.name, item.definition)
	end
end

local function register_recipes()
	Recipe.register_recipes(recipes)
end

local function register_nodes()
	minetest.register_node("grinder:grinder", node.inactive)
	minetest.register_node("grinder:grinder_active", node.active)
end


return {
	init = function()
		register_craft()
		register_recipes()
		register_nodes()
	end
}
