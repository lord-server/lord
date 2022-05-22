local S = lottfarming.get_translator

farming.register_plant("lottfarming:green_mushroom", {
	seed_name = "lottfarming:spore_green_mushroom",
	harvest_name = "lottfarming:green_mushroom",
	description = S("Green Mushroom Spore"),
	harvest_description = S("Green Mushroom"),
	harvest_inv_img = "lottfarming_green_mushroom.png",
	seed_inv_img = "lottfarming_green_mushroom_spore.png",
	groups = {mushroom = 1, flower = 1, color_green = 1},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
	minlight = 1,
	maxlight = 8,
	fertility = {"fungi"},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})
