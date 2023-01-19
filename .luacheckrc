unused_args       = false
allow_defined_top = true

std = "lua51"

globals           = {
	"minetest", "core",

    -- MTG APIs
	"default", "doors", "farming", "player_api",
	"sethome.set",

	-- Other APIs
	"hbhunger",
}

read_globals      = {
	string = { fields = { "split" } },
	table  = { fields = { "copy", "getn", "indexof" } },

	-- Silence warnings about accessing undefined fields 'sign' of global 'math'
	math = { fields = { "sign" } },

	-- Builtin
	"vector", "nodeupdate", "PseudoRandom",
	"VoxelManip", "VoxelArea",
	"ItemStack", "Settings",
	"dump", "DIR_DELIM",

	-- MTG
	"beds", "sfinv", "creative", "dungeon_loot",
	"dye", "stairs", "sethome",

	-- Lord specific
	"lord", "hb",

	-- Mods APIs
	"intllib",
	"screwdriver",
	"armor", -- lottarmor
	"multiskin", -- lottarmor
	"mobs",
	"worldedit",
	"areas",

	-- Опциональная поддержка этих апи модов некоторыми из тех модов, что у нас
	"unified_inventory",

	-- Functions:
	"get_mail", -- mail_list из lord-server/lord_ext
	"within_limits", -- mobs api

	-- Legacy
	"spawn_falling_node",
}

exclude_files     = {
	-- External mods:

    -- пришлось добавить после того, как обновился LuaRocks:
	"mods/lord/lord_base_commands/chatcommands.lua",
	"mods/lord/lottclothes",

    -- MTG:
    "mods/_minetest_game/",

    -- LOTT:
	"mods/_lott/lottmapgen",

    -- Остальное:
	"mods/_various/",
	"util",
}
