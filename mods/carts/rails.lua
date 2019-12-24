-- carts/rails.lua

-- support for MT game translation.
local SL = lord.require_intllib()


carts:register_rail("carts:rail", {
	description = SL("Rail"),
	tiles = {
		"carts_rail.png",
		"carts_rail_curved.png",
		"carts_rail_t_junction.png",
		"carts_rail_crossing.png"
	},
	inventory_image = "carts_rail.png",
	wield_image = "carts_rail.png",
	groups = carts:get_rail_groups(),
})

carts:register_rail("carts:stopping_rail", {
	description = SL("Stopping rail"),
	tiles = {
		"carts_rail_brk.png",
		"carts_rail_curved_brk.png",
		"carts_rail_t_junction_brk.png",
		"carts_rail_crossing_brk.png"
	},
	inventory_image = "carts_rail_brk.png",
	wield_image = "carts_rail_brk.png",
	groups = carts:get_rail_groups(),
}, {acceleration = -5})

carts:register_rail("carts:accelerating_rail", {
	description = SL("Accelerating rail"),
	tiles = {
		"carts_rail_acc.png",
		"carts_rail_curved_acc.png",
		"carts_rail_t_junction_acc.png",
		"carts_rail_crossing_acc.png"
	},
	inventory_image = "carts_rail_acc.png",
	wield_image = "carts_rail_acc.png",
	groups = carts:get_rail_groups(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if minetest.is_protected(pos, placer:get_player_name()) then return true end

		local accel_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
		if not cart_func:is_accelerator(accel_pos) then
			minetest.chat_send_player(placer:get_player_name(), "Низзя ставить ускоряющий рельс")
			minetest.set_node(pos, { name = "air" })
		end
		return itemstack
	end,
}, {acceleration = 5})


