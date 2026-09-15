local S = core.get_mod_translator()

local mod_path = core.get_modpath(core.get_current_modname())
local require = function(name) return dofile(mod_path .. "/" .. name:gsub("%.", "/") .. ".lua") end
local candy_cane = require('candy_cane')

local gifts, christmas_date = require("configure")

--- NODES & ITEMS: -------------------------------------------
local tree_nodes = require("tree_nodes")

tree_nodes.register(christmas_date)
tree_nodes.register_replacement_abm(christmas_date, gifts)

core.register_craftitem("christmas:decorations", {
	description = S("Christmas Decorations"),
	inventory_image = "christmas_decorations.png",
})

core.register_craftitem("christmas:tree_no_decorations", {
	description = S("Fir Tree"),
	inventory_image = "christmas_tree_no_decorations.png",
})

candy_cane.register()

--- CRAFTS: ----------------------------------------------------
local item_deco = "christmas:decorations"
core.register_craft({
	output = "christmas:tree",
	recipe = {
		{item_deco, item_deco, item_deco},
		{item_deco, "christmas:tree_no_decorations", item_deco},
		{item_deco, item_deco, item_deco},
	}
})

local item_glass = "default:glass"
core.register_craft({
	output = "christmas:decorations",
	recipe = {
		{item_glass, "dye:red", item_glass},
		{"dye:blue", item_glass, "dye:green"},
	}
})

local recipe = {
	{"default:pine_sapling"},
	{"default:dirt"},
}
if core.get_modpath("lord_trees") and core.get_modpath("lord_homedecor") then
	recipe = {
		{"lord_trees:fir_sapling"},
		{"lord_homedecor:flower_pot_terracotta"},
	}
end
core.register_craft({
	output = "christmas:tree_no_decorations",
	recipe = recipe
})
