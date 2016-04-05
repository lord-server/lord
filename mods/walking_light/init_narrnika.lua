local function round(num) 
	return math.floor(num + 0.5) 
end

minetest.register_globalstep(function(dtime)
	for i, player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local wielded_item = player:get_wielded_item():get_name()
		if wielded_item == "default:torch" then 
			local pos = player:getpos()
			local l_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			local node  = minetest.get_node(l_pos).name
			if node == "air" then
				minetest.set_node(l_pos, {name = "walking_light:light"})
			end
		end
	end
end)

minetest.register_abm({
	nodenames = {"walking_light:light"},
	interval = 0.25,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "air"})
	end,
})


minetest.register_node("walking_light:light", {
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	buildable_to = true,
	light_source = 14,
	pointable = false,
	groups = {not_in_creative_inventory=1},
})
