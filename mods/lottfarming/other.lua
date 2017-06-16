local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:lembas", {
  description = SL("Lembas"),
  inventory_image = "lottfarming_lembas.png",
  on_use = minetest.item_eat(20),
})
  
minetest.register_craftitem("lottfarming:cookie_cracker", {
  description = SL("Cracker"),
  inventory_image = "lottfarming_cookie_cracker.png",
  on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:salted_dough",
	recipe = {{"lottores:salt", "lottfarming:dough"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:dough",
	recipe = {{"lottpotion:glass_bottle_water", "farming:flour"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:yeast_dough",
	recipe = {{"group:mushrooms", "lottfarming:dough"}}
})

minetest.register_craftitem("lottfarming:dough", {
  description = SL("Dough"),
  inventory_image = "lottfarming_dough.png",
  on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottfarming:yeast_dough", {
  description = SL("Yeast Dough"),
  inventory_image = "lottfarming_ydough.png",
  on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottfarming:salted_dough", {
  description = SL("Salted Dough"),
  inventory_image = "lottfarming_sdough.png",
  on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottfarming:salted_dough", {
  description = SL("Salted Dough"),
  inventory_image = "lottfarming_sdough.png",
  on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:dough_with_egg",
	recipe = {{"lottmobs:chicken_egg", "lottfarming:dough"}}
})

minetest.register_craftitem("lottfarming:dough_with_egg", {
  description = SL("Dough"),
  inventory_image = "lottfarming_eggdough.png",
  on_use = minetest.item_eat(1),
})
