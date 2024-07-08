-- TODO: #1525 ability to get cave_rocks from API.
local cave_rocks = {
	"default:stone",
	"lord_rocks:diorite",
	"lord_rocks:granite",
	"lord_rocks:basalt",
	"lord_rocks:andesite",
	"lord_rocks:peridotite",
	"lord_rocks:grey_tuff",
	"lord_rocks:red_tuff",
	"lord_rocks:grey_quartzite",
	"lord_rocks:pink_quartzite",
	"lord_rocks:shale",
	"lord_rocks:pyroxenite",
}

---------------------------   S U R F A C E   ---------------------------
--dwarfs.lua
mobs:spawn_specific("lottmobs:dwarf",  {"lord_ground:dirt_iron_hills"}, {"air"}, -1, 20, 30, 9000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf1", {"lord_ground:dirt_iron_hills"}, {"air"}, -1, 20, 30, 9000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf2", {"lord_ground:dirt_iron_hills"}, {"air"}, -1, 20, 30, 9000, 2, -31000, 31000)
--elves.lua
mobs:spawn_specific("lottmobs:elf_archer", {"lord_ground:dirt_lorien"}, {"air"}, 0, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:elf",        {"lord_ground:dirt_lorien"}, {"air"}, 0, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:elf1",       {"lord_ground:dirt_lorien"}, {"air"}, 0, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:elf2",       {"lord_ground:dirt_lorien"}, {"air"}, 0, 20, 30, 9000, 2, 0, 31000)
--boar.lua
mobs:spawn_specific("lottmobs:boar", {"lord_ground:dirt_iron_hills"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
--horse.lua
mobs:spawn_specific("lottmobs:horse",          {"lord_ground:dirt_rohan"}, {"air"}, -1, 20, 30, 9000,  2, 0, 31000)
mobs:spawn_specific("lottmobs:horsepeg",       {"lord_ground:dirt_rohan"}, {"air"}, -1, 20, 30, 10000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:horseara",       {"lord_ground:dirt_rohan"}, {"air"}, -1, 20, 30, 10000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:shirepony",      {"lord_ground:dirt_shire"}, {"air"}, -1, 20, 30, 9000,  2, 0, 31000)
mobs:spawn_specific("lottmobs:shireponyblack", {"lord_ground:dirt_shire"}, {"air"}, -1, 20, 30, 13500, 2, 0, 31000)
--animals
mobs:spawn_specific("lottmobs:chicken", {"lord_ground:dirt_gondor"},  {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:chicken", {"lord_ground:dirt_dunland"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:chicken", {"lord_ground:dirt_rohan"},   {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:chicken", {"lord_ground:dirt_shire"},   {"air"}, -1, 20, 30, 7500, 2, 0, 31000)

mobs:spawn_specific("lottmobs:rat", {"lord_ground:dirt_gondor"},  {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:rat", {"lord_ground:dirt_dunland"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:rat", {"lord_ground:dirt_rohan"},   {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:rat", {"lord_ground:dirt_shire"},   {"air"}, -1, 20, 30, 7500, 2, 0, 31000)

mobs:spawn_specific("lottmobs:kitten", {"lord_ground:dirt_gondor"},  {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:kitten", {"lord_ground:dirt_dunland"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:kitten", {"lord_ground:dirt_rohan"},   {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:kitten", {"lord_ground:dirt_shire"},   {"air"}, -1, 20, 30, 7500, 2, 0, 31000)

--mobs:spawn_specific("lottmobs:sheep", {"lord_ground:dirt_gondor"},   {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
--mobs:spawn_specific("lottmobs:sheep", {"lord_ground:dirt_dunland"},  {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
--mobs:spawn_specific("lottmobs:sheep", {"lord_ground:dirt_ithilien"}, {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
--mobs:spawn_specific("lottmobs:sheep", {"lord_ground:dirt_shire"},    {"air"}, -1, 20, 10, 10000, 1, 0, 31000)

mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_gondor"},   {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_dunland"},  {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_ithilien"}, {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_shire"},    {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_iron_hills"}, {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_fangorn"},  {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_rohan"},    {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"lord_ground:dirt_lorien"},   {"air"}, -1, 20, 10, 10000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:bunny", {"default:dirt_with_snow"},    {"air"}, -1, 20, 10, 10000, 1, 0, 31000)

mobs:spawn_specific("lottmobs:ent", {"lord_ground:dirt_fangorn"},     {"air"}, -1, 20, 300, 9000, 1, 0, 31000)
mobs:spawn_specific("lottmobs:spider", {"lord_ground:dirt_mirkwood"}, {"air"}, -10, 20, 30, 9000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:rohan_guard",     {"lord_ground:dirt_rohan"},    {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:gondor_guard",    {"lord_ground:dirt_gondor"},   {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:ithilien_ranger", {"lord_ground:dirt_ithilien"}, {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:dunlending",      {"lord_ground:dirt_dunland"},  {"air"}, -1, 20, 30, 9000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:hobbit",          {"lord_ground:dirt_shire"},    {"air"}, -1, 20, 30, 9000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:orc", {"lord_rocks:mordor_stone"}, {"air"}, -1, 20, 30, 800,   2, 0, 31000)
mobs:spawn_specific("lottmobs:orc", {"default:snowblock"},       {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc", {"default:dirt_with_snow"},  {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc", {"lottmapgen:angsnowblock"}, {"air"}, -1, 20, 30, 9000,  2, 0, 31000)

mobs:spawn_specific("lottmobs:orc_crossbowman", {"lord_rocks:mordor_stone"}, {"air"}, -1, 20, 30, 300,  2, 0, 31000)
mobs:spawn_specific("lottmobs:orc_crossbowman", {"default:snowblock"},       {"air"}, -1, 15, 30, 3000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc_crossbowman", {"default:dirt_with_snow"},  {"air"}, -1, 15, 30, 3000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc_crossbowman", {"lottmapgen:angsnowblock"}, {"air"}, -1, 20, 30, 2000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:orc_archer", {"lord_rocks:mordor_stone"}, {"air"}, -1, 20, 30, 800,   2, 0, 31000)
mobs:spawn_specific("lottmobs:orc_archer", {"default:snowblock"},       {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc_archer", {"default:dirt_with_snow"},  {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:orc_archer", {"lottmapgen:angsnowblock"}, {"air"}, -1, 20, 30, 9000,  2, 0, 31000)

mobs:spawn_specific("lottmobs:raiding_orc", {"lord_ground:dirt_ithilien"}, {"air"}, -1, 2, 30, 6000, 3, 0, 31000)
mobs:spawn_specific("lottmobs:raiding_orc", {"lord_ground:dirt_rohan"},    {"air"}, -1, 2, 30, 6000, 3, 0, 31000)
mobs:spawn_specific("lottmobs:raiding_orc", {"lord_ground:dirt_gondor"},   {"air"}, -1, 2, 30, 6000, 3, 0, 31000)

--warg.lua
mobs:spawn_specific("lottmobs:warg", {"lord_rocks:mordor_stone"}, {"air"}, -1, 20, 30, 7500,  2, 0, 31000)
mobs:spawn_specific("lottmobs:warg", {"default:snowblock"},       {"air"}, -1, 15, 30, 11500, 2, 0, 31000)
mobs:spawn_specific("lottmobs:warg", {"lottmapgen:angsnowblock"}, {"air"}, -1, 20, 30, 7500,  3, 0, 31000)

mobs:spawn_specific("lottmobs:uruk_hai", {"lord_rocks:mordor_stone"},  {"air"}, -1, 15, 30, 3000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:uruk_hai", {"lord_ground:dirt_fangorn"}, {"air"}, -1,  2, 30, 3000, 2, 0, 31000)

mobs:spawn_specific("lottmobs:battle_troll", {"lord_rocks:mordor_stone"}, {"air"}, -1, 10, 30, 15000, 3, 0, 31000)

mobs:spawn_specific("lottmobs:half_troll", {"default:snow"},            {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:half_troll", {"default:snowblock"},       {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:half_troll", {"default:dirt_with_snow"},  {"air"}, -1, 15, 30, 12000, 2, 0, 31000)
mobs:spawn_specific("lottmobs:half_troll", {"lottmapgen:angsnowblock"}, {"air"}, -1, 20, 30, 9000,  3, 0, 31000)

mobs:spawn_specific("lottmobs:troll", {"default:snow"},            {"air"}, -1, 2, 30,  9000, 3, -31000, 31000)
mobs:spawn_specific("lottmobs:troll", {"default:snowblock"},       {"air"}, -1, 2, 30,  9000, 3, -31000, 31000)
mobs:spawn_specific("lottmobs:troll", {"lottmapgen:angsnowblock"}, {"air"}, -1, 2, 30,  9000, 3, -31000, 31000)


---------------------------   C A V E S   ---------------------------

mobs:spawn_specific("lottmobs:dead_men", {"default:mossycobble"}, {"air"}, -1, 7, 15, 2, 5, -31000, -50)

for _, cave_rock in pairs(cave_rocks) do
	mobs:spawn_specific("lottmobs:rat",    {cave_rock}, {"air"}, -1,  8, 30, 6000, 2, -31000, 0)

	mobs:spawn_specific("lottmobs:dwarf",  {cave_rock}, {"air"}, 8, 15, 30, 9000, 2, -31000, -10)
	mobs:spawn_specific("lottmobs:dwarf1", {cave_rock}, {"air"}, 8, 15, 30, 9000, 2, -31000, -10)
	mobs:spawn_specific("lottmobs:dwarf2", {cave_rock}, {"air"}, 8, 15, 30, 9000, 2, -31000, -10)

	mobs:spawn_specific("lottmobs:orc",    {cave_rock}, {"air"}, -1, 6,  30, 4000,  3, -31000, -10)
	mobs:spawn_specific("lottmobs:troll",  {cave_rock}, {"air"}, -1, 5, 30, 12000, 3, -31000,   -10)
	mobs:spawn_specific("lottmobs:spider", {cave_rock}, {"air"}, -1,   4, 30, 12000, 2, -31000, -10)

	mobs:spawn_specific("lottmobs:nazgul",     {cave_rock}, {"air"}, -1, 2, 30, 30000,  2, -31000, -100)
	mobs:spawn_specific("lottmobs:witch_king", {cave_rock}, {"air"}, -1, 2, 30, 60000,  1, -31000, -1000)
	mobs:spawn_specific("lottmobs:balrog",     {cave_rock}, {"air"}, -1, 2, 30, 100000, 1, -31000, -10000)
end
