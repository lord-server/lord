local S = core.get_mod_translator()


--Dwarf_armor
core.register_tool('lord_armor:dwarf_helmet', {
	description 		= S('Dwarf Helmet'),
	inventory_image 	= 'lord_armor_dwarf_inv_helmet.png',
	groups 				= {
		armor_head			= 1,
		defense_fleshy		= 15,
		damage_avoid_chance	= 6,
		armor_use			= 50,
		physics_speed		= -0.1,
		mithril_item		= 1,
	},
	wear 				= 0,
})
core.register_tool('lord_armor:dwarf_chestplate', {
	description 		= S('Dwarf Chestplate'),
	inventory_image 	= 'lord_armor_dwarf_inv_chestplate.png',
	groups 				= {
		armor_torso			= 1,
		defense_fleshy		= 20,
		damage_avoid_chance	= 10,
		armor_use			= 50,
		physics_speed		= -0.07,
		mithril_item		= 1,
	},
	wear 				= 0,
})
core.register_tool('lord_armor:dwarf_leggings', {
	description 	= S('Dwarf Leggings'),
	inventory_image = 'lord_armor_dwarf_inv_leggings.png',
	groups 			= {
		armor_legs			= 1,
		defense_fleshy		= 10,
		damage_avoid_chance	= 8,
		armor_use			= 50,
		physics_speed		= -0.05,
		mithril_item		= 1,
	},
	wear 			 = 0,
})
core.register_tool('lord_armor:dwarf_boots', {
	description 		= S('Dwarf Boots'),
	inventory_image 	= 'lord_armor_dwarf_inv_boots.png',
	groups 				= {
		armor_feet			= 1,
		defense_fleshy		= 7,
		damage_avoid_chance = 6,
		armor_use			= 50,
		physics_speed		= -0.02,
		mithril_item		= 1,
	},
	wear 				= 0,
})

core.register_tool('lord_armor:dwarf_shield', {
	description     	= S('Dwarf Shield'),
	inventory_image 	= 'lord_armor_dwarf_shield_inv.png',
	groups          	= {
		armor_shield 		= 1,
		defense_fleshy 		= 21,
		damage_avoid_chance = 15,
		armor_use 			= 100,
		physics_speed 		= -0.1,
		physics_sneak 		= -1,
		forbidden 			= 1,
		mithril_item 		= 1,
	},
	wear            	= 0,
})

core.register_craft({
	method   = core.CraftMethod.ANVIL,
	output   = 'lord_armor:helmet_dwarf',
	for_race = races.name.DWARF,
	recipe   = {
		{ 'lottores:mithril_ingot','lottores:galvorn_ingot','lottores:mithril_ingot'},
		{ 'default:mese_crystal', '',						  'default:mese_crystal'},
		{ '', 					  '',											  ''},
	}
})

core.register_craft({
	method   = core.CraftMethod.ANVIL,
	output   = 'lord_armor:chestplate_dwarf',
	for_race = races.name.DWARF,
	recipe   = {
		{ 'lottores:mithril_ingot','',						 'lottores:mithril_ingot'},
		{ 'lottores:mithril_ingot', 'lottores:mithril_ingot','lottores:mithril_ingot'},
		{ 'lottores:galvorn_ingot', 'default:mese_crystal',	 'lottores:galvorn_ingot'},
	}
})

core.register_craft({
	method   = core.CraftMethod.ANVIL,
	output   = 'lord_armor:leggings_dwarf',
	for_race = races.name.DWARF,
	recipe   = {
		{ 'lottores:galvorn_ingot','default:mese_crystal','lottores:galvorn_ingot'},
		{ 'lottores:mithril_ingot','',					  'lottores:mithril_ingot'},
		{ 'lottores:mithril_ingot','',					  'lottores:mithril_ingot'},
	}
})

core.register_craft({
	method   = core.CraftMethod.ANVIL,
	output   = 'lord_armor:boots_dwarf',
	for_race = races.name.DWARF,
	recipe   = {
		{ 'lottores:mithril_ingot','',					  'lottores:mithril_ingot'},
		{ 'lottores:galvorn_ingot','',					  'lottores:galvorn_ingot'},
	}
})

core.register_craft({
	method   = core.CraftMethod.ANVIL,
	output   = 'lord_armor:shield_dwarf',
	for_race = races.name.DWARF,
	recipe   = {
		{ 'lottores:mithril_ingot', 'default:mese_crystal',  'lottores:mithril_ingot' },
		{ 'lottores:mithril_ingot', 'lottores:galvorn_ingot','lottores:mithril_ingot' },
		{ '',                       'lottores:galvorn_ingot',''					  	  }
	    }
   })
