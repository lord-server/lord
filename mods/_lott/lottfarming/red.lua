local S = lottfarming.get_translator

farming.register_plant("lottfarming:red_mushroom", {
	seed_name = "lottfarming:spore_red_mushroom",
	harvest_name = "lottfarming:red_mushroom",
	description = S("Red Mushroom Spore"),
	harvest_description = S("Red Mushroom"),
	harvest_inv_img = "lottfarming_red_mushroom.png",
	seed_inv_img = "lottfarming_red_mushroom_spore.png",
	groups = {mushroom = 1, flower = 1, color_red = 1},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
	minlight = 1,
	maxlight = 8,
	fertility = {"fungi"},
	place_param2 = 1,
	on_use = minetest.item_eat(1),
})
