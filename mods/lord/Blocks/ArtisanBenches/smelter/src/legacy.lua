--удаляем рецепты с использованием печи
local furnance_recipes = {
	{ 'default:iron_lump', 'default:steel_ingot'},
	{ 'group:iron_item', 'default:iron_ingot'},
	{ 'group:bronze_item', 'default:iron_ingot'},
	{ 'lottores:silver_lump', 'lottores:silver_ingot'},
	{ 'group:silver_item', 'lottores:silver_ingot'},
	{ 'default:gold_lump', 'default:gold_ingot'},
	{ 'group:gold_item', 'default:gold_ingot'},
	{ 'lottores:lead_lump', 'lottores:lead_ingot'},
	{ 'group:lead_item', 'lottores:lead_ingot'},
	{ 'lottores:mithril_lump', 'lottores:mithril_ingot'},
	{ 'group:mithril_item', 'lottores:mithril_ingot'},
	{ 'group:galvorn_item', 'lottores:galvorn_ingot'},
	{ 'lottother:ringsilver_lump', 'lottother:ringsilver_ingot'},
}

for _, row in ipairs(furnance_recipes) do
	minetest.clear_craft({
		type = 'cooking',
		output = row[2],
		recipe = row[1],
	})
end
