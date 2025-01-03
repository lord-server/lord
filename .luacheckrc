unused_args       = false
allow_defined_top = true

std = "lua51"

globals           = {
	"minetest", "core",

    -- MTG APIs
	"default", "doors", "farming", "player_api",
	"sethome.set", "beds",

	-- Other APIs (mods/_various)
	"hbhunger", "tt",

	debug  = { fields = {
		-- our Core/helpers:
		"get_function_code",
	} },
}

read_globals      = {
	table  = { fields = {
		--- @deprecated
		"getn", -- was in Lua, now deprecated TODO: remove usages
		-- MT Builtin:
		"copy", "indexof", "insert_all", "key_value_swap",
		-- our Core/helpers:
		-- table:
		"contains", "has_value", "has_key", "merge", "join", "merge_values",
		"is_empty", "overwrite", "keys_of", "count", "keys", "values",
		"except", "keys_has_one_of_values", "equals", "multiply_each_value",
		"map", "add_values", "sub_values", "mul_values", "div_values"
	} },

	string = { fields = {
		-- MT Builtin:
		"split", "trim",
		-- our Core/helpers:
		"is_one_of", "replace",
		-- TODO: "startsWith", "endsWith", ...
	} },

	math = { fields = {
		-- MT Builtin:
		"sign", "hypot", "factorial", "round",
		-- Core/helpers:
		"limit", "clamp"
	} },

	io = { fields = {
		-- our Core/helpers:
		"file_exists", "write_to_file", "read_from_file"
	} },

	os = { fields = {
		-- our Core/helpers:
		"DIRECTORY_SEPARATOR",
	} },

	-- Builtin
	"vector", "nodeupdate", "PseudoRandom",
	"VoxelManip", "VoxelArea",
	"ItemStack", "Settings",
	"dump", "DIR_DELIM",

	-- MTG
	"beds", "sfinv", "creative", "dungeon_loot",
	"dye", "stairs", "sethome", "walls", "bucket",

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

    -- наследие из LOTT (требует переработки):
	--"mods/lord/World/Generation/lottmapgen",

    -- Остальное:
	"mods/_various/",
	"util",
}

-- Don't report on legacy definitions of globals.
files["mods/_minetest_game/default/legacy.lua"].global = false


-- Lua extending:
files["mods/lord/Core/helpers/src/lua_ext/**/*.lua"] = {
	globals = { "table", "string", "math", "io", "os" }
}
-- WorldEdit extending:
files["mods/lord/World/worldedit_ext/**/*.lua"] = {
	globals = { "worldedit"	}
}
