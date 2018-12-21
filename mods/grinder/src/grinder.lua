

grinder = {}

require('grinder.Recipe')
local craft = require('grinder.craft')
local node = require('grinder.node')


for _, craftRecipe in pairs(craft.recipes) do
	minetest.register_craft(craftRecipe)
end

for _, item in pairs(craft.items) do
	minetest.register_craftitem(item.name, item.definition)
end


minetest.register_node("grinder:grinder", node.inactive)

minetest.register_node("grinder:grinder_active", node.active)


--- @type Processor
local Processor = require('grinder.Processor')
minetest.register_abm({
	nodenames = {"grinder:grinder", "grinder:grinder_active"},
	interval = 1,
	chance = 1,
	action = Processor.act,
})
