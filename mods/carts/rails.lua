local SL = lord.require_intllib()

minetest.register_alias("carts:accelerating_rail", "carts:powerrail")
minetest.register_alias("carts:stopping_rail", "carts:brakerail")


carts:register_rail("carts:rail", {
	description = SL("Rail"),
	tiles = {
		"carts_rail_straight.png", "carts_rail_curved.png",
		"carts_rail_t_junction.png", "carts_rail_crossing.png"
	},
	inventory_image = "carts_rail_straight.png",
	wield_image = "carts_rail_straight.png",
	groups = carts:get_rail_groups(),
}, {})

carts:register_rail("carts:powerrail", {
	description = SL("Powered rail"),
	tiles = {
		"carts_rail_straight_pwr.png", "carts_rail_curved_pwr.png",
		"carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = 5})

carts:register_rail("carts:brakerail", {
	description = SL("Brake rail"),
	tiles = {
		"carts_rail_straight_brk.png", "carts_rail_curved_brk.png",
		"carts_rail_t_junction_brk.png", "carts_rail_crossing_brk.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = -3})


