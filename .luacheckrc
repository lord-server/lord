unused_args = false
allow_defined_top = true

globals = {
	"minetest", "core"
}

read_globals = {
	string = {fields = {"split"}},
	table = {fields = {"copy", "getn"}},

	-- Builtin
	"vector", "ItemStack",
	"dump", "DIR_DELIM", "VoxelArea", "Settings",

	-- MTG
	"default", "sfinv", "creative",

	-- Lord specific
	"lord",

	-- Mods APIs
	"doors",
	"intllib",
	"stairs",
}

exclude_files = {
	-- External mods
	"mods/areas",
	"mods/intllib",
	"mods/mobs",
	"mods/lottmapgen",
	"mods/mp_world_edit",
}
