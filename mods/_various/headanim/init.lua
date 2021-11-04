local get_connected_players = minetest.get_connected_players
local abs = math.abs
local deg = math.deg
local basepos = vector.new(0, 6.35, 0)
local lastdir = {}

minetest.register_globalstep(function(dtime)
	for _, player in pairs(get_connected_players()) do
		local pname = player:get_player_name()
		local ldeg = -deg(player:get_look_vertical())

		if abs((lastdir[pname] or 0) - ldeg) > 4 then
			lastdir[pname] = ldeg
			player:set_bone_position("Head", basepos, {x = ldeg, y = 0, z = 0})
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	lastdir[player:get_player_name()] = nil
end)
