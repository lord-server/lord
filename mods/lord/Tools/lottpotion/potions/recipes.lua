
local recipes = {
	--Potions
	--Orc Draught
	{ "lottmobs:rotten_meat 5", "lottpotion:glass_bottle_seregon", "lottpotion:orcdraught_power1" },
	{ "lottmobs:rotten_meat 5", "lottpotion:orcdraught_power1", "lottpotion:orcdraught_power2", 180 },
	{ "lottmobs:rotten_meat 5", "lottpotion:orcdraught_power2", "lottpotion:orcdraught_power3", 240 },
	--Spider Poison
	{ "lottmobs:spiderpoison 2", "lottpotion:glass_bottle_seregon", "lottpotion:spiderpoison_power1" },
	{ "lottmobs:spiderpoison 2", "lottpotion:spiderpoison_power1", "lottpotion:spiderpoison_power2", 180 },
	{ "lottmobs:spiderpoison 2", "lottpotion:spiderpoison_power2", "lottpotion:spiderpoison_power3", 240 },
	--Limpe
	{ "lord_trees:yavannamire_leaf 10", "lottpotion:glass_bottle_mese", "lottpotion:limpe_power1" },
	{ "lord_trees:yavannamire_leaf 10", "lottpotion:limpe_power1", "lottpotion:limpe_power2", 180 },
	{ "lord_trees:yavannamire_leaf 10", "lottpotion:limpe_power2", "lottpotion:limpe_power3", 240 },
	--Miruvor
	{ "lord_trees:yavannamire_fruit 2", "lottpotion:glass_bottle_mese", "lottpotion:miruvor_power1" },
	{ "lord_trees:yavannamire_fruit 2", "lottpotion:miruvor_power1", "lottpotion:miruvor_power2", 180 },
	{ "lord_trees:yavannamire_fruit 2", "lottpotion:miruvor_power2", "lottpotion:miruvor_power3", 240 },
	--Athelas Brew
	{ "lottfarming:athelas 3", "lottpotion:glass_bottle_geodes", "lottpotion:athelasbrew_power1" },
	{ "lottfarming:athelas 3", "lottpotion:athelasbrew_power1", "lottpotion:athelasbrew_power2", 180 },
	{ "lottfarming:athelas 3", "lottpotion:athelasbrew_power2", "lottpotion:athelasbrew_power3", 240 },
	--Ent Draught
	{ "default:leaves 10", "lottpotion:glass_bottle_geodes", "lottpotion:entdraught_power1" },
	{ "default:leaves 10", "lottpotion:entdraught_power1", "lottpotion:entdraught_power2", 120 },
	{ "default:leaves 10", "lottpotion:entdraught_power2", "lottpotion:entdraught_power3", 240 },

	--Negative Potions
	--Orc Draught
	{ "lottmobs:rotten_meat 5", "lottpotion:glass_bottle_mordor", "lottpotion:orcdraught_corruption1" },
	{ "lottmobs:rotten_meat 5", "lottpotion:orcdraught_corruption1", "lottpotion:orcdraught_corruption2", 180 },
	{ "lottmobs:rotten_meat 5", "lottpotion:orcdraught_corruption2", "lottpotion:orcdraught_corruption3", 240 },
	--Spider Poison
	{ "lottmobs:spiderpoison 2", "lottpotion:glass_bottle_mordor", "lottpotion:spiderpoison_corruption1" },
	{ "lottmobs:spiderpoison 2", "lottpotion:spiderpoison_corruption1", "lottpotion:spiderpoison_corruption2", 180 },
	{ "lottmobs:spiderpoison 2", "lottpotion:spiderpoison_corruption2", "lottpotion:spiderpoison_corruption3", 240 },
	--Limpe
	{ "lord_trees:yavannamire_leaf 10", "lottpotion:glass_bottle_obsidian", "lottpotion:limpe_corruption1" },
	{ "lord_trees:yavannamire_leaf 10", "lottpotion:limpe_corruption1", "lottpotion:limpe_corruption2", 180 },
	{ "lord_trees:yavannamire_leaf 10", "lottpotion:limpe_corruption2", "lottpotion:limpe_corruption3", 240 },
	--Miruvor
	{ "lord_trees:yavannamire_fruit 2", "lottpotion:glass_bottle_obsidian", "lottpotion:miruvor_corruption1" },
	{ "lord_trees:yavannamire_fruit 2", "lottpotion:miruvor_corruption1", "lottpotion:miruvor_corruption2", 180 },
	{ "lord_trees:yavannamire_fruit 2", "lottpotion:miruvor_corruption2", "lottpotion:miruvor_corruption3", 240 },
	--Athelas Brew
	{ "lottfarming:athelas 3", "lottpotion:glass_bottle_bonedust", "lottpotion:athelasbrew_corruption1" },
	{ "lottfarming:athelas 3", "lottpotion:athelasbrew_corruption1", "lottpotion:athelasbrew_corruption2", 180 },
	{ "lottfarming:athelas 3", "lottpotion:athelasbrew_corruption2", "lottpotion:athelasbrew_corruption3", 240 },
	--Ent Draught
	{ "default:leaves 10", "lottpotion:glass_bottle_bonedust", "lottpotion:entdraught_corruption1" },
	{ "default:leaves 10", "lottpotion:entdraught_corruption1", "lottpotion:entdraught_corruption2", 120 },
	{ "default:leaves 10", "lottpotion:entdraught_corruption2", "lottpotion:entdraught_corruption3", 240 },
}

for _, data in pairs(recipes) do
	minetest.register_craft({
		method = minetest.CraftMethod.POTION,
		type   = 'cooking',
		input  = { { data[1], data[2] } },
		output = data[3],
		time   = data[4] or 60,
	})
end
