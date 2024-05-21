local SL = lord.require_intllib()

minetest.register_alias("castle:pillars_bottom", "castle:pillars_stonewall_bottom")
minetest.register_alias("castle:pillars_top", "castle:pillars_stonewall_top")
minetest.register_alias("castle:pillars_middle", "castle:pillars_stonewall_middle")

local pillar = {}

pillar.types = {
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

    {"mordor_stone", "Mordor Stone", "lord_rocks_mordor_stone", "lord_rocks:mordor_stone"},
}

for _, row in ipairs(pillar.types) do
	local name = row[1]
	local desc = row[2]
	local tile = row[3]
	local craft_material = row[4]
	-- Node Definition
	minetest.register_node("castle:pillars_"..name.."_bottom", {
	    drawtype = "nodebox",
		description = SL(desc.." Pillar Base"),
		tiles = {tile..".png"},
		groups = {cracky=3},
		sounds = default.node_sound_defaults(),
	    paramtype = "light",
	    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.375000,0.500000},
			{-0.375000,-0.375000,-0.375000,0.375000,-0.125000,0.375000},
			{-0.250000,-0.125000,-0.250000,0.250000,0.500000,0.250000},
		},
	},
	})
	minetest.register_node("castle:pillars_"..name.."_top", {
	    drawtype = "nodebox",
		description = SL(desc.." Pillar Top"),
		tiles = {tile..".png"},
		groups = {cracky=3},
		sounds = default.node_sound_defaults(),
	    paramtype = "light",
	    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000},
			{-0.375000,0.062500,-0.375000,0.375000,0.312500,0.375000},
			{-0.250000,-0.500000,-0.250000,0.250000,0.062500,0.250000},
		},
	},
	})
	minetest.register_node("castle:pillars_"..name.."_middle", {
	    drawtype = "nodebox",
		description = SL(desc.." Pillar Middle"),
		tiles = {tile..".png"},
		groups = {cracky=3},
		sounds = default.node_sound_defaults(),
	    paramtype = "light",
	    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.250000,0.250000,0.500000,0.250000},
		},
	},
	})
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:pillars_"..name.."_bottom 4",
			recipe = {
			{"",craft_material,""},
			{"",craft_material,""},
			{craft_material,craft_material,craft_material} },
		})
	end
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:pillars_"..name.."_top 4",
			recipe = {
			{craft_material,craft_material,craft_material},
			{"",craft_material,""},
			{"",craft_material,""} },
		})
	end
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:pillars_"..name.."_middle 4",
			recipe = {
			{craft_material,craft_material},
			{craft_material,craft_material},
			{craft_material,craft_material} },
		})
	end
end
