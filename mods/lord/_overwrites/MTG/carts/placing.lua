local S = core.get_mod_translator()


local function is_accelerator(p)
	local nn = core.get_node(p).name
	return core.get_item_group(nn, 'accelerator') ~= 0
end

local function validate_powerrail_place(pos, placer, itemstack, pointed_thing)
	if core.is_protected(pos, placer:get_player_name()) then
		return true
	end

	local accel_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
	if not is_accelerator(accel_pos) then
		core.chat_send_player(placer:get_player_name(), S('Powerrail can only be placed on steam mechanism'))
		core.set_node(pos, { name = 'air' })
		return true
	end
end

core.override_item('carts:powerrail', {
	tiles = {
		'carts_rail_straight_pwr.png', 'carts_rail_curved_pwr.png',
		'carts_rail_t_junction_pwr.png', 'carts_rail_crossing_pwr.png'
	},
	after_place_node = validate_powerrail_place,
})

