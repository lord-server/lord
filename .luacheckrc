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
		--- @deprecated
		"getn", -- was in Lua, now deprecated TODO: remove usages
		-- MT Builtin:
		"copy", "indexof", "insert_all", "key_value_swap",
		-- our Core/helpers:
		-- table:
		"contains", "has_value", "has_key", "merge", "merge_values", "is_empty", "overwrite", "keys_of",
        "keys_has_one_of_values"
	} },

	string = { fields = {
		-- MT Builtin:
		"split", "trim",
		-- our Core/helpers:
		"is_one_of"
		-- TODO: "startsWith", "endsWith", ...
	} },

	math = { fields = {
		-- MT Builtin:
		"sign", "hypot", "factorial", "round",
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

    -- MTG:
    "mods/_minetest_game/",

    -- наследие из LOTT (требует переработки):
	"mods/lord/World/Generation/lottmapgen",
	"mods/lord/Blocks/protector_lott",

    -- Остальное:
	"mods/_various/",
	"util",
}

-- Lua extending:
files["mods/lord/Core/helpers/src/lua_ext/**/*.lua"] = {
	globals = { "table", "string", }
}
-- WorldEdit extending:
files["mods/lord/World/worldedit_ext/**/*.lua"] = {
	globals = { "worldedit"	}
}
