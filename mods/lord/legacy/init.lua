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

minetest.register_alias("castle:jailbars",             "jailbars:jailbars_steel")
for i = 1,15 do
	minetest.register_alias("castle:jailbars_"..i,             "jailbars:jailbars_steel_"..i)
end

minetest.register_alias("castle:jail_door_lock",       "jailbars:jail_door_lock_steel")
minetest.register_alias("castle:jail_door",            "jailbars:jail_door_steel")

minetest.register_alias("castle:jail_door_t_1",         "jailbars:jail_door_steel_t_1")
minetest.register_alias("castle:jail_door_t_2",         "jailbars:jail_door_steel_t_2")
minetest.register_alias("castle:jail_door_b_1",         "jailbars:jail_door_steel_b_1")
minetest.register_alias("castle:jail_door_b_2",         "jailbars:jail_door_steel_b_2")

minetest.register_alias("castle:jail_door_lock_t_1",         "jailbars:jail_door_steel_lock_t_1")
minetest.register_alias("castle:jail_door_lock_t_2",         "jailbars:jail_door_steel_lock_t_2")
minetest.register_alias("castle:jail_door_lock_b_1",         "jailbars:jail_door_steel_lock_b_1")
minetest.register_alias("castle:jail_door_lock_b_2",         "jailbars:jail_door_steel_lock_b_2")

minetest.register_alias("protector_lott:jail_door", "protector_lott:jail_door_steel")
minetest.register_alias("protector_lott:jail_door_t_1", "protector_lott:jail_door_steel_t_1")
minetest.register_alias("protector_lott:jail_door_t_2", "protector_lott:jail_door_steel_t_2")
minetest.register_alias("protector_lott:jail_door_b_1", "protector_lott:jail_door_steel_b_1")
minetest.register_alias("protector_lott:jail_door_b_2", "protector_lott:jail_door_steel_b_2")

-- Corpses
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

minetest.register_alias("lottthrowing:arrow", "arrows:arrow_steel")
minetest.register_alias("lottthrowing:arrow_mithril", "arrows:arrow_mithril")
minetest.register_alias("lottthrowing:bolt", "arrows:bolt_steel")
minetest.register_alias("lottthrowing:bolt_mithril", "arrows:bolt_mithril")

minetest.register_alias("lottthrowing:axe_dwarf", "arrows:axe_dwarf")
minetest.register_alias("lottthrowing:axe_elf", "arrows:axe_elf")
minetest.register_alias("lottthrowing:axe_steel", "arrows:axe_steel")
minetest.register_alias("lottthrowing:axe_galvorn", "arrows:axe_galvorn")

minetest.register_alias("fire:campfire", "campfire:campfire")
minetest.register_alias("fire:fireplace", "campfire:fireplace")
minetest.register_alias("fire:campfire_active", "campfire:campfire_active")
minetest.register_alias("fire:ash", "campfire:ash")

