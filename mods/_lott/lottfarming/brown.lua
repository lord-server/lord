local S = lottfarming.get_translator

farming.register_plant("lottfarming:brown_mushroom", {
	seed_name = "lottfarming:spore_brown_mushroom",
	harvest_name = "lottfarming:brown_mushroom",
	description = S("Brown Mushroom Spore"),
	harvest_description = S("Brown Mushroom"),
	harvest_inv_img = "lottfarming_brown_mushroom.png",
	seed_inv_img = "lottfarming_brown_mushroom_spore.png",
	groups = {mushroom = 1, flower = 1, color_brown = 1},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
	minlight = 1,
	maxlight = 8,
	fertility = {"fungi"},
	place_param2 = 1,
	on_use = minetest.item_eat(1),
})
