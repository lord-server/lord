local SL = lord.require_intllib()


grinder = {}

require('grinder.Recipe')
local node = require('grinder.node')

--- register crafting mechanism ---
minetest.register_craft({
	output = 'grinder:roll',
	recipe = {
		{'default:steel_ingot', 'default:diamond', 'default:steel_ingot'},
		{'carts:gear', 'default:steel_ingot', 'carts:gear'},
		{'default:diamond', 'default:steel_ingot', 'default:diamond'},
	}
})

minetest.register_craft({
	output = 'grinder:grinder',
	recipe = {
		{'grinder:roll', '', 'grinder:roll'},
		{'default:steel_ingot', 'carts:gear', 'default:steel_ingot'},
		{'default:obsidian', 'carts:steam_mechanism', 'default:obsidian'},
	}
})

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

minetest.register_craftitem("grinder:coal_dust", {
	description = SL("Coal dust"),
	inventory_image = "grinder_coal_dust.png",
	groups = {fuel=1,coal=1},
})

minetest.register_craft({
	type = "fuel",
	recipe = "grinder:coal_dust",
	burntime = 50,
})

minetest.register_craftitem("grinder:roll", {
	description = SL("Roll"),
	inventory_image = "grinder_roll.png",
})
