local S = core.get_mod_translator()


-- TODO: temporary — items registered unconditionally so `dwarf_king` (lottmobs) can wear
-- this armor as a boss drop before `toggle_racial_armor` is fully released. `toggle_racial_armor`
-- still gates the crafting recipes, see `racial.lua`. Revisit once the feature ships for real.

core.register_tool('lord_armor:dwarf_helmet', {
	description     = S('Dwarf Helmet'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'lord_armor_dwarf_inv_helmet.png',
	groups          = {
		armor_head          = 1,
		defense_fleshy      = 15,
		damage_avoid_chance = 6,
		armor_use           = 50,
		physics_speed       = -0.1,
		mithril_item        = 1,
	},
	wear            = 0,
})
core.register_tool('lord_armor:dwarf_chestplate', {
	description     = S('Dwarf Chestplate'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'lord_armor_dwarf_inv_chestplate.png',
	groups          = {
		armor_torso         = 1,
		defense_fleshy      = 20,
		damage_avoid_chance = 10,
		armor_use           = 50,
		physics_speed       = -0.07,
		mithril_item        = 1,
	},
	wear            = 0,
})
core.register_tool('lord_armor:dwarf_leggings', {
	description     = S('Dwarf Leggings'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'lord_armor_dwarf_inv_leggings.png',
	groups          = {
		armor_legs          = 1,
		defense_fleshy      = 10,
		damage_avoid_chance = 8,
		armor_use           = 50,
		physics_speed       = -0.05,
		mithril_item        = 1,
	},
	wear            = 0,
})
core.register_tool('lord_armor:dwarf_boots', {
	description     = S('Dwarf Boots'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'lord_armor_dwarf_inv_boots.png',
	groups          = {
		armor_feet          = 1,
		defense_fleshy      = 7,
		damage_avoid_chance = 6,
		armor_use           = 50,
		physics_speed       = -0.02,
		mithril_item        = 1,
	},
	wear            = 0,
})

core.register_tool('lord_armor:dwarf_shield', {
	description     = S('Dwarf Shield'),
	_rank           = item_rank.Type.LEGENDARY,
	inventory_image = 'lord_armor_dwarf_shield_inv.png',
	groups          = {
		armor_shield        = 1,
		defense_fleshy      = 21,
		damage_avoid_chance = 15,
		armor_use           = 100,
		physics_speed       = -0.1,
		physics_sneak       = -1,
		forbidden           = 1,
		mithril_item        = 1,
	},
	wear            = 0,
})
