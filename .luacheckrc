unused_args       = false
allow_defined_top = true

std = "lua51"

globals           = {
	"minetest", "core"
}

read_globals      = {
	string = { fields = { "split" } },
	table  = { fields = { "copy", "getn" } },

	-- Silence warnings about accessing undefined fields 'sign' of global 'math'
	math = { fields = { "sign" } },

	-- Builtin
	"vector", "nodeupdate", "PseudoRandom",
	"VoxelManip", "VoxelArea",
	"ItemStack", "Settings",
	"dump", "DIR_DELIM",

	-- MTG
	"default", "sfinv", "creative", "dungeon_loot",

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
	"areas",

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
	-- External mods:

    -- не ясно почему они тут оказались:
	"mods/lord/lord_base_commands/chatcommands.lua",
	"mods/lord/lottclothes",

    -- MTG:
    -- (в большинстве случаев ошибки уже исправлены в оригинале, нужно убрать после обновления)
    "mods/_minetest_game/carts/cart_entity.lua",
    "mods/_minetest_game/doors/api.lua",

    -- LOTT:
	"mods/_lott/lottmapgen",

    -- Остальное:
	"mods/_various/ambience",
	"mods/_various/areas",
	"mods/_various/hud_modpack/hudbars",
	"mods/_various/intllib",
	"mods/_various/mobs",
	"mods/_various/mobs_fish",
	"mods/_various/mp_world_edit",
	"mods/_various/painting",
	"mods/_various/testtools",
}
