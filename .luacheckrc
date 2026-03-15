return dofile("mods/Voxrame/game.luacheckrc"):extend({
	globals           = {
		-- MTG APIs
		"default", "doors", "farming", "player_api",
		"sethome.set", "beds.day_interval.finish",

		-- Other APIs (mods/_various)
		"hbhunger", "tt", "flowerpot",
	},

	read_globals      = {
		-- MTG
		"creative", "dungeon_loot",
		"dye", "stairs", "sethome", "walls", "bucket",

		-- Lord specific
		"lord", "hb",

		-- Mods APIs
		"screwdriver",
		"armor", -- lottarmor
		"multiskin", -- lottarmor
		"mobs",
		"worldedit",
		"areas",
		"hopper",
		"legacy_mobs",

		-- Functions:
		"within_limits", -- mobs api
	},

	exclude_files     = {
		"mods/_various/",
	},

	files             = {
		-- Don't report on legacy definitions of globals.
		["mods/_minetest_game/default/legacy.lua"] = { global = false },
		-- WorldEdit extending:
		["mods/lord/World/worldedit_ext/**/*.lua"] = { globals = { "worldedit" } }
	}
})
