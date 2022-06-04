lord_armor.register_type("helmet", {
	description = "Helmet", -- no need to tranlsate this
	protection_level = {physical = 3},
	basic_durability = 64,
	compatible_slots = {"helmet"},
})

lord_armor.set_type_recipe("helmet", {
	output = "helmet",
	recipe = {
		{"material", "material", "material"},
		{"material", "", "material"},
	},
})

lord_armor.register_type("chestplate", {
	description = "Chestplate", -- no need to tranlsate this
	protection_level = {physical = 5},
	basic_durability = 64,
	compatible_slots = {"chestplate"},
})

lord_armor.set_type_recipe("chestplate", {
	output = "chestplate",
	recipe = {
		{"material", "", "material"},
		{"material", "material", "material"},
		{"material", "material", "material"},
	},
})

lord_armor.register_type("greave", {
	description = "Greave", -- no need to tranlsate this
	protection_level = {physical = 4},
	basic_durability = 64,
	compatible_slots = {"greave"},
})

lord_armor.set_type_recipe("greave", {
	output = "greave",
	recipe = {
		{"material", "material", "material"},
		{"material", "", "material"},
		{"material", "", "material"},
	},
})

lord_armor.register_type("boots", {
	description = "Boots", -- no need to tranlsate this
	protection_level = {physical = 2},
	basic_durability = 64,
	compatible_slots = {"boots"},
})

lord_armor.set_type_recipe("boots", {
	output = "boots",
	recipe = {
		{"material", "", "material"},
		{"material", "", "material"},
	},
})

lord_armor.register_type("shield", {
	description = "Shield", -- no need to tranlsate this
	protection_level = {physical = 2},
	basic_durability = 64,
	compatible_slots = {"shield"},
})

lord_armor.set_type_recipe("shield", {
	output = "shield",
	recipe = {
		{"material", "material", "material"},
		{"material", "material", "material"},
		{"", "material", ""},
	},
})
