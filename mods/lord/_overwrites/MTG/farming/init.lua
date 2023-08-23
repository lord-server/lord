minetest.register_alias("farming:sheaf_wheat","farming:wheat")
minetest.register_alias("farming:wheat0","farming:seed_wheat")


-- Override grasses for hoes to work
minetest.override_item("lottmapgen:dunland_grass", {
	soil = {
		base = "lottmapgen:dunland_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:ironhill_grass", {
	soil = {
		base = "lottmapgen:ironhill_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:gondor_grass", {
	soil = {
		base = "lottmapgen:gondor_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:lorien_grass", {
	soil = {
		base = "lottmapgen:lorien_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:fangorn_grass", {
	soil = {
		base = "lottmapgen:fangorn_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:mirkwood_grass", {
	soil = {
		base = "lottmapgen:mirkwood_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:rohan_grass", {
	soil = {
		base = "lottmapgen:rohan_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:shire_grass", {
	soil = {
		base = "lottmapgen:shire_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:ithilien_grass", {
	soil = {
		base = "lottmapgen:ithilien_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("lottmapgen:default_grass", {
	soil = {
		base = "lottmapgen:default_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("farming:cotton_wild", {drop = {
	max_items = 1,
	items = {
		{items = {"farming:cotton_wild"}, rarity = 8},
		{items = {"farming:seed_cotton"}},
	}
}})


-- Clear hoes tools and craft registration
minetest.clear_craft({output = "farming:hoe_mese"})
minetest.unregister_item("farming:hoe_mese")
minetest.clear_craft({output = "farming:hoe_diamond"})
minetest.unregister_item("farming:hoe_diamond")
