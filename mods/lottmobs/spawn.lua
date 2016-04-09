--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)

--dwarfs.lua
mobs:spawn_specific("lottmobs:dwarf",	{"default:stone"},		{"air"}, -1, 15, 30, 9000, 2, -31000, -10)
mobs:spawn_specific("lottmobs:dwarf1",	{"default:stone"},		{"air"}, -1, 15, 30, 9000, 2, -31000, -10)
mobs:spawn_specific("lottmobs:dwarf2",	{"default:stone"},		{"air"}, -1, 15, 30, 9000, 2, -31000, -10)
mobs:spawn_specific("lottmobs:dwarf",	{"lottmapgen:ironhill_grass"},	{"air"}, -1, 20, 30, 9000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf1",	{"lottmapgen:ironhill_grass"},	{"air"}, -1, 20, 30, 9000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf2",	{"lottmapgen:ironhill_grass"},	{"air"}, -1, 20, 30, 9000, 2, -31000, 31000)

--elves.lua
mobs:spawn_specific("lottmobs:elf",	{"lottmapgen:lorien_grass"},	{"air"}, 0, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:elf1",	{"lottmapgen:lorien_grass"},	{"air"}, 0, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:elf2",	{"lottmapgen:lorien_grass"},	{"air"}, 0, 20, 30, 9000, 2, 0, 31000)


--horse.lua
mobs:spawn_specific("lottmobs:horse",		{"lottmapgen:rohan_grass"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:horsepeg",	{"lottmapgen:rohan_grass"}, {"air"}, -1, 20, 30, 10000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:horseara",	{"lottmapgen:rohan_grass"}, {"air"}, -1, 20, 30, 10000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:shirepony",	{"lottmapgen:shire_grass"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:shireponyblack",	{"lottmapgen:shire_grass"}, {"air"}, -1, 20, 30, 13500, 2, 0, 31000)

--init.lua
mobs:spawn_specific("lottmobs:chicken",	{"lottmapgen:gondor_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:chicken",	{"lottmapgen:dunland_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:chicken",	{"lottmapgen:rohan_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:chicken",	{"lottmapgen:shire_grass"},	{"air"}, -1, 20, 30, 7500, 2, 0, 31000)

mobs:spawn_specific("lottmobs:ent",	{"lottmapgen:fangorn_grass"},	{"air"}, -1, 20, 300, 9000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:spider",	{"lottmapgen:mirkwood_grass"},	{"air"}, -10, 20, 30, 9000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:rohan_guard",	{"lottmapgen:rohan_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:gondor_guard",	{"lottmapgen:gondor_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:ithilien_ranger",	{"lottmapgen:ithilien_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:dunlending",	{"lottmapgen:dunland_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:hobbit",		{"lottmapgen:shire_grass"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:orc",	{"lottmapgen:mordor_stone"},	{"air"}, -1, 20, 30, 800, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc",	{"default:snowblock"},		{"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc",	{"default:dirt_with_snow"},	{"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc",	{"lottmapgen:angsnowblock"},	{"air"}, -1, 20, 30, 9000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:raiding_orc",	{"lottmapgen:ithilien_grass"},	{"air"}, -1, 2, 30, 6000, 3, 0, 31000)
mobs:spawn_specific("lottmobs:raiding_orc",	{"lottmapgen:rohan_grass"},	{"air"}, -1, 2, 30, 6000, 3, 0, 31000)
mobs:spawn_specific("lottmobs:raiding_orc",	{"lottmapgen:gondor_grass"},	{"air"}, -1, 2, 30, 6000, 3, 0, 31000)

mobs:spawn_specific("lottmobs:warg",	{"lottmapgen:mordor_stone"},	{"air"}, -1, 20, 30, 7500, 2, 0, 31000)
mobs:spawn_specific("lottmobs:warg",	{"default:snowblock"},		{"air"}, -1, 15, 30, 11500, 2, 0, 31000)
mobs:spawn_specific("lottmobs:warg",	{"lottmapgen:angsnowblock"},	{"air"}, -1, 20, 30, 7500, 3, 0, 31000)

mobs:spawn_specific("lottmobs:uruk_hai",	{"lottmapgen:mordor_stone"},	{"air"}, -1, 15, 30, 3000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:uruk_hai",	{"lottmapgen:fangorn_grass"},	{"air"}, -1, 2, 30, 3000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:battle_troll", {"lottmapgen:mordor_stone"},	{"air"}, -1, 10, 30, 15000, 3, 0, 31000)

mobs:spawn_specific("lottmobs:half_troll",	{"default:snow"},		{"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:half_troll",	{"default:snowblock"},		{"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:half_troll",	{"default:dirt_with_snow"},	{"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:half_troll",	{"lottmapgen:angsnowblock"},	{"air"}, -1, 20, 30, 9000, 3, 0, 31000)

mobs:spawn_specific("lottmobs:nazgul",	{"default:stone"},	{"air"}, -1, 2, 30, 30000, 2, -31000, -50)

mobs:spawn_specific("lottmobs:witch_king",	{"default:stone"},	{"air"}, -1, 2, 30, 60000, 1, -31000, -1000)

mobs:spawn_specific("lottmobs:balrog", {"default:stone"}, {"air"}, -1, 2, 30, 100000, 1, -31000, -10000)

mobs:spawn_specific("lottmobs:dead_men", {"default:mossycobble"}, {"air"}, -1, 2, 30, 9000, 7, -31000, -100)

mobs:spawn_specific("lottmobs:troll", {"default:stone"},		{"air"}, -1, 2, 30, 12000, 3, -31000, -10)
mobs:spawn_specific("lottmobs:troll", {"default:snow"},			{"air"}, -1, 2, 30, 9000, 3, -31000, 31000)
mobs:spawn_specific("lottmobs:troll", {"default:snowblock"},		{"air"}, -1, 2, 30, 9000, 3, -31000, 31000)
mobs:spawn_specific("lottmobs:troll", {"lottmapgen:angsnowblock"},	{"air"}, -1, 2, 30, 9000, 3, -31000, 31000)

--special_mobs.lua
mobs:spawn_specific("lottmobs:elf_trader",	{"lottmapgen:lorien_grass"},	{"air"}, 0, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader",	{"lottmapgen:rohan_grass"},	{"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader",	{"lottmapgen:gondor_grass"},	{"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:hobbit_trader",	{"lottmapgen:shire_grass"},	{"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf_trader",	{"lottmapgen:ironhill_grass"},	{"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
