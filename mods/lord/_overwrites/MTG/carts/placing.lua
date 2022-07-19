local function is_accelerator(p)
	local nn = minetest.get_node(p).name
	return minetest.get_item_group(nn, "accelerator") ~= 0
end

local function validate_powerrail_place(pos, placer, itemstack, pointed_thing)
	if minetest.is_protected(pos, placer:get_player_name()) then
		return true
	end

	local accel_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
	if not is_accelerator(accel_pos) then
		minetest.chat_send_player(placer:get_player_name(), "Ускоряющий рельс можно ставить только на паровой механизм")
		minetest.set_node(pos, { name = "air" })
	end
	return itemstack
end

minetest.override_item("carts:powerrail", {
	tiles = {
		"carts_rail_straight_pwr.png", "carts_rail_curved_pwr.png",
		"carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"
	},
	after_place_node = validate_powerrail_place,
})

