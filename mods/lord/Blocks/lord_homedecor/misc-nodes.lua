local S = minetest.get_mod_translator()

local pot_colors = {"terracotta"}

for _, p in ipairs(pot_colors) do
lord_homedecor.register("flower_pot_"..p, {
	description = S("Flower Pot ("..p..")"),
	mesh = "homedecor_flowerpot.obj",
	tiles = {
		"homedecor_flower_pot_"..p..".png",
		"default_dirt.png^[colorize:#000000:175"
	},
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_stone_defaults(),
})
end

local flowers_list = {
	{ "Rose",				"rose", 			"flowers:rose" },
	{ "Tulip",				"tulip", 			"flowers:tulip" },
	{ "Yellow Dandelion",	"dandelion_yellow",	"flowers:dandelion_yellow" },
	{ "White Dandelion",	"dandelion_white",	"flowers:dandelion_white" },
	{ "Blue Geranium",		"geranium",			"flowers:geranium" },
	{ "Viola",				"viola",			"flowers:viola" },
	{ "Cactus",				"cactus",			"flowers:cactus_decor" },
	{ "Bonsai",				"bonsai",			"default:sapling" }
}

for i in ipairs(flowers_list) do
	local flowerdesc	= flowers_list[i][1]
	local flower		= flowers_list[i][2]
	local craftwith		= flowers_list[i][3]

	lord_homedecor.register("potted_"..flower, {
		description = S("Potted flower ("..flowerdesc..")"),
		mesh = "homedecor_potted_plant.obj",
		tiles = {
			"homedecor_flower_pot_terracotta.png",
			"default_dirt.png^[colorize:#000000:175",
			"flowers_"..flower..".png"
		},
		use_texture_alpha = "clip",
		walkable = false,
		groups = {snappy = 3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 }
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:potted_"..flower,
		recipe = { craftwith, "lord_homedecor:flower_pot_small" }
	})

	minetest.register_alias("flowers:flower_"..flower.."_pot", "lord_homedecor:potted_"..flower)
	minetest.register_alias("flowers:potted_"..flower, "lord_homedecor:potted_"..flower)
	minetest.register_alias("flowers:flower_pot", "lord_homedecor:flower_pot_small")
end

lord_homedecor.register("pole_wrought_iron", {
    description = S("Wrought Iron Pole"),
    tiles = { "homedecor_generic_metal_wrought_iron.png^homedecor_generic_metal_lines_overlay.png" },
    inventory_image = "homedecor_pole_wrought_iron_inv.png",
    wield_image = "homedecor_pole_wrought_iron_inv.png",
    selection_box = {
            type = "fixed",
            fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
    },
	node_box = {
		type = "fixed",
                fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
	},
    groups = {snappy=3},
    sounds = default.node_sound_wood_defaults(),
})

lord_homedecor.banister_materials = {
	{	"wood",
		"wood",
		"default_wood.png",
		"default_wood.png",
		"default:wood",
		"default:stick",
		"",
		""
	},
	{
		"junglewood",
		"junglewood",
		"default_junglewood.png",
		"default_junglewood.png",
		"default:junglewood",
		"lottblocks:stick_junglewood",
		"",
		""
	},
	{
		"alder",
		"alder",
		"lord_planks_alder.png",
		"lord_planks_alder.png",
		"lord_planks:alder",
		"lottblocks:stick_alder",
		"",
		"",
	},
	{
		"birch",
		"birch",
		"lord_planks_birch.png",
		"lord_planks_birch.png",
		"lord_planks:birch",
		"lottblocks:stick_birch",
		"",
		"",
	},
	{
		"pine",
		"pine",
		"lord_planks_pine.png",
		"lord_planks_pine.png",
		"lord_planks:pine",
		"lottblocks:stick_pine",
		"",
		"",
	},
	{
		"lebethron",
		"lebethron",
		"lord_planks_lebethron.png",
		"lord_planks_lebethron.png",
		"lord_planks:lebethron",
		"lottblocks:stick_lebethron",
		"",
		"",
	},
	{
		"mallorn",
		"mallorn",
		"lord_planks_mallorn.png",
		"lord_planks_mallorn.png",
		"lord_planks:mallorn",
		"lottblocks:stick_mallorn",
		"",
		"",
	},
	{
		"hardwood",
		"hardwood",
		"lord_planks_hardwood.png",
		"lord_planks_hardwood.png",
		"lord_planks:hardwood",
		"lottblocks:stick_hardwood",
		"",
		"",
	},
	{	"wrought_iron",
		"wrought iron",
		"homedecor_generic_metal_wrought_iron.png",
		"homedecor_generic_metal_wrought_iron.png",
		"default:steel_ingot",
		"lord_homedecor:pole_wrought_iron",
		"",
		""
	}
}

-- перила для лестниц
for _, side in ipairs({"diagonal_left", "diagonal_right", "horizontal"}) do

	for i in ipairs(lord_homedecor.banister_materials) do

		local name = lord_homedecor.banister_materials[i][1]
		local nodename = "banister_"..name.."_"..side

		local groups = { snappy = 3, not_in_creative_inventory = 1 }
		local cbox = {
			type = "fixed",
			fixed = { -9/16, -3/16, 5/16, 9/16, 24/16, 8/16 }
		}

		if side == "horizontal" then
			groups = { snappy = 3 }
			cbox = {
				type = "fixed",
				fixed = { -8/16, -8/16, 5/16, 8/16, 8/16, 8/16 }
			}
		else
			minetest.register_alias(string.replace("lord_homedecor:"..nodename, "diagonal_", ""), "lord_homedecor:"..nodename)
		end

		lord_homedecor.register(nodename, {
			description = S("Banister for Stairs ("..lord_homedecor.banister_materials[i][2]..", "..side..")"),
			mesh = "homedecor_banister_"..side..".obj",
			tiles = {
				lord_homedecor.banister_materials[i][3],
				lord_homedecor.banister_materials[i][4]
			},
			groups = groups,
			selection_box = cbox,
			collision_box = cbox,
			on_place = lord_homedecor.place_banister,
			drop = "lord_homedecor:banister_"..name.."_horizontal",
		})
	end
end
