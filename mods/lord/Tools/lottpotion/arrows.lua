local SL = minetest.get_translator("lottpotion")

local KFR=0.01
local DC=0.01
local MASS=0.5
local VELOCITY=30

lottpotion.register_arrow = function(potion_name, name, hname, potion_use_funct, desc, img)
--	minetest.log("action", "regisering potion arrow")
	local arrow_name = potion_name.."_arrow"
	local inventory_img = img.."^lottthrowing_arrow_steel.png"
	minetest.register_craftitem(arrow_name, {
		description = SL("Potion Arrow").." ("..desc..")",
		inventory_image = inventory_img,
		groups = {},
	})

	arrows:register_arrow(arrow_name, {
		arrow_type = "arrow",
		mass = MASS,
		kfr = KFR,
		damage_coefficient = DC,
		velocity = VELOCITY,
		texture = inventory_img,
		hit_player = function(arrow, player)
			potion_use_funct({take_item = function()end}, player)
		end,
	})

	minetest.register_craft({
		type = "shapeless",
		output = potion_name.."_arrow",
		recipe = {"arrows:arrow_steel", potion_name}
	})
end
