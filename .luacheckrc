unused_args       = false
allow_defined_top = true

std = "lua51"

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
	"lord", "hb",

	-- Mods APIs
	"doors",
	"intllib",
	"stairs",
	"screwdriver",
	"armor", -- lottarmor
	"multiskin", -- lottarmor
	"mobs",
	"worldedit",

	-- Опциональная поддержка этих апи модов некоторыми из тех модов, что у нас
	"unified_inventory",
	"skins", -- моды: skins, simple_skins
	"u_skins", -- u_skins
	"wardrobe", -- wardrobe


	-- Functions:
	"get_mail", -- mail_list из lord-server/lord_ext
	"within_limits", -- mobs api

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
	"mods/default/chatcommands.lua",
	-- Internal mods
	"mods/hud_modpack/hudbars"
}
