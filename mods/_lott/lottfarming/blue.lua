local S = lottfarming.get_translator

farming.register_plant("lottfarming:blue_mushroom", {
	seed_name = "lottfarming:spore_blue_mushroom",
	harvest_name = "lottfarming:blue_mushroom",
	description = S("Blue Mushroom Spore"),
	harvest_description = S("Blue Mushroom"),
	harvest_inv_img = "lottfarming_blue_mushroom.png",
	seed_inv_img = "lottfarming_blue_mushroom_spore.png",
	groups = {mushroom = 1, flower = 1, color_blue = 1},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
	minlight = 1,
	maxlight = 8,
	fertility = {"fungi"},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:mushroom_soup", {
	description = S("Cream of Mushroom Soup"),
	inventory_image = "lottfarming_mushroom_soup.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	output = 'lottfarming:mushroom_soup',
	recipe = {
		{'group:mushroom', 'group:mushroom', 'group:mushroom'},
		{'', 'lottfarming:bowl', ''},
	}
})
