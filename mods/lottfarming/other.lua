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
	output = "lottfarming:dough",
	recipe = {{"lottores:salt", "lottfarming:dough"}}
})

