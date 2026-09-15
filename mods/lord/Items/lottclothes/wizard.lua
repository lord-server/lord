local S = core.get_mod_translator()

-- Clothes made for wizards


-- gandalf the grey:
-- big black dwarf boots
core.register_tool("lottclothes:boots_dwarf", {
	description = S("Dwarven Boots"),
	inventory_image = "lottclothes_inv_boots_dwarf.png",
	groups = {armor_feet=0, clothes=1, clothes_feet=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:boots_dwarf",
	recipe = {
		{"lottclothes:felt_black", "", "lottclothes:felt_black"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 2',
	recipe = {
		{'lottclothes:boots_dwarf'},
	}
})

-- cloak
core.register_tool("lottclothes:cloak_wizard_grey", {
	description = S("Grey Wizard Cloak"),
	inventory_image = "lottclothes_inv_cloak_wizard_grey.png",
	groups = {clothes=1, no_preview=1, clothes_cloak=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:cloak_wizard_grey",
	recipe = {
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 6',
	recipe = {
		{'lottclothes:cloak_wizard_grey'},
	}
})

-- hood
core.register_tool("lottclothes:hood_wizard_blue", {
	description = S("Blue Wizard Hood"),
	inventory_image = "lottclothes_inv_hood_wizard_blue.png",
	groups = {clothes=1, clothes_head=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:hood_wizard_blue",
	recipe = {
		{"lottclothes:felt_blue", "lottclothes:felt_blue", "lottclothes:felt_blue"},
		{"lottclothes:felt_blue", "", "lottclothes:felt_blue"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 5',
	recipe = {
		{'lottclothes:hood_wizard_blue'},
	}
})

-- robe
core.register_tool("lottclothes:robe_wizard_grey", {
	description = S("Grey Wizard Robe"),
	inventory_image = "lottclothes_inv_robe_wizard_grey.png",
	groups = {clothes=1, clothes_torso=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:robe_wizard_grey",
	recipe = {
		{"lottclothes:felt_grey", "", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 8',
	recipe = {
		{'lottclothes:robe_wizard_grey'},
	}
})






-- gandalf the white
-- hood
core.register_tool("lottclothes:hood_wizard_white", {
	description = S("White Wizard Hood"),
	inventory_image = "lottclothes_inv_hood_wizard_white.png",
	groups = {clothes=1, clothes_head=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:hood_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "", "lottclothes:felt_white"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 5',
	recipe = {
		{'lottclothes:hood_wizard_white'},
	}
})

-- robe
core.register_tool("lottclothes:robe_wizard_white", {
	description = S("White Wizard Robe"),
	inventory_image = "lottclothes_inv_robe_wizard_white.png",
	groups = {clothes=1, clothes_torso=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:robe_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 8',
	recipe = {
		{'lottclothes:robe_wizard_white'},
	}
})

-- trousers
core.register_tool("lottclothes:trousers_wizard_white", {
	description = S("White Wizard Trousers"),
	inventory_image = "lottclothes_inv_trousers_wizard_white.png",
	groups = {clothes=1, clothes_legs=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:trousers_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "", "lottclothes:felt_white"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 7',
	recipe = {
		{'lottclothes:trousers_wizard_white'},
	}
})

-- cloak
core.register_tool("lottclothes:cloak_wizard_white", {
	description = S("White Wizard Cloak"),
	inventory_image = "lottclothes_inv_cloak_wizard_white.png",
	groups = {clothes=1, no_preview=1, clothes_cloak=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:cloak_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white"}
	}
})

core.register_craft({
	output = 'lottclothes:feltthread 6',
	recipe = {
		{'lottclothes:cloak_wizard_white'},
	}
})
