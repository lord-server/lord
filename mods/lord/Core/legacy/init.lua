-- legacy (Minetest 0.4 mod)
-- Provides as much backwards-compatibility as feasible

--
-- Aliases to support loading 0.3 and old 0.4 worlds and inventories
--

core.register_alias("legacy:dirt", "default:dirt")

--- Эти алиасы полностью из MTG/default (5.4.1), наши расположены ниже

core.register_alias("stone", "default:stone")
core.register_alias("stone_with_coal", "default:stone_with_coal")
core.register_alias("stone_with_iron", "default:stone_with_iron")
core.register_alias("dirt_with_grass", "default:dirt_with_grass")
core.register_alias("dirt_with_grass_footsteps", "default:dirt_with_grass_footsteps")
core.register_alias("dirt", "default:dirt")
core.register_alias("sand", "default:sand")
core.register_alias("gravel", "default:gravel")
core.register_alias("sandstone", "default:sandstone")
core.register_alias("clay", "default:clay")
core.register_alias("brick", "default:brick")
core.register_alias("tree", "default:tree")
core.register_alias("jungletree", "default:jungletree")
core.register_alias("junglegrass", "default:junglegrass")
core.register_alias("leaves", "default:leaves")
core.register_alias("cactus", "default:cactus")
core.register_alias("papyrus", "default:papyrus")
core.register_alias("bookshelf", "default:bookshelf")
core.register_alias("glass", "default:glass")
core.register_alias("wooden_fence", "default:fence_wood")
core.register_alias("rail", "carts:rail")
core.register_alias("ladder", "default:ladder_wood")
core.register_alias("wood", "default:wood")
core.register_alias("mese", "default:mese")
core.register_alias("cloud", "default:cloud")
core.register_alias("water_flowing", "default:water_flowing")
core.register_alias("water_source", "default:water_source")
core.register_alias("lava_flowing", "default:lava_flowing")
core.register_alias("lava_source", "default:lava_source")
core.register_alias("torch", "default:torch")
core.register_alias("sign_wall", "default:sign_wall")
core.register_alias("furnace", "default:furnace")
core.register_alias("chest", "default:chest")
core.register_alias("locked_chest", "default:chest_locked")
core.register_alias("cobble", "default:cobble")
core.register_alias("mossycobble", "default:mossycobble")
core.register_alias("steelblock", "default:steelblock")
core.register_alias("nyancat", "default:nyancat")
core.register_alias("nyancat_rainbow", "default:nyancat_rainbow")
core.register_alias("sapling", "default:sapling")
core.register_alias("apple", "default:apple")

core.register_alias("WPick", "default:pick_wood")
core.register_alias("STPick", "default:pick_stone")
core.register_alias("SteelPick", "default:pick_steel")
core.register_alias("MesePick", "default:pick_mese")
core.register_alias("WShovel", "default:shovel_wood")
core.register_alias("STShovel", "default:shovel_stone")
core.register_alias("SteelShovel", "default:shovel_steel")
core.register_alias("WAxe", "default:axe_wood")
core.register_alias("STAxe", "default:axe_stone")
core.register_alias("SteelAxe", "default:axe_steel")
core.register_alias("WSword", "default:sword_wood")
core.register_alias("STSword", "default:sword_stone")
core.register_alias("SteelSword", "default:sword_steel")

core.register_alias("Stick", "default:stick")
core.register_alias("paper", "default:paper")
core.register_alias("book", "default:book")
core.register_alias("lump_of_coal", "default:coal_lump")
core.register_alias("lump_of_iron", "default:iron_lump")
core.register_alias("lump_of_clay", "default:clay_lump")
core.register_alias("steel_ingot", "default:steel_ingot")
core.register_alias("clay_brick", "default:clay_brick")
core.register_alias("snow", "default:snow")

-- 'mese_block' was used for a while for the block form of mese
core.register_alias("default:mese_block", "default:mese")

-- эти алиасы нам не нужны, т.к. у нас остались из LOTT (lord_trees:pine_tree lord_planks:pine
---- Aliases for corrected pine node names
--core.register_alias("default:pinetree", "default:pine_tree")
--core.register_alias("default:pinewood", "default:pine_wood")

core.register_alias("default:ladder", "default:ladder_wood")
core.register_alias("default:sign_wall_wood", "default:sign_wall")



--- Далее идут наши алиасы

-- also see mods/lord/Blocks/lord_trees/legacy.lua

core.register_alias("scorched_stuff", "default:scorched_stuff")
core.register_alias("rat", "default:dirt")
core.register_alias("cooked_rat", "default:dirt")
core.register_alias("firefly", "lottplants:fireflies")

core.register_alias("moreores:mineral_gold", "default:stone_with_gold")
core.register_alias("moreores:gold_block", "default:goldblock")
core.register_alias("moreores:gold_lump", "default:gold_lump")
core.register_alias("moreores:gold_ingot", "default:gold_ingot")
core.register_alias("moreores:mineral_copper", "default:stone_with_copper")
core.register_alias("moreores:copper_lump", "default:copper_lump")
core.register_alias("moreores:copper_ingot", "default:copper_ingot")
core.register_alias("moreores:copper_block", "default:copperblock")
core.register_alias("moreores:bronze_ingot", "default:bronze_ingot")
core.register_alias("moreores:bronze_block", "default:bronzeblock")

core.register_alias("diamonds:diamond_in_ground", "default:stone_with_diamond")
core.register_alias("diamonds:block", "default:diamondblock")
core.register_alias("diamonds:sword", "default:sword_diamond")
core.register_alias("diamonds:pick", "default:pick_diamond")
core.register_alias("diamonds:shovel", "default:shovel_diamond")
core.register_alias("diamonds:axe", "default:axe_diamond")
core.register_alias("diamonds:diamond", "default:diamond")
core.register_alias("diamonds:ingot", "default:diamond")

core.register_alias("lottspecial:helmet_birthday", "lottarmor:helmet_bronze")
core.register_alias("lottspecial:chestplate_birthday", "lottarmor:chestplate_bronze")
core.register_alias("lottspecial:leggings_birthday", "lottarmor:leggings_bronze")
core.register_alias("lottspecial:boots_birthday", "lottarmor:boots_bronze")
core.register_alias("lottspecial:shield_birthday", "lottarmor:shield_bronze")
core.register_alias("lottspecial:birthday_paxel", "lottores:mithrilpick")
core.register_alias("lottspecial:chest", "default:chest")
core.register_alias("lottspecial:cake_knife", "default:sword_steel")
core.register_alias("lottspecial:cake_slice", "default:apple")
core.register_alias("lottspecial:cake", "default:bread")

core.register_alias("hatches:hatch_alderwood_open", "lord_wooden_stuff:hatch_alder_open")
core.register_alias("hatches:hatch_alderwood", "lord_wooden_stuff:hatch_alder")
core.register_alias("hatches:hatch_birchwood_open", "lord_wooden_stuff:hatch_birch_open")
core.register_alias("hatches:hatch_birchwood", "lord_wooden_stuff:hatch_birch")
core.register_alias("hatches:hatch_lebethronwood_open", "lord_wooden_stuff:hatch_lebethron_open")
core.register_alias("hatches:hatch_lebethronwood", "lord_wooden_stuff:hatch_lebethron")
core.register_alias("hatches:hatch_mallornwood_open", "lord_wooden_stuff:hatch_mallorn_open")
core.register_alias("hatches:hatch_mallornwood", "lord_wooden_stuff:hatch_mallorn")

core.register_alias("lottspecial:jackomelon", "lottfarming:melon")
core.register_alias("lottspecial:jackomelon_lighted", "lottfarming:melon")
core.register_alias("lottspecial:scarecrow", "lottfarming:melon")
core.register_alias("lottspecial:scarecrow_bottom", "lottfarming:melon")
core.register_alias("lottspecial:scarecrow_light", "lottfarming:melon")

-- вернули ванильный `farming:wheat` обратно -- актуальный алиас теперь в
-- mods/lord/_overwrites/MTG/farming/init.lua ("farming:sheaf_wheat" -> "farming:wheat")
--core.register_alias("farming:wheat", "farming:sheaf_wheat")

core.register_alias("lottfarming:barley", "lottfarming:sheaf_barley")
-- если будет ещё замена, то в этой строке тоже стоит поменять на новый вариант:
--core.register_alias("lottfarming:barley_seed", "lottfarming:barley0") -- когда-то меняли на barley0
core.register_alias("lottfarming:barley0", "lottfarming:barley_seed")   -- теперь вернули barley_seed

core.register_alias("lottfarming:corn", "lottfarming:ear_of_corn")
-- если будет ещё замена, то в этой строке тоже стоит поменять на новый вариант:
--core.register_alias("lottfarming:corn_seed", "lottfarming:corn0")  -- когда-то меняли на corn0 (#46, 16425fd)
core.register_alias("lottfarming:corn0", "lottfarming:corn_seed")    -- теперь вернули corn_seed

-- если будет ещё замена, то в этой строке тоже стоит поменять на новый вариант:                              (7f002949)
--core.register_alias("lottfarming:potato_seed", "lottfarming:half_of_potatoe")-- когда-то меняли на half_of_potatoe
core.register_alias("lottfarming:half_of_potatoe", "lottfarming:potato_seed")  -- теперь вернули potato_seed

core.register_alias("lord_homedecor:stair_Adobe", "stairs:stair_adobe")
core.register_alias("lord_homedecor:stair_Roofing", "stairs:stair_roofing")
core.register_alias("lord_homedecor:stair_grate", "stairs:stair_grate")
core.register_alias("lord_homedecor:stair_hardwood", "stairs:stair_hardwood")
core.register_alias("lord_homedecor:slab_Adobe", "stairs:slab_adobe")
core.register_alias("lord_homedecor:slab_Roofing", "stairs:slab_roofing")
core.register_alias("lord_homedecor:slab_grate", "stairs:slab_grate")
core.register_alias("lord_homedecor:slab_hardwood", "stairs:slab_hardwood")

core.register_alias("lottthrowing:bolt_fire", "lord_projectiles:steel_bolt")
core.register_alias("lottpotion:bolt", "lord_projectiles:steel_bolt")

core.register_alias("lottplants:anemones_fake", "lottplants:anemones")
core.register_alias("lottplants:asphodel_fake", "lottplants:asphodel")
core.register_alias("lottplants:eglantive_fake", "lottplants:eglantive")
core.register_alias("lottplants:elanor_fake", "lottplants:elanor")
core.register_alias("lottplants:iris_fake", "lottplants:iris")
core.register_alias("lottplants:lissuin_fake", "lottplants:lissuin")
core.register_alias("lottplants:mallos_fake", "lottplants:mallos")
core.register_alias("lottplants:niphredil_fake", "lottplants:niphredil")
core.register_alias("lottplants:seregon_fake", "lottplants:seregon")
core.register_alias("lottplants:brambles_of_mordor_fake", "lottplants:brambles_of_mordor")
core.register_alias("lottplants:pilinehtar_fake", "lottplants:pilinehtar")

core.register_alias("defaults:sandst0nebrick",     "defaults:default_sandstonebrick")
core.register_alias("defaults:sandst0ne",          "defaults:default_sandstone")
core.register_alias("defaults:desert_st0ne_brick", "defaults:default_desert_stonebrick")
core.register_alias("defaults:st0ne_brick",        "defaults:default_stonebrick")
core.register_alias("defaults:bricks",             "defaults:default_brick")
core.register_alias("defaults:desert_c0bble",      "defaults:default_desert_cobble")
core.register_alias("defaults:c0bble",             "defaults:default_cobble")
core.register_alias("defaults:desert_st0ne",       "defaults:default_desert_stone")
core.register_alias("defaults:st0ne",              "defaults:default_stone")

-- It was failed attempt to add a weather mod. Mod was deleted.
core.register_alias("regional_weather:ice",        "default:water_source")

-- Corpses
for _, gender in pairs({"male", "female"}) do
	for _, race in pairs({"dwarf", "orc", "man", "elf", "hobbit"}) do
		local n = "bones:corpse_"..race.."_"..gender
		core.register_alias(n, n.."_1")
	end
end

gaurds = {"dwarven", "elven", "gondor", "orc", "rohan", "uruk_hai"}
for i, v in pairs(gaurds) do
    core.register_alias("lottnpc:" .. v .. "_guard_spawner", "default:dirt")
    core.register_entity(":lottnpc:" .. v .. "_guard", {
        initial_properties = {
            physical = false,
        },
        on_step = function(self)
            self.object:remove()
        end
    })
end

core.register_entity(":npcf:nametag", {
	initial_properties = {
		physical = false,
	},
	on_step = function(self)
		self.object:remove()
	end
})

core.register_alias("lottarmor:helmet_rohan", "lottarmor:helmet_steel")
core.register_alias("lottarmor:chestplate_rohan", "lottarmor:chestplate_steel")
core.register_alias("lottarmor:boots_rohan", "lottarmor:boots_steel")

-- Tools
for _, tooltype in pairs({"pick", "shovel", "axe", "sword"}) do
	-- ex-default
	for _, material in pairs({"wood", "stone", "steel", "bronze"}) do
		core.register_alias("default:"..tooltype.."_"..material,
			"tools:"..tooltype.."_"..material)
	end
	-- ex-lottores
	for _, material in pairs({"copper", "tin", "silver", "gold", "galvorn", "mithril"}) do
		core.register_alias("lottores:"..material..tooltype,
			"tools:"..tooltype.."_"..material)
	end
end

local materials = {"wood", "stone", "steel", "bronze", "copper", "tin", "silver", "gold", "galvorn", "mithril"}
-- ex-lottweapons
for _, tooltype in pairs({"battleaxe", "warhammer", "spear", "dagger"}) do
	for _, material in pairs(materials) do
		core.register_alias("lottweapons:"..material.."_"..tooltype,
			"tools:"..tooltype.."_"..material)
	end
end

core.register_alias("lottweapons:elven_sword", "tools:sword_elven")
core.register_alias("lottweapons:orc_sword", "tools:sword_orc")

core.register_alias("lottthrowing:arrow", "lord_projectiles:steel_arrow")
core.register_alias("lottthrowing:arrow_mithril", "lord_projectiles:mithril_arrow")
core.register_alias("lottthrowing:bolt", "lord_projectiles:steel_bolt")
core.register_alias("lottthrowing:bolt_mithril", "lord_projectiles:mithril_bolt")

core.register_alias("arrows:arrow_steel", "lord_projectiles:steel_arrow")
core.register_alias("arrows:arrow_mithril", "lord_projectiles:mithril_arrow")
core.register_alias("arrows:bolt_steel", "lord_projectiles:steel_bolt")
core.register_alias("arrows:bolt_mithril", "lord_projectiles:mithril_bolt")

core.register_alias("lottthrowing:axe_dwarf", "lord_projectiles:mithril_bolt")
core.register_alias("lottthrowing:axe_elf", "lord_projectiles:galvorn_bolt")
core.register_alias("lottthrowing:axe_steel", "lord_projectiles:steel_bolt")
core.register_alias("lottthrowing:axe_galvorn", "lord_projectiles:galvorn_bolt")

core.register_alias("arrows:axe_dwarf", "lord_projectiles:mithril_bolt")
core.register_alias("arrows:axe_elf", "lord_projectiles:galvorn_bolt")
core.register_alias("arrows:axe_steel", "lord_projectiles:steel_bolt")
core.register_alias("arrows:axe_galvorn", "lord_projectiles:galvorn_bolt")

core.register_alias("lottthrowing:bow_wood", "lord_archery:apple_wood_bow")
core.register_alias("lottthrowing:bow_wood_alder", "lord_archery:alder_wood_bow")
core.register_alias("lottthrowing:bow_wood_birch", "lord_archery:birch_wood_bow")
core.register_alias("lottthrowing:bow_wood_lebethron", "lord_archery:lebethron_wood_bow")
core.register_alias("lottthrowing:bow_wood_mallorn", "lord_archery:mallorn_wood_bow")

core.register_alias("lottthrowing:crossbow_galvorn", "lord_archery:galvorn_crossbow")
core.register_alias("lottthrowing:crossbow_gold", "lord_archery:gold_crossbow")
core.register_alias("lottthrowing:crossbow_magical", "lord_archery:mithril_crossbow")
core.register_alias("lottthrowing:crossbow_mithril", "lord_archery:mithril_crossbow")
core.register_alias("lottthrowing:crossbow_silver", "lord_archery:silver_crossbow")
core.register_alias("lottthrowing:crossbow_steel", "lord_archery:steel_crossbow")
core.register_alias("lottthrowing:crossbow_tin", "lord_archery:tin_crossbow")
core.register_alias("lottthrowing:crossbow_wood", "lord_archery:wooden_crossbow")

core.register_alias("arrows:fireball", "lord_projectiles:fire_ball")
core.register_alias("arrows:darkball", "lord_projectiles:dark_ball")


core.register_alias("fire:campfire", "campfire:campfire")
core.register_alias("fire:fireplace", "campfire:fireplace")
core.register_alias("fire:campfire_active", "campfire:campfire_active")
core.register_alias("fire:ash", "campfire:ash")

core.register_alias("carts:accelerating_rail", "carts:powerrail")
core.register_alias("carts:stopping_rail", "carts:brakerail")

core.register_alias("lottinventory:small", "bags:small")
core.register_alias("lottinventory:medium", "bags:medium")
core.register_alias("lottinventory:large", "bags:large")

core.register_alias("lottinventory:crafts_book", "lord_books:crafts_book")
core.register_alias("lottinventory:brewing_book", "lord_books:brewing_book")
core.register_alias("lottinventory:cooking_book", "lord_books:cooking_book")
core.register_alias("lottinventory:forbidden_crafts_book", "lord_books:forbidden_crafts_book")
core.register_alias("lottinventory:master_book", "lord_books:master_book")
core.register_alias("lottinventory:potions_book", "lord_books:potions_book")
core.register_alias("lottinventory:protection_book", "lord_books:protection_book")

core.register_alias("lottother:tapestry_top", "castle:tapestry_top")

-- вынесено из MTG/default/legacy.lua (требуется для hopper):
default.gui_bg     = ""
default.gui_bg_img = ""
default.gui_slots  = ""
