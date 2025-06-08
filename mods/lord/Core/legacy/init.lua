-- legacy (Minetest 0.4 mod)
-- Provides as much backwards-compatibility as feasible

--
-- Aliases to support loading 0.3 and old 0.4 worlds and inventories
--

minetest.register_alias("legacy:dirt", "default:dirt")

--- Эти алиасы полностью из MTG/default (5.4.1), наши расположены ниже

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
minetest.register_alias("ladder", "default:ladder_wood")
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
minetest.register_alias("snow", "default:snow")

-- 'mese_block' was used for a while for the block form of mese
minetest.register_alias("default:mese_block", "default:mese")

-- эти алиасы нам не нужны, т.к. у нас остались из LOTT (lord_trees:pine_tree lord_planks:pine
---- Aliases for corrected pine node names
--minetest.register_alias("default:pinetree", "default:pine_tree")
--minetest.register_alias("default:pinewood", "default:pine_wood")

minetest.register_alias("default:ladder", "default:ladder_wood")
minetest.register_alias("default:sign_wall_wood", "default:sign_wall")



--- Далее идут наши алиасы

-- also see mods/lord/Blocks/lord_trees/legacy.lua

minetest.register_alias("scorched_stuff", "default:scorched_stuff")
minetest.register_alias("rat", "default:dirt")
minetest.register_alias("cooked_rat", "default:dirt")
minetest.register_alias("firefly", "lottplants:fireflies")

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

minetest.register_alias("hatches:hatch_alderwood_open", "lord_wooden_stuff:hatch_alder_open")
minetest.register_alias("hatches:hatch_alderwood", "lord_wooden_stuff:hatch_alder")
minetest.register_alias("hatches:hatch_birchwood_open", "lord_wooden_stuff:hatch_birch_open")
minetest.register_alias("hatches:hatch_birchwood", "lord_wooden_stuff:hatch_birch")
minetest.register_alias("hatches:hatch_lebethronwood_open", "lord_wooden_stuff:hatch_lebethron_open")
minetest.register_alias("hatches:hatch_lebethronwood", "lord_wooden_stuff:hatch_lebethron")
minetest.register_alias("hatches:hatch_mallornwood_open", "lord_wooden_stuff:hatch_mallorn_open")
minetest.register_alias("hatches:hatch_mallornwood", "lord_wooden_stuff:hatch_mallorn")

minetest.register_alias("lottspecial:jackomelon", "lottfarming:melon")
minetest.register_alias("lottspecial:jackomelon_lighted", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow_bottom", "lottfarming:melon")
minetest.register_alias("lottspecial:scarecrow_light", "lottfarming:melon")

minetest.register_alias("farming:wheat", "farming:sheaf_wheat")

minetest.register_alias("lottfarming:barley", "lottfarming:sheaf_barley")
-- если будет ещё замена, то в этой строке тоже стоит поменять на новый вариант:
--minetest.register_alias("lottfarming:barley_seed", "lottfarming:barley0") -- когда-то меняли на barley0
minetest.register_alias("lottfarming:barley0", "lottfarming:barley_seed")   -- теперь вернули barley_seed

minetest.register_alias("lottfarming:corn", "lottfarming:ear_of_corn")
-- если будет ещё замена, то в этой строке тоже стоит поменять на новый вариант:
--minetest.register_alias("lottfarming:corn_seed", "lottfarming:corn0")  -- когда-то меняли на corn0 (#46, 16425fd)
minetest.register_alias("lottfarming:corn0", "lottfarming:corn_seed")    -- теперь вернули corn_seed

-- если будет ещё замена, то в этой строке тоже стоит поменять на новый вариант:                              (7f002949)
--minetest.register_alias("lottfarming:potato_seed", "lottfarming:half_of_potatoe")-- когда-то меняли на half_of_potatoe
minetest.register_alias("lottfarming:half_of_potatoe", "lottfarming:potato_seed")  -- теперь вернули potato_seed

minetest.register_alias("lord_homedecor:stair_Adobe", "stairs:stair_adobe")
minetest.register_alias("lord_homedecor:stair_Roofing", "stairs:stair_roofing")
minetest.register_alias("lord_homedecor:stair_grate", "stairs:stair_grate")
minetest.register_alias("lord_homedecor:stair_hardwood", "stairs:stair_hardwood")
minetest.register_alias("lord_homedecor:slab_Adobe", "stairs:slab_adobe")
minetest.register_alias("lord_homedecor:slab_Roofing", "stairs:slab_roofing")
minetest.register_alias("lord_homedecor:slab_grate", "stairs:slab_grate")
minetest.register_alias("lord_homedecor:slab_hardwood", "stairs:slab_hardwood")

minetest.register_alias("lottthrowing:bolt_fire", "lord_projectiles:steel_bolt")
minetest.register_alias("lottpotion:bolt", "lord_projectiles:steel_bolt")

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

-- It was failed attempt to add a weather mod. Mod was deleted.
minetest.register_alias("regional_weather:ice",        "default:water_source")

-- Corpses
for _, gender in pairs({"male", "female"}) do
	for _, race in pairs({"dwarf", "orc", "man", "elf", "hobbit"}) do
		local n = "bones:corpse_"..race.."_"..gender
		minetest.register_alias(n, n.."_1")
	end
end

gaurds = {"dwarven", "elven", "gondor", "orc", "rohan", "uruk_hai"}
for i, v in pairs(gaurds) do
    minetest.register_alias("lottnpc:" .. v .. "_guard_spawner", "default:dirt")
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

minetest.register_alias("lottthrowing:arrow", "lord_projectiles:steel_arrow")
minetest.register_alias("lottthrowing:arrow_mithril", "lord_projectiles:mithril_arrow")
minetest.register_alias("lottthrowing:bolt", "lord_projectiles:steel_bolt")
minetest.register_alias("lottthrowing:bolt_mithril", "lord_projectiles:mithril_bolt")

minetest.register_alias("arrows:arrow_steel", "lord_projectiles:steel_arrow")
minetest.register_alias("arrows:arrow_mithril", "lord_projectiles:mithril_arrow")
minetest.register_alias("arrows:bolt_steel", "lord_projectiles:steel_bolt")
minetest.register_alias("arrows:bolt_mithril", "lord_projectiles:mithril_bolt")

minetest.register_alias("lottthrowing:axe_dwarf", "lord_projectiles:mithril_bolt")
minetest.register_alias("lottthrowing:axe_elf", "lord_projectiles:galvorn_bolt")
minetest.register_alias("lottthrowing:axe_steel", "lord_projectiles:steel_bolt")
minetest.register_alias("lottthrowing:axe_galvorn", "lord_projectiles:galvorn_bolt")

minetest.register_alias("arrows:axe_dwarf", "lord_projectiles:mithril_bolt")
minetest.register_alias("arrows:axe_elf", "lord_projectiles:galvorn_bolt")
minetest.register_alias("arrows:axe_steel", "lord_projectiles:steel_bolt")
minetest.register_alias("arrows:axe_galvorn", "lord_projectiles:galvorn_bolt")

minetest.register_alias("lottthrowing:bow_wood", "lord_archery:apple_wood_bow")
minetest.register_alias("lottthrowing:bow_wood_alder", "lord_archery:alder_wood_bow")
minetest.register_alias("lottthrowing:bow_wood_birch", "lord_archery:birch_wood_bow")
minetest.register_alias("lottthrowing:bow_wood_lebethron", "lord_archery:lebethron_wood_bow")
minetest.register_alias("lottthrowing:bow_wood_mallorn", "lord_archery:mallorn_wood_bow")

minetest.register_alias("lottthrowing:crossbow_galvorn", "lord_archery:galvorn_crossbow")
minetest.register_alias("lottthrowing:crossbow_gold", "lord_archery:gold_crossbow")
minetest.register_alias("lottthrowing:crossbow_magical", "lord_archery:mithril_crossbow")
minetest.register_alias("lottthrowing:crossbow_mithril", "lord_archery:mithril_crossbow")
minetest.register_alias("lottthrowing:crossbow_silver", "lord_archery:silver_crossbow")
minetest.register_alias("lottthrowing:crossbow_steel", "lord_archery:steel_crossbow")
minetest.register_alias("lottthrowing:crossbow_tin", "lord_archery:tin_crossbow")
minetest.register_alias("lottthrowing:crossbow_wood", "lord_archery:wooden_crossbow")

minetest.register_alias("arrows:fireball", "lord_projectiles:fire_ball")
minetest.register_alias("arrows:darkball", "lord_projectiles:dark_ball")


minetest.register_alias("fire:campfire", "campfire:campfire")
minetest.register_alias("fire:fireplace", "campfire:fireplace")
minetest.register_alias("fire:campfire_active", "campfire:campfire_active")
minetest.register_alias("fire:ash", "campfire:ash")

minetest.register_alias("carts:accelerating_rail", "carts:powerrail")
minetest.register_alias("carts:stopping_rail", "carts:brakerail")

minetest.register_alias("lottinventory:small", "bags:small")
minetest.register_alias("lottinventory:medium", "bags:medium")
minetest.register_alias("lottinventory:large", "bags:large")

minetest.register_alias("lottinventory:crafts_book", "lord_books:crafts_book")
minetest.register_alias("lottinventory:brewing_book", "lord_books:brewing_book")
minetest.register_alias("lottinventory:cooking_book", "lord_books:cooking_book")
minetest.register_alias("lottinventory:forbidden_crafts_book", "lord_books:forbidden_crafts_book")
minetest.register_alias("lottinventory:master_book", "lord_books:master_book")
minetest.register_alias("lottinventory:potions_book", "lord_books:potions_book")
minetest.register_alias("lottinventory:protection_book", "lord_books:protection_book")

minetest.register_alias("lottother:tapestry_top", "castle:tapestry_top")

-- вынесено из MTG/default/legacy.lua (требуется для hopper):
default.gui_bg     = ""
default.gui_bg_img = ""
default.gui_slots  = ""
