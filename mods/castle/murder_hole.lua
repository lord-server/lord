local SL = lord.require_intllib()

local hole = {}

hole.types = {
	{"brick", "Brick Block", "default_brick", "default:brick"},
	{"obsidian", "Obsidian", "default_obsidian", "default:obsidian"},

	{"stone", "Stone", "default_stone", "default:stone"},
	{"cobble", "Cobble", "default_cobble", "default:cobble"},
	{"stonebrick", "Stonebrick", "default_stone_brick", "default:stonebrick"},

	{"desertstone", "Desert Stone", "default_desert_stone", "default:desert_stone"},
	{"desert_cobble", "Desert Cobble", "default_desert_cobble", "default:desert_cobble"},
	{"desertstonebrick", "Desert Stone Brick", "default_desert_stone_brick", "default:desert_stonebrick"},

	{"sandstone", "Sandstone", "default_sandstone", "default:sandstone"},
	{"sandstonebrick", "Sandstone Brick", "default_sandstone_brick", "default:sandstonebrick"},

	{"dungeon_stone", "Dungeon Stone", "castle_dungeon_stone", "castle:dungeon_stone"},
	{"pavement", "Paving Stone", "castle_pavement_brick", "castle:pavement"},
	{"marble", "Marble", "lottores_marble", "lottores:marble"},
	{"marble_brick", "Marble Brick", "lottblocks_marble_brick", "lottblocks:marble_brick"},
	{"orc_brick", "Orc Brick", "lottblocks_orc_brick", "lottblocks:orc_brick"},

	{"mordor_stone", "Mordor Stone", "lottmapgen_mordor_stone", "lottmapgen:mordor_stone"},
}

for _, row in ipairs(hole.types) do
	local name = row[1]
	local desc = row[2]
	local tile = row[3]
	local craft_material = row[4]
	-- Node Definition
	minetest.register_node("castle:hole_"..name, {
		drawtype = "nodebox",
		description = SL(desc.." Murder Hole"),
		tiles = {tile..".png"},
		groups = {cracky=3},
		sounds = default.node_sound_defaults(),
		paramtype = "light",
		paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16,-8/16,-8/16,-4/16,8/16,8/16},
			{4/16,-8/16,-8/16,8/16,8/16,8/16},
			{-4/16,-8/16,-8/16,4/16,8/16,-4/16},
			{-4/16,-8/16,8/16,4/16,8/16,4/16},

		},
	},
	})
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:hole_"..name.." 4",
			recipe = {
			{"",craft_material, "" },
			{craft_material,"", craft_material},
			{"",craft_material, ""} },
		})
	end
end
