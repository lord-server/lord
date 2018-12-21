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

function grinder.get_grinder_active_formspec(percent, item_percent)
	local formspec =
	"size[8,9]"..
			"image[5.25,1.1;1,1;default_furnace_inv.png^default_furnace_fire_bg.png^[lowpart:"..(100-percent)..":default_furnace_fire_fg.png]"..
			"image[1.5,1.6;1,1;gui_furnace_arrow_bg.png^[lowpart:"..(item_percent)..":gui_furnace_arrow_fg.png^[transformR180]"..
			"list[current_name;fuel;5.25,2.1;1,1;]"..
			"list[current_name;src;1.5,0.5;1,1;]"..
			"list[current_name;dst;1,3.5;2,1;]"..
			"list[current_name;dst;1,2.5;2,1;2]"..
			"list[current_player;main;0,5;8,4;]"..
			"listring[current_name;fuel]"..
			"listring[current_player;main]"..
			"listring[current_name;src]"..
			"listring[current_player;main]"..
			"listring[current_name;dst]"..
			"listring[current_player;main]"..
			"background[-0.5,-0.65;9,10.35;gui_grinderbg.png]"..
			"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
	return formspec
end

grinder.grinder_inactive_formspec =
"size[8,9]"..
		"image[5.25,1.1;1,1;default_furnace_inv.png^default_furnace_fire_bg.png]"..
		"list[current_name;fuel;5.25,2.1;1,1;]"..
		"list[current_name;src;1.5,0.5;1,1;]"..
		"list[current_name;dst;1,3.5;2,1;]"..
		"list[current_name;dst;1,2.5;2,1;2]"..
		"list[current_player;main;0,5;8,4;]"..
		"listring[current_name;fuel]"..
		"listring[current_player;main]"..
		"listring[current_name;src]"..
		"listring[current_player;main]"..
		"listring[current_name;dst]"..
		"listring[current_player;main]"..
		"background[-0.5,-0.65;9,10.35;gui_grinderbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

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
