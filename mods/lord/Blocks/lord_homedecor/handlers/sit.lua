--- @param pos Position
--- @param node NodeDefinition
--- @param clicker Player
function lord_homedecor.sit(pos, node, clicker)
	-- luacheck: ignore
	do return end -- delete it when the engine is stabler for the player's physics

	local meta = minetest.get_meta(pos)
	local param2 = node.param2
	local name = clicker:get_player_name()

	if name == meta:get_string("is_sit") then
		meta:set_string("is_sit", "")
		pos.y = pos.y-0.5
		clicker:set_pos(pos)
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override({speed = 1, jump = 1, gravity = 1})
		player_api.player_attached[name] = false
		player_api.set_animation(clicker, "stand", 30)
	else
		meta:set_string("is_sit", clicker:get_player_name())
		clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
		clicker:set_physics_override({speed = 0, jump = 0, gravity = 0})
		clicker:set_pos(pos)
		player_api.player_attached[name] = true
		player_api.set_animation(clicker, "sit", 30)
		if param2 == 0 then
			clicker:set_look_yaw(3.15)
		elseif param2 == 1 then
			clicker:set_look_yaw(7.9)
		elseif param2 == 2 then
			clicker:set_look_yaw(6.28)
		elseif param2 == 3 then
			clicker:set_look_yaw(4.75)
		else return end
	end
end
