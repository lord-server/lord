
local SL = lord.require_intllib()

local KFR = 0.01

local STEEL_DC = 0.02
local MITHRIL_DC = 0.1

local ARROW_MASS = 0.5
local ARROW_VELOCITY = 30

local BOLT_MASS = 1.0
local BOLT_VELOCITY = 40

-- Arrow nodebox
local arrow_node_box = {
	type = "fixed",
	fixed = {
		-- Shaft
		{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
		--Spitze
		{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
		{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
		--Federn
		{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
		{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
		{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
		{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

		{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
		{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
		{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
		{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
	}
}

local register_arrow = function(material, material_group, dc)
	local name = "arrows:arrow_"..material
	minetest.register_craftitem(name, {
		description = SL(material.." arrow"),
		inventory_image = "lottthrowing_arrow_"..material..".png",
	})

	minetest.register_craft({
		output = name..' 16',
		recipe = {
			{'default:stick', 'default:stick', material_group..':'..material..'_ingot'},
		}
	})

	minetest.register_node(name.."_box", {
		drawtype = "nodebox",
		node_box = arrow_node_box,
		tiles = {"lottthrowing_arrow_"..material..".png",
			 "lottthrowing_arrow_"..material..".png",
			 "lottthrowing_arrow_"..material.."_back.png",
			 "lottthrowing_arrow_"..material.."_front.png",
			 "lottthrowing_arrow_"..material.."_2.png",
			 "lottthrowing_arrow_"..material..".png"},
		groups = {not_in_creative_inventory=1},
	})

	arrows:register_arrow(name, {
			texture = name.."_box",
			visual = "wielditem",
			arrow_type = "arrow",
			mass = ARROW_MASS,
			kfr = KFR,
			damage_coefficient = dc,
			velocity = ARROW_VELOCITY})
end

register_arrow("steel", "default", STEEL_DC)
register_arrow("mithril", "lottores", MITHRIL_DC)

-- Bolt nodebox --
local bolt_node_box = {
	type = "fixed",
	fixed = {
		-- Shaft
		{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
		--Spitze
		{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
		{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
		--Federn
		{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
		{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
		{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
		{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

		{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
		{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
		{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
		{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
	}
}

local register_bolt = function(material, material_group, dc)
	local name = "arrows:bolt_"..material
	minetest.register_craftitem(name, {
		description = SL(material.." bolt"),
		inventory_image = "lottthrowing_bolt_"..material..".png",
	})

	minetest.register_craft({
		output = name..' 16',
		recipe = {
			{'default:steel_ingot', material_group..':'..material..'_ingot'},
		}
	})

	minetest.register_node(name.."_box", {
		drawtype = "nodebox",
		node_box = bolt_node_box,
		tiles = {"lottthrowing_bolt_"..material..".png",
			 "lottthrowing_bolt_"..material..".png",
			 "lottthrowing_bolt_"..material.."_back.png",
			 "lottthrowing_bolt_"..material.."_front.png",
			 "lottthrowing_bolt_"..material.."_2.png",
			 "lottthrowing_bolt_"..material..".png"},
		groups = {not_in_creative_inventory=1},
	})

	arrows:register_arrow(name, {
			texture = name.."_box",
			visual = "wielditem",
			arrow_type = "bolt",
			mass = BOLT_MASS,
			kfr = KFR,
			damage_coefficient = dc,
			velocity = BOLT_VELOCITY})
end

register_bolt("steel", "default", STEEL_DC)
register_bolt("mithril", "lottores", MITHRIL_DC)

