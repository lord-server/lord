local craft     = require('grinder.definition.craft')
local node      = require('grinder.definition.node')
local recipes   = require('grinder.definition.recipes')

local Recipe    = require('grinder.Recipe')
local Processor = require('grinder.Processor')


local function registerCraft()
	for _, craftRecipe in pairs(craft.recipes) do
		minetest.register_craft(craftRecipe)
	end
	for _, item in pairs(craft.items) do
		minetest.register_craftitem(item.name, item.definition)
	end
end

local function registerRecipes()
	Recipe.registerRecipes(recipes)
end

local function registerNodes()
	minetest.register_node("grinder:grinder", node.inactive)
	minetest.register_node("grinder:grinder_active", node.active)
	minetest.register_abm({
		nodenames = { "grinder:grinder", "grinder:grinder_active" },
		interval  = 1,
		chance    = 1,
		action    = Processor.act,
	})
end

local package = {
	init = function()
		registerCraft()
		registerRecipes()
		registerNodes()
	end
}

return package
