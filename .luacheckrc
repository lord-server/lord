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
	table  = { fields = {
		"getn", -- was in Lua, now deprecated TODO: remove usages

		-- MT Builtin:
		"copy", "indexof", "insert_all", "key_value_swap",

		-- our Core/helpers:
		-- table:
		"contains", "has_value", "has_key", "merge", "merge_values", "is_empty", "overwrite",
        "keys_has_one_of_values"
		-- string:
		-- TODO: "startsWith", "endsWith", ...
	} },

	string = { fields = {
		-- MT Builtin:
		"split", "trim",
	} },

	math = { fields = {
		-- MT Builtin:
		"sign", "hypot", "factorial",
	} },

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

    -- MTG:
    "mods/_minetest_game/",

    -- наследие из LOTT (требует переработки):
	"mods/lord/World/Generation/lottmapgen",

    -- Остальное:
	"mods/_various/",
	"util",
}

-- Lua extending:
files["mods/lord/Core/helpers/src/lua_ext/**/*.lua"] = {
	globals = {
		table  = { fields = {} },
		string = { fields = {} },
	}
}
