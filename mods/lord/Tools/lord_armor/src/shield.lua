local SL = minetest.get_translator("lord_armor")

-- Register Shields
minetest.register_tool(":lottarmor:shield_wood", {
	description     = SL("Training Shield"),
	inventory_image = "lottarmor_inv_shield_wood.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 3, damage_avoid_chance = 1, armor_use = 2000,
		physics_speed = 0.05, wooden = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_tin", {
	description     = SL("Tin Shield"),
	inventory_image = "lottarmor_inv_shield_tin.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 5, damage_avoid_chance = 2.5, armor_use = 1750,
		physics_speed=0.01, tin_item = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_copper", {
	description     = SL("Copper Shield"),
	inventory_image = "lottarmor_inv_shield_copper.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 9, damage_avoid_chance = 5, armor_use = 1750,
		physics_speed=0.02, copper_item = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_steel", {
	description     = SL("Steel Shield"),
	inventory_image = "lottarmor_inv_shield_steel.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 8, damage_avoid_chance = 4, armor_use = 1250,
		physics_speed=0.015, steel_item = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_bronze", {
	description     = SL("Bronze Shield"),
	inventory_image = "lottarmor_inv_shield_bronze.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 10, damage_avoid_chance = 8, armor_use = 750,
		physics_speed=0.02, bronze_item = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_silver", {
	description     = SL("Silver Shield"),
	inventory_image = "lottarmor_inv_shield_silver.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 7, damage_avoid_chance = 5, armor_use = 1000,
		physics_speed = -0.02, silver_item = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_gold", {
	description     = SL("Gold Shield"),
	inventory_image = "lottarmor_inv_shield_gold.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 6, damage_avoid_chance = 4, armor_use = 500,
		physics_speed = -0.04, gold_item = 1
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_galvorn", {
	description     = SL("Galvorn Shield"),
	inventory_image = "lottarmor_inv_shield_galvorn.png",
	groups          = {
		armor_shield = 1, armor_use = 250, forbidden = 1, galvorn_item = 1,
		damage_avoid_chance = 10,
		defense_fleshy = 11, defense_fire = 8.25,
		physics_speed = -0.07, physics_sneak = -1,
	},
	wear            = 0,
})

minetest.register_tool(":lottarmor:shield_mithril", {
	description     = SL("Mithril Shield"),
	inventory_image = "lottarmor_inv_shield_mithril.png",
	groups          = {
		armor_shield = 1, defense_fleshy = 14, damage_avoid_chance = 0, armor_use = 100,
		physics_speed = 0.05, physics_sneak = -1, forbidden = 1, mithril_item = 1
	},
	wear            = 0,
})

local craft_ingreds = {
	wood    = "group:wood",
	tin     = "lottores:tin_ingot",
	copper  = "default:copper_ingot",
	steel   = "default:steel_ingot",
	bronze  = "default:bronze_ingot",
	silver  = "lottores:silver_ingot",
	gold    = "default:gold_ingot",
	galvorn = "lottores:galvorn_ingot",
	mithril = "lottores:mithril_ingot",
}

for k, v in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "lottarmor:shield_" .. k,
		recipe = {
			{ v, v, v },
			{ v, v, v },
			{ "", v, "" },
		},
	})
end

