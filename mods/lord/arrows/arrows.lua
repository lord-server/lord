
local SL = minetest.get_translator("arrows")

local KFR = 0.0002

local STEEL_DC = 0.1
local MITHRIL_DC = 0.4

local STEEL_ARROW_MASS = 0.03
local MITHRIL_ARROW_MASS = 0.025
local ARROW_VELOCITY = 50

local STEEL_BOLT_MASS = 0.1
local MITHRIL_BOLT_MASS = 0.03
local BOLT_VELOCITY = 60

local TYPE = {
	ARROW = "arrow",
	BOLT = "bolt",
}

local node_box = {}
-- Arrow nodebox
node_box[TYPE.ARROW] = {
	type = "fixed",
	fixed = {
		-- Shaft
		{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
		-- Spitze
		{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
		{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
		-- Federn
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
-- Bolt nodebox
node_box[TYPE.BOLT] = {
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

--- @param type string one of 'arrow'|'bolt'
--- @param material string name of material
--- @param material_mod string name of mod where material defined
--- @return table
local get_recipe_by_type = function(type, material, material_mod)
	if type == TYPE.ARROW then
		return {{ 'default:stick', 'default:stick', material_mod ..':'..material..'_ingot'},}
	elseif type == TYPE.BOLT then
		return {{ 'default:steel_ingot', material_mod ..':'..material..'_ingot'},}
	else
		error("Unknown type '" .. type .. "'")
	end
end


--- @param type string one of TYPE::{constant}'s
--- @param material string name of material
--- @param material_mod string name of mod where material defined
local register = function(type, material, material_mod, dc, mass, velocity)
	local name = "arrows:"..type.."_"..material
	minetest.register_craftitem(name, {
		description = SL(material.." "..type),
		inventory_image = "lottthrowing_"..type.."_"..material..".png",
		_tt_help = SL('Max damage: @1', arrows.get_max_damage(dc, mass, velocity))
	})

	minetest.register_craft({
		output = name..' 16',
		recipe = get_recipe_by_type(type, material, material_mod)
	})

	minetest.register_node(name.."_box", {
		drawtype = "nodebox",
		node_box = node_box[type],
		tiles = {
			"lottthrowing_"..type.."_"..material..".png",
			"lottthrowing_"..type.."_"..material..".png",
			"lottthrowing_"..type.."_"..material.."_back.png",
			"lottthrowing_"..type.."_"..material.."_front.png",
			"lottthrowing_"..type.."_"..material.."_2.png",
			"lottthrowing_"..type.."_"..material..".png"
		},
		use_texture_alpha = "clip",
		groups = {not_in_creative_inventory=1},
	})

	arrows:register_arrow(name, {
		texture = name.."_box",
		visual = "wielditem",
		arrow_type = type,
		mass = mass,
		kfr = KFR,
		damage_coefficient = dc,
		velocity = velocity,
		fly_sound = {
			sound = "lottthrowing_sound",
			sound_distance = 5,
		},
	})
end

register(TYPE.ARROW, "steel", "default", STEEL_DC, STEEL_ARROW_MASS, ARROW_VELOCITY)
register(TYPE.ARROW, "mithril", "lottores", MITHRIL_DC, MITHRIL_ARROW_MASS, ARROW_VELOCITY)

register(TYPE.BOLT, "steel", "default", STEEL_DC, STEEL_BOLT_MASS, BOLT_VELOCITY)
register(TYPE.BOLT, "mithril", "lottores", MITHRIL_DC, MITHRIL_BOLT_MASS, BOLT_VELOCITY)

