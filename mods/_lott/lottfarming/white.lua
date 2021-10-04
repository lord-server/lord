local S = lottfarming.get_translator

farming.register_plant("lottfarming:white_mushroom", {
	seed_name = "lottfarming:spore_white_mushroom",
	harvest_name = "lottfarming:white_mushroom",
	description = S("White Mushroom Spore"),
	harvest_description = S("White Mushroom"),
	harvest_inv_img = "lottfarming_white_mushroom.png",
	seed_inv_img = "lottfarming_white_mushroom_spore.png",
	groups = {mushroom = 1, flower = 1, color_white = 1},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
	minlight = 1,
	maxlight = 8,
	fertility = {"fungi"},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})
