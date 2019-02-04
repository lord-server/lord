-- legacy (Minetest 0.4 mod)
-- Provides as much backwards-compatibility as feasible

--
-- Aliases to support loading 0.3 and old 0.4 worlds and inventories
--

minetest.register_node("legacy:dirt", {
	description = "Legacy Dirt",
	tiles = {"default_dirt.png"},
	groups = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 1}
})
minetest.register_abm({
	nodenames = {"legacy:dirt"},
	interval = 10,
	chance = 1,
	action = function(pos)
		minetest.remove_node(pos)
	end
})

minetest.register_alias("stone", "default:stone")
minetest.register_alias("stone_with_coal", "default:stone_with_coal")
minetest.register_alias("stone_with_iron", "default:stone_with_iron")
minetest.register_alias("dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("dirt_with_grass_footsteps", "default:dirt_with_grass_footsteps")
minetest.register_alias("dirt", "default:dirt")
minetest.register_alias("sand", "default:sand")
minetest.register_alias("gravel", "default:gravel")
minetest.register_alias("sandstone", "default:sandstone")
minetest.register_alias("clay", "default:clay")
minetest.register_alias("brick", "default:brick")
minetest.register_alias("tree", "default:tree")
minetest.register_alias("jungletree", "default:jungletree")
minetest.register_alias("junglegrass", "default:junglegrass")
minetest.register_alias("leaves", "default:leaves")
minetest.register_alias("cactus", "default:cactus")
minetest.register_alias("papyrus", "default:papyrus")
minetest.register_alias("bookshelf", "default:bookshelf")
minetest.register_alias("glass", "default:glass")
minetest.register_alias("wooden_fence", "default:fence_wood")
minetest.register_alias("rail", "carts:rail")
minetest.register_alias("default:rail", "carts:rail")
minetest.register_alias("ladder", "default:ladder")
minetest.register_alias("wood", "default:wood")
minetest.register_alias("mese", "default:mese")
minetest.register_alias("cloud", "default:cloud")
minetest.register_alias("water_flowing", "default:water_flowing")
minetest.register_alias("water_source", "default:water_source")
minetest.register_alias("lava_flowing", "default:lava_flowing")
minetest.register_alias("lava_source", "default:lava_source")
minetest.register_alias("torch", "default:torch")
minetest.register_alias("sign_wall", "default:sign_wall")
minetest.register_alias("furnace", "default:furnace")
minetest.register_alias("chest", "default:chest")
minetest.register_alias("locked_chest", "default:chest_locked")
minetest.register_alias("cobble", "default:cobble")
minetest.register_alias("mossycobble", "default:mossycobble")
minetest.register_alias("steelblock", "default:steelblock")
minetest.register_alias("nyancat", "default:nyancat")
minetest.register_alias("nyancat_rainbow", "default:nyancat_rainbow")
minetest.register_alias("sapling", "default:sapling")
minetest.register_alias("apple", "default:apple")

minetest.register_alias("WPick", "default:pick_wood")
minetest.register_alias("STPick", "default:pick_stone")
minetest.register_alias("SteelPick", "default:pick_steel")
minetest.register_alias("MesePick", "default:pick_mese")
minetest.register_alias("WShovel", "default:shovel_wood")
minetest.register_alias("STShovel", "default:shovel_stone")
minetest.register_alias("SteelShovel", "default:shovel_steel")
minetest.register_alias("WAxe", "default:axe_wood")
minetest.register_alias("STAxe", "default:axe_stone")
minetest.register_alias("SteelAxe", "default:axe_steel")
minetest.register_alias("WSword", "default:sword_wood")
minetest.register_alias("STSword", "default:sword_stone")
minetest.register_alias("SteelSword", "default:sword_steel")

minetest.register_alias("Stick", "default:stick")
minetest.register_alias("paper", "default:paper")
minetest.register_alias("book", "default:book")
minetest.register_alias("lump_of_coal", "default:coal_lump")
minetest.register_alias("lump_of_iron", "default:iron_lump")
minetest.register_alias("lump_of_clay", "default:clay_lump")
minetest.register_alias("steel_ingot", "default:steel_ingot")
minetest.register_alias("clay_brick", "default:clay_brick")
minetest.register_alias("scorched_stuff", "default:dirt")
minetest.register_alias("rat", "default:dirt")
minetest.register_alias("cooked_rat", "default:dirt")
minetest.register_alias("firefly", "lottplants:firefly")

minetest.register_alias("moreores:mineral_gold", "default:stone_with_gold")
minetest.register_alias("moreores:gold_block", "default:goldblock")
minetest.register_alias("moreores:gold_lump", "default:gold_lump")
minetest.register_alias("moreores:gold_ingot", "default:gold_ingot")
minetest.register_alias("moreores:mineral_copper", "default:stone_with_copper")
minetest.register_alias("moreores:copper_lump", "default:copper_lump")
minetest.register_alias("moreores:copper_ingot", "default:copper_ingot")
minetest.register_alias("moreores:copper_block", "default:copperblock")
minetest.register_alias("moreores:bronze_ingot", "default:bronze_ingot")
minetest.register_alias("moreores:bronze_block", "default:bronzeblock")

minetest.register_alias("diamonds:diamond_in_ground", "default:stone_with_diamond")
minetest.register_alias("diamonds:block", "default:diamondblock")
minetest.register_alias("diamonds:sword", "default:sword_diamond")
minetest.register_alias("diamonds:pick", "default:pick_diamond")
minetest.register_alias("diamonds:shovel", "default:shovel_diamond")
minetest.register_alias("diamonds:axe", "default:axe_diamond")
minetest.register_alias("diamonds:diamond", "default:diamond")
minetest.register_alias("diamonds:ingot", "default:diamond")

minetest.register_alias("lottspecial:helmet_birthday", "lottarmor:helmet_bronze")
minetest.register_alias("lottspecial:chestplate_birthday", "lottarmor:chestplate_bronze")
minetest.register_alias("lottspecial:leggings_birthday", "lottarmor:leggings_bronze")
minetest.register_alias("lottspecial:boots_birthday", "lottarmor:boots_bronze")
minetest.register_alias("lottspecial:shield_birthday", "lottarmor:shield_bronze")
minetest.register_alias("lottspecial:birthday_paxel", "lottores:mithrilpick")
minetest.register_alias("lottspecial:chest", "default:chest")
minetest.register_alias("lottspecial:cake_knife", "default:sword_steel")
minetest.register_alias("lottspecial:cake_slice", "default:apple")
minetest.register_alias("lottspecial:cake", "default:bread")

minetest.register_alias("hatches:hatch_alderwood_open", "lottblocks:hatch_alder_open")
minetest.register_alias("hatches:hatch_alderwood", "lottblocks:hatch_alder")
minetest.register_alias("hatches:hatch_birchwood_open", "lottblocks:hatch_birch_open")
minetest.register_alias("hatches:hatch_birchwood", "lottblocks:hatch_birch")
minetest.register_alias("hatches:hatch_lebethronwood_open", "lottblocks:hatch_lebethron_open")
minetest.register_alias("hatches:hatch_lebethronwood", "lottblocks:hatch_lebethron")
minetest.register_alias("hatches:hatch_mallornwood_open", "lottblocks:hatch_mallorn_open")
minetest.register_alias("hatches:hatch_mallornwood", "lottblocks:hatch_mallorn")

minetest.register_alias("lottspecial:jackomelon", "lottfarming:melon")
minetest.register_alias("lottspecial:jackomelon_lighted", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow_bottom", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow_light", "lottfarming:melon")

minetest.register_alias("farming:wheat", "farming:sheaf_wheat")
minetest.register_alias("farming:seed_wheat", "farming:wheat0")
minetest.register_alias("lottfarming:barley", "lottfarming:sheaf_barley")
minetest.register_alias("lottfarming:barley_seed", "lottfarming:barley0")
minetest.register_alias("lottfarming:corn", "lottfarming:ear_of_corn")
minetest.register_alias("lottfarming:corn_seed", "lottfarming:corn0")
minetest.register_alias("lottfarming:potato_seed", "lottfarming:half_of_potatoe")

minetest.register_alias("lord_homedecor:stair_Adobe", "stairs:stair_adobe")
minetest.register_alias("lord_homedecor:stair_Roofing", "stairs:stair_roofing")
minetest.register_alias("lord_homedecor:stair_grate", "stairs:stair_grate")
minetest.register_alias("lord_homedecor:stair_hardwood", "stairs:stair_hardwood")
minetest.register_alias("lord_homedecor:slab_Adobe", "stairs:slab_adobe")
minetest.register_alias("lord_homedecor:slab_Roofing", "stairs:slab_roofing")
minetest.register_alias("lord_homedecor:slab_grate", "stairs:slab_grate")
minetest.register_alias("lord_homedecor:slab_hardwood", "stairs:slab_hardwood")

minetest.register_alias("lottthrowing:arrow_fire", "lottpotion:athelasbrew_power1_arrow")
minetest.register_alias("lottthrowing:arrow_fire_entity", "lottpotion:limpe_power3_arrow")
minetest.register_alias("lottthrowing:arrow_fire_blue", "lottpotion:miruvor_power2_arrow")
minetest.register_alias("lottthrowing:arrow_fire_blue_entity", "lottpotion:spiderpoison_corruption3_arrow")
minetest.register_alias("lottthrowing:bolt_fire", "lottthrowing:bolt")
minetest.register_alias("lottpotion:bolt", "lottthrowing:bolt")

minetest.register_alias("lottplants:anemones_fake", "lottplants:anemones")
minetest.register_alias("lottplants:asphodel_fake", "lottplants:asphodel")
minetest.register_alias("lottplants:eglantive_fake", "lottplants:eglantive")
minetest.register_alias("lottplants:elanor_fake", "lottplants:elanor")
minetest.register_alias("lottplants:iris_fake", "lottplants:iris")
minetest.register_alias("lottplants:lissuin_fake", "lottplants:lissuin")
minetest.register_alias("lottplants:mallos_fake", "lottplants:mallos")
minetest.register_alias("lottplants:niphredil_fake", "lottplants:niphredil")
minetest.register_alias("lottplants:seregon_fake", "lottplants:seregon")
minetest.register_alias("lottplants:brambles_of_mordor_fake", "lottplants:brambles_of_mordor")
minetest.register_alias("lottplants:pilinehtar_fake", "lottplants:pilinehtar")

minetest.register_alias("defaults:sandst0nebrick",     "defaults:default_sandstonebrick")
minetest.register_alias("defaults:sandst0ne",          "defaults:default_sandstone")
minetest.register_alias("defaults:desert_st0ne_brick", "defaults:default_desert_stonebrick")
minetest.register_alias("defaults:st0ne_brick",        "defaults:default_stonebrick")
minetest.register_alias("defaults:bricks",             "defaults:default_brick")
minetest.register_alias("defaults:desert_c0bble",      "defaults:default_desert_cobble")
minetest.register_alias("defaults:c0bble",             "defaults:default_cobble")
minetest.register_alias("defaults:desert_st0ne",       "defaults:default_desert_stone")
minetest.register_alias("defaults:st0ne",              "defaults:default_stone")


-- Corpses

minetest.register_alias("bones:bones", "bones:corpse_man_male")

for _, gender in pairs({"male", "female"}) do
	for _, race in pairs({"dwarf", "orc", "man", "elf", "hobbit"}) do
		local n = "bones:corpse_"..race.."_"..gender
		minetest.register_alias(n, n.."_1")
	end
end

gaurds = {"dwarven", "elven", "gondor", "orc", "rohan", "uruk_hai"}
for i, v in pairs(gaurds) do
    minetest.register_alias("lottnpc:" .. v .. "_guard_spawner", "legacy:dirt")
    minetest.register_entity(":lottnpc:" .. v .. "_guard", {
        physical = false,
        on_step = function(self)
            self.object:remove()
        end
    })
end

minetest.register_entity(":npcf:nametag", {
	physical = false,
	on_step = function(self)
		self.object:remove()
	end
})

minetest.register_alias("lottarmor:helmet_rohan", "lottarmor:helmet_steel")
minetest.register_alias("lottarmor:chestplate_rohan", "lottarmor:chestplate_steel")
minetest.register_alias("lottarmor:boots_rohan", "lottarmor:boots_steel")

-- Tools
for _, tooltype in pairs({"pick", "shovel", "axe", "sword"}) do
	-- ex-default
	for _, material in pairs({"wood", "stone", "steel", "bronze"}) do
		minetest.register_alias("default:"..tooltype.."_"..material,
			"tools:"..tooltype.."_"..material)
	end
	-- ex-lottores
	for _, material in pairs({"copper", "tin", "silver", "gold", "galvorn", "mithril"}) do
		minetest.register_alias("lottores:"..material..tooltype,
			"tools:"..tooltype.."_"..material)
	end
end

local materials = {"wood", "stone", "steel", "bronze", "copper", "tin", "silver", "gold", "galvorn", "mithril"}
-- ex-lottweapons
for _, tooltype in pairs({"battleaxe", "warhammer", "spear", "dagger"}) do
	for _, material in pairs(materials) do
		minetest.register_alias("lottweapons:"..material.."_"..tooltype,
			"tools:"..tooltype.."_"..material)
	end
end

minetest.register_alias("lottweapons:elven_sword", "tools:sword_elven")
minetest.register_alias("lottweapons:orc_sword", "tools:sword_orc")

lord.mod_loaded()
minetest.register_alias("lottthrowing:arrow", "arrows:arrow_steel")
minetest.register_alias("lottthrowing:arrow_mithril", "arrows:arrow_mithril")
minetest.register_alias("lottthrowing:bolt", "arrows:bolt_steel")
minetest.register_alias("lottthrowing:bolt_mithril", "arrows:bolt_mithril")

minetest.register_alias("lottthrowing:axe_dwarf", "arrows:axe_dwarf")
minetest.register_alias("lottthrowing:axe_elf", "arrows:axe_elf")
minetest.register_alias("lottthrowing:axe_steel", "arrows:axe_steel")
minetest.register_alias("lottthrowing:axe_galvorn", "arrows:axe_galvorn")

minetest.register_alias('bees:honey_extractor', 'bees:extractor')
minetest.register_alias('bees:honey_bottle', 'bees:bottle_honey')

minetest.register_alias("castle:pillars_bottom", "castle:pillars_stonewall_bottom")
minetest.register_alias("castle:pillars_top", "castle:pillars_stonewall_top")
minetest.register_alias("castle:pillars_middle", "castle:pillars_stonewall_middle")

minetest.register_alias("castle:arrowslit", "castle:arrowslit_stonewall")
minetest.register_alias("castle:arrowslit_hole", "castle:arrowslit_stonewall_hole")
minetest.register_alias("castle:arrowslit", "castle:arrowslit_stonewall_cross")

minetest.register_alias("darkage:box", "castle:crate")
minetest.register_alias("cottages:straw", "farming:straw")
minetest.register_alias("castle:straw", "farming:straw")
minetest.register_alias("darkage:straw", "farming:straw")
minetest.register_alias("cottages:straw_bale", "castle:bound_straw")
minetest.register_alias("darkage:straw_bale", "castle:bound_straw")
minetest.register_alias("darkage:lamp", "castle:street_light")

--Default
minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_jungletree", "default:jungletree")
minetest.register_alias("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_clay", "default:clay")
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_mossycobble", "default:mossycobble")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_junglegrass", "default:junglegrass")
minetest.register_alias("mapgen_stone_with_coal", "default:stone_with_coal")
minetest.register_alias("mapgen_stone_with_iron", "default:stone_with_iron")
minetest.register_alias("mapgen_mese", "default:mese")
minetest.register_alias("mapgen_desert_sand", "default:desert_sand")
minetest.register_alias("mapgen_desert_stone", "default:desert_stone")
minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")

minetest.register_alias("default:mese_block", "default:mese")
minetest.register_alias("snow", "default:snow")

--Flowes
minetest.register_alias("flowers:flower_dandelion_white", "flowers:dandelion_white")
minetest.register_alias("flowers:flower_dandelion_yellow", "flowers:dandelion_yellow")
minetest.register_alias("flowers:flower_geranium", "flowers:geranium")
minetest.register_alias("flowers:flower_rose", "flowers:rose")
minetest.register_alias("flowers:flower_tulip", "flowers:tulip")
minetest.register_alias("flowers:flower_viola", "flowers:viola")
minetest.register_alias("flowers:flower_cactus_decor", "flowers:cactus_decor")

--Beds
-- aliases for PA's beds mod
minetest.register_alias("beds:bed_bottom_red", "beds:bed_bottom")
minetest.register_alias("beds:bed_top_red", "beds:bed_top")
-- aliases for beds from lottblocks mod
minetest.register_alias("lottblocks:bed_red",			"beds:bed_bottom")
minetest.register_alias("lottblocks:bed_bottom_red",	"beds:bed_bottom")
minetest.register_alias("lottblocks:bed_top_red",		"beds:bed_top")
minetest.register_alias("lottblocks:bed_blue",			"beds:bed_bottom")
minetest.register_alias("lottblocks:bed_bottom_blue",	"beds:bed_bottom")
minetest.register_alias("lottblocks:bed_top_blue",		"beds:bed_top")
minetest.register_alias("lottblocks:bed_green",			"beds:bed_bottom")
minetest.register_alias("lottblocks:bed_bottom_green",	"beds:bed_bottom")
minetest.register_alias("lottblocks:bed_top_green",		"beds:bed_top")

--Bucket
minetest.register_alias("bucket", "bucket:bucket_empty")
minetest.register_alias("bucket_water", "bucket:bucket_water")
minetest.register_alias("bucket_lava", "bucket:bucket_lava")

--Lord Homedecor
minetest.register_alias("fakegrass", "lord_homedecor:fakegrass")
minetest.register_alias("adobe", "lord_homedecor:Adobe")
minetest.register_alias("building_blocks_roofing", "lord_homedecor:Roofing")
minetest.register_alias("hardwood", "lord_homedecor:hardwood")
minetest.register_alias("sticks", "lord_homedecor:sticks")
minetest.register_alias("lord_homedecor:faggot", "lord_homedecor:sticks")
minetest.register_alias("lord_homedecor:coffeetable", "lord_homedecor:coffeetable_back")
minetest.register_alias("lord_homedecor:bench_large_1_left", "lord_homedecor:bench_large_1")
minetest.register_alias("lord_homedecor:bench_large_1_right", "air")
minetest.register_alias("lord_homedecor:bench_large_2_left", "lord_homedecor:bench_large_2")
minetest.register_alias("lord_homedecor:bench_large_2_right", "air")
minetest.register_alias("lord_homedecor:well_top", "air")
minetest.register_alias("lord_homedecor:well_base", "lord_homedecor:well")
minetest.register_alias("gloopblocks:shrubbery", "lord_homedecor:shrubbery_green")
minetest.register_alias("gloopblocks:shrubbery_large", "lord_homedecor:shrubbery_large_green")
minetest.register_alias('bars', 'lord_homedecor:bars')
minetest.register_alias('binding_bars', 'lord_homedecor:L_binding_bars')
minetest.register_alias('chains', 'lord_homedecor:chains')
minetest.register_alias('torch_wall', 'lord_homedecor:torch_wall')
--Переместить обратно (в longsofa.lua)!!!
--minetest.register_alias("lord_homedecor:longsofa_left_"..colour, "air")
--minetest.register_alias("lord_homedecor:longsofa_middle_"..colour, "air")
--minetest.register_alias("lord_homedecor:longsofa_right_"..colour, "lord_homedecor:longsofa_"..colour)

--Lottblocks
minetest.register_alias("lottmapgen:hobbit_chest", "lottblocks:hobbit_chest")
minetest.register_alias("lottmapgen:gondor_chest", "lottblocks:gondor_chest")
minetest.register_alias("lottmapgen:rohan_chest", "lottblocks:rohan_chest")
minetest.register_alias("lottmapgen:elfloth_chest", "lottblocks:elfloth_chest")
minetest.register_alias("lottmapgen:elfmirk_chest", "lottblocks:elfmirk_chest")
minetest.register_alias("lottmapgen:mordor_chest", "lottblocks:mordor_chest")
minetest.register_alias("lottmapgen:angmar_chest", "lottblocks:angmar_chest")
minetest.register_alias("lottother:lamp_wood", "lottblocks:lamp_wood")
minetest.register_alias("lottother:lamp_middle_wood", "lottblocks:lamp_middle_wood")
minetest.register_alias("lottother:lamp_top_wood", "lottblocks:lamp_top_wood")
minetest.register_alias("lottother:tiny_lamp_wood", "lottblocks:small_lamp_wood")
minetest.register_alias("lottother:lamp_wood_alder", "lottblocks:lamp_alder")
minetest.register_alias("lottother:lamp_middle_wood_alder", "lottblocks:lamp_middle_alder")
minetest.register_alias("lottother:lamp_top_wood_alder", "lottblocks:lamp_top_alder")
minetest.register_alias("lottother:tiny_lamp_wood_alder", "lottblocks:small_lamp_alder")
minetest.register_alias("lottother:lamp_wood_birch", "lottblocks:lamp_birch")
minetest.register_alias("lottother:lamp_middle_wood_birch", "lottblocks:lamp_middle_birch")
minetest.register_alias("lottother:lamp_top_wood_birch", "lottblocks:lamp_top_birch")
minetest.register_alias("lottother:tiny_lamp_wood_birch", "lottblocks:small_lamp_birch")
minetest.register_alias("lottother:lamp_wood_lebethron", "lottblocks:lamp_lebethron")
minetest.register_alias("lottother:lamp_middle_wood_lebethron", "lottblocks:lamp_middle_lebethron")
minetest.register_alias("lottother:lamp_top_wood_lebethron", "lottblocks:lamp_top_lebethron")
minetest.register_alias("lottother:tiny_lamp_wood_lebethron", "lottblocks:small_lamp_lebethron")
minetest.register_alias("lottother:lamp_wood_mallorn", "lottblocks:lamp_mallorn")
minetest.register_alias("lottother:lamp_middle_wood_mallorn", "lottblocks:lamp_middle_mallorn")
minetest.register_alias("lottother:lamp_top_wood_mallorn", "lottblocks:lamp_top_mallorn")
minetest.register_alias("lottother:tiny_lamp_wood_mallorn", "lottblocks:small_lamp_mallorn")

--Lottfarming
minetest.register_alias("lottfarming:melon_slice", "lottfarming:melon")

--Lottother
minetest.register_alias("lottother:gondorms_on", "lottother:gondorms")
minetest.register_alias("lottother:gondorms_off", "lottother:gondorms")
minetest.register_alias("lottother:rohanms_on", "lottother:rohanms")
minetest.register_alias("lottother:rohanms_off", "lottother:rohanms")
minetest.register_alias("lottother:angmarms_on", "lottother:angmarms")
minetest.register_alias("lottother:angmarms_off", "lottother:angmarms")
minetest.register_alias("lottother:hobbitms_on", "lottother:hobbitms")
minetest.register_alias("lottother:hobbitms_off", "lottother:hobbitms")
minetest.register_alias("lottother:elfms_on", "lottother:elfms")
minetest.register_alias("lottother:elfms_off", "lottother:elfms")
minetest.register_alias("lottother:mordorms_on", "lottother:mordorms")
minetest.register_alias("lottother:mordorms_off", "lottother:mordorms")

--Lottplants
minetest.register_alias("lottmapgen:mirkleaves", "lottplants:mirkleaf")

--Protector Lott
minetest.register_alias("protector_lott:protect", "protector_lott:protect_stone")

--Screwdriver
minetest.register_alias("screwdriver:screwdriver1", "screwdriver:screwdriver")
minetest.register_alias("screwdriver:screwdriver2", "screwdriver:screwdriver")
minetest.register_alias("screwdriver:screwdriver3", "screwdriver:screwdriver")
minetest.register_alias("screwdriver:screwdriver4", "screwdriver:screwdriver")

--Signs Lib
minetest.register_alias("lord_homedecor:fence_wood_with_sign", "signs:sign_post")
minetest.register_alias("sign_wall_locked", "locked_sign:sign_wall_locked")

--Wool
-- Backwards compatibility with jordach's 16-color wool mod
minetest.register_alias("wool:dark_blue", "wool:blue")
minetest.register_alias("wool:gold", "wool:yellow")
