
local recipes = {
	--Base Potion
	{ "lottfarming:berries 5", "lord_vessels:drinking_glass_water", "lord_alcohol:wine" },
	{ "farming:wheat0 3", "lord_vessels:drinking_glass_water", "lord_alcohol:beer" },
	{ "bees:bottle_honey 6", "lord_vessels:drinking_glass_water", "lord_alcohol:mead", "vessels:glass_bottle 6" },
	{ "default:apple 5", "lord_vessels:drinking_glass_water", "lord_alcohol:cider" },
	{ "lottfarming:barley_seed 6", "lord_vessels:drinking_glass_water", "lord_alcohol:ale" },
}

for _, data in pairs(recipes) do
	lottpotion.register_recipe("brew", {
		input = { data[1], data[2] },
		output = data[3],
		time = data[5],
	})
end
