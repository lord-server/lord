--- @type fun(str: string, ...)
local S = minetest.get_translator("christmas")

local mod_path = minetest.get_modpath(minetest.get_current_modname())
local require = function(name) return dofile(mod_path .. "/" .. name:gsub("%.", "/") .. ".lua") end

local gifts, christmas_date = require("configure")

--- NODES & ITEMS: -------------------------------------------
local tree_nodes = require("tree_nodes")

tree_nodes.register(christmas_date)
tree_nodes.register_replacement_abm(christmas_date, gifts)

minetest.register_craftitem("christmas:decorations", {
	description = S("Christmas Decorations"),
	inventory_image = "christmas_decorations.png",
})

minetest.register_craftitem("christmas:tree_no_decorations", {
	description = S("Fir Tree"),
	inventory_image = "christmas_tree_no_decorations.png",
})

--- CRAFTS: ----------------------------------------------------
local item_deco = "christmas:decorations"
minetest.register_craft({
	output = "christmas:tree",
	recipe = {
		{item_deco, "default:goldblock", item_deco},
		{item_deco, "christmas:tree_no_decorations", item_deco},
		{item_deco, item_deco, item_deco},
	}
})

local item_glass = "default:glass"
minetest.register_craft({
	output = "christmas:decorations",
	recipe = {
		{item_glass, "dye:red", item_glass},
		{"dye:blue", item_glass, "dye:green"},
	}
})

minetest.register_craft({
	output = "christmas:tree_no_decorations",
	recipe = {
		{"lottplants:firsapling"},
		{"lord_homedecor:flower_pot_terracotta"},
	}
})
