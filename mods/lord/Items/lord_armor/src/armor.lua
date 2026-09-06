local S = minetest.get_mod_translator()

-- Wood Armor
minetest.register_tool(":lottarmor:helmet_wood", {
	description     = S("Training Helmet"),
	_rank           = item_rank.Type.COMMON,
	inventory_image = "lottarmor_inv_helmet_wood.png",
	groups          = {
		armor_head=1, defense_fleshy=4, armor_use=2000, physics_speed=0.05,
		wooden = 1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_wood", {
	description     = S("Training Chestplate"),
	_rank           = item_rank.Type.COMMON,
	inventory_image = "lottarmor_inv_chestplate_wood.png",
	groups          = {
		armor_torso=1, defense_fleshy=5, armor_use=2000, physics_speed=0.06,
		wooden = 1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_wood", {
	description     = S("Training Leggings"),
	_rank           = item_rank.Type.COMMON,
	inventory_image = "lottarmor_inv_leggings_wood.png",
	groups          = {
		armor_legs=1, defense_fleshy=3, armor_use=2000, physics_speed=0.07,
		wooden = 1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_wood", {
	description = S("Training Boots"),
	_rank = item_rank.Type.COMMON,
	inventory_image = "lottarmor_inv_boots_wood.png",
	groups = {
		armor_feet=1, defense_fleshy=2, armor_use=2100, physics_speed=0.08,
		wooden = 1
	},
	wear            = 0,
})


-- Tin Armor
minetest.register_tool(":lottarmor:helmet_tin", {
	description     = S("Tin Helmet"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_helmet_tin.png",
	groups          = {
		armor_head=1, defense_fleshy=6, damage_avoid_chance=1, armor_use=1500,
		physics_speed=0.02, tin_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_tin", {
	description     = S("Tin Chestplate"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_chestplate_tin.png",
	groups          = {
		armor_torso=1, defense_fleshy=7, damage_avoid_chance=1, armor_use=1500,
		physics_speed=0.02, tin_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_tin", {
	description     = S("Tin Leggings"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_leggings_tin.png",
	groups          = {
		armor_legs=1, defense_fleshy=4, damage_avoid_chance=1, armor_use=1500,
		physics_speed=0.03, tin_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_tin", {
	description     = S("Tin Boots"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_boots_tin.png",
	groups          = {
		armor_feet=1, defense_fleshy=3, damage_avoid_chance=0, armor_use=2000,
		physics_speed=0.03, tin_item=1
	},
	wear            = 0,
})


--Copper Armor
minetest.register_tool(":lottarmor:helmet_copper", {
	description     = S("Copper Helmet"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_helmet_copper.png",
	groups          = {
		armor_head=1, defense_fleshy=8, damage_avoid_chance=1, armor_use=1500,
		physics_speed=0.02, copper_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_copper", {
	description     = S("Copper Chestplate"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_chestplate_copper.png",
	groups          = {
		armor_torso=1, defense_fleshy=10, damage_avoid_chance=1, armor_use=1500,
		physics_speed=0.025, copper_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_copper", {
	description     = S("Copper Leggings"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_leggings_copper.png",
	groups          = {
		armor_legs=1, defense_fleshy=6, damage_avoid_chance=1, armor_use=1500,
		physics_speed=0.04, copper_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_copper", {
	description     = S("Copper Boots"),
	_rank           = item_rank.Type.ADVANCED,
	inventory_image = "lottarmor_inv_boots_copper.png",
	groups          = {
		armor_feet=1, defense_fleshy=4, damage_avoid_chance=0, armor_use=2000,
		physics_speed=0.05, copper_item=1
	},
	wear            = 0,
})


--Steel Armor
minetest.register_tool(":lottarmor:helmet_steel", {
	description     = S("Steel Helmet"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_helmet_steel.png",
	groups          = {
		armor_head=1, defense_fleshy=9, damage_avoid_chance=2, armor_use=500,
		physics_speed=0.015, steel_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_steel", {
	description     = S("Steel Chestplate"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_chestplate_steel.png",
	groups          = {
		armor_torso=1, defense_fleshy=11, damage_avoid_chance=2, armor_use=500,
		physics_speed=0.02, steel_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_steel", {
	description     = S("Steel Leggings"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_leggings_steel.png",
	groups          = {
		armor_legs=1, defense_fleshy=7, damage_avoid_chance=2, armor_use=500,
		physics_speed=0.03, steel_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_steel", {
	description     = S("Steel Boots"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_boots_steel.png",
	groups          = {
		armor_feet=1, defense_fleshy=4, damage_avoid_chance=0, armor_use=500,
		physics_speed=0.04, steel_item=1
	},
	wear            = 0,
})


--Bronze Armor
minetest.register_tool(":lottarmor:helmet_bronze", {
	description     = S("Bronze Helmet"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_helmet_bronze.png",
	groups          = {
		armor_head=1, defense_fleshy=10, damage_avoid_chance=3, armor_use=250,
		physics_speed=0.02, bronze_item=1
	},
	wear             = 0,
})
minetest.register_tool(":lottarmor:chestplate_bronze", {
	description     = S("Bronze Chestplate"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_chestplate_bronze.png",
	groups          = {
		armor_torso=1, defense_fleshy=12, damage_avoid_chance=3, armor_use=250,
		physics_speed=0.03, bronze_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_bronze", {
	description     = S("Bronze Leggings"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_leggings_bronze.png",
	groups          = {
		armor_legs=1, defense_fleshy=7, damage_avoid_chance=3, armor_use=250,
		physics_speed=0.04, bronze_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_bronze", {
	description     = S("Bronze Boots"),
	_rank           = item_rank.Type.RARE,
	inventory_image = "lottarmor_inv_boots_bronze.png",
	groups          = {
		armor_feet=1, defense_fleshy=5, damage_avoid_chance=0, armor_use=250,
		physics_speed=0.05, bronze_item=1
	},
	wear            = 0,
})


--Silver Armor
minetest.register_tool(":lottarmor:helmet_silver", {
	description     = S("Silver Helmet"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_helmet_silver.png",
	groups          = {
		armor_head=1, armor_use=300, silver_item=1,
		damage_avoid_chance=4,
		defense_fleshy=10, defense_poison=6,
		physics_speed=-0.02,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_silver", {
	description     = S("Silver Chestplate"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_chestplate_silver.png",
	groups          = {
		armor_torso=1, armor_use=300, silver_item=1,
		damage_avoid_chance=4,
		defense_fleshy=13, defense_poison=7,
		physics_speed=-0.03,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_silver", {
	description     = S("Silver Leggings"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_leggings_silver.png",
	groups          = {
		armor_legs=1, armor_use=300, silver_item=1,
		damage_avoid_chance=4,
		defense_fleshy=8, defense_poison=6,
		physics_speed=-0.04,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_silver", {
	description     = S("Silver Boots"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_boots_silver.png",
	groups          = {
		armor_feet=1, armor_use=300, silver_item=1,
		damage_avoid_chance=0,
		defense_fleshy=5, defense_poison=4,
		physics_speed=-0.04,
	},
	wear            = 0,
})


--Gold Armor
minetest.register_tool(":lottarmor:helmet_gold", {
	description     = S("Gold Helmet"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_helmet_gold.png",
	groups          = {
		armor_head=1, armor_use=250, gold_item=1,
		damage_avoid_chance=4,
		defense_fleshy=11, defense_soul=5,
		physics_speed=-0.05,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_gold", {
	description     = S("Gold Chestplate"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_chestplate_gold.png",
	groups          = {
		armor_torso=1, armor_use=250, gold_item=1,
		damage_avoid_chance=4,
		defense_fleshy=14, defense_soul=6,
		physics_speed=-0.05,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_gold", {
	description     = S("Gold Leggings"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_leggings_gold.png",
	groups          = {
		armor_legs=1, armor_use=250, gold_item=1,
		damage_avoid_chance=4,
		defense_fleshy=8, defense_soul=5,
		physics_speed=-0.07,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_gold", {
	description     = S("Gold Boots"),
	_rank           = item_rank.Type.EPIC,
	inventory_image = "lottarmor_inv_boots_gold.png",
	groups          = {
		armor_feet=1, armor_use=250, gold_item=1,
		damage_avoid_chance=0,
		defense_fleshy=5, defense_soul=3,
		physics_speed=-0.07,
	},
	wear            = 0,
})


--Galvorn Armor
minetest.register_tool(":lottarmor:helmet_galvorn", {
	description     = S("Galvorn Helmet"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_helmet_galvorn.png",
	groups          = {
		armor_head=1, armor_use=100, forbidden = 1, galvorn_item = 1,
		damage_avoid_chance=5,
		defense_fleshy=11, defense_fire=7,
		physics_speed = -0.1,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_galvorn", {
	description     = S("Galvorn Chestplate"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_chestplate_galvorn.png",
	groups          = {
		armor_torso=1, armor_use=100, forbidden=1, galvorn_item=1,
		damage_avoid_chance=5,
		defense_fleshy=14, defense_fire=8,
		physics_speed=-0.08,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_galvorn", {
	description     = S("Galvorn Leggings"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_leggings_galvorn.png",
	groups = {
		armor_legs=1, armor_use=100, forbidden=1, galvorn_item=1,
		damage_avoid_chance=5,
		defense_fleshy=8, defense_fire=7,
		physics_speed=-0.1,
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_galvorn", {
	description     = S("Galvorn Boots"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_boots_galvorn.png",
	groups          = {
		armor_feet=1, armor_use=100, forbidden=1, galvorn_item=1,
		damage_avoid_chance=0,
		defense_fleshy=6, defense_fire=4,
		physics_speed=-0.09,
	},
	wear            = 0,
})


--Mithril Armor
minetest.register_tool(":lottarmor:helmet_mithril", {
	description     = S("Mithril Helmet"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_helmet_mithril.png",
	groups          = {
		armor_head=1, defense_fleshy=14, damage_avoid_chance=0, armor_use=50,
		physics_speed=0.05, mithril_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:chestplate_mithril", {
	description     = S("Mithril Chestplate"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_chestplate_mithril.png",
	groups          = {
		armor_torso=1, defense_fleshy=17, damage_avoid_chance=0, armor_use=50,
		physics_speed=0.05, mithril_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:leggings_mithril", {
	description     = S("Mithril Leggings"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_leggings_mithril.png",
	groups          = {
		armor_legs=1, defense_fleshy=10, damage_avoid_chance=0, armor_use=50,
		physics_speed=0.06, mithril_item=1
	},
	wear            = 0,
})
minetest.register_tool(":lottarmor:boots_mithril", {
	description     = S("Mithril Boots"),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = "lottarmor_inv_boots_mithril.png",
	groups          = {
		armor_feet=1, defense_fleshy=7, damage_avoid_chance=0, armor_use=50,
		physics_speed=0.07, mithril_item=1
	},
	wear            = 0,
})

-- Register Craft Recipes

local craft_ingreds = {
	wood = "group:wood",
	tin = "lottores:tin_ingot",
	copper = "default:copper_ingot",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	silver = "lottores:silver_ingot",
	gold = "default:gold_ingot",
	galvorn = "lottores:galvorn_ingot",
	mithril = "lottores:mithril_ingot",
}

for k, v in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "lottarmor:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "lottarmor:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "lottarmor:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "lottarmor:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end
