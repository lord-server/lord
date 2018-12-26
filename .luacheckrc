unused_args       = false
allow_defined_top = true

globals           = {
	"minetest", "core"
}

read_globals      = {
	string = { fields = { "split" } },
	table  = { fields = { "copy", "getn" } },

	-- Builtin
	"vector", "nodeupdate", "PseudoRandom",
	"VoxelManip", "VoxelArea",
	"ItemStack", "Settings",
	"dump", "DIR_DELIM",

	-- MTG
	"default", "sfinv", "creative",

	-- Lord specific
	"lord",

	-- Mods APIs
	"doors",
	"intllib",
	"stairs",

	-- Legacy
	"spawn_falling_node",
}

exclude_files     = {
	-- External mods
	"mods/areas",
	"mods/intllib",
	"mods/mobs",
	"mods/lottmapgen",
	"mods/mp_world_edit",
}
