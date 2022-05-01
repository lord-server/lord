dofile(minetest.get_modpath("player").."/arena_health.lua")

-- Localize for better performance.
local player_set_animation = player_api.set_animation
local player_attached = player_api.player_attached

minetest.register_globalstep(function()
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local model = "lottarmor_character.b3d"
		if model and not player_attached[name] then
			local controls = player:get_player_control()
			local animation_speed_mod = model.animation_speed or 30

			local is_sneak = ""

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 2
				is_sneak = "sneak_"
			end

			-- Apply animations based on what the player is doing
			if player:get_hp() == 0 then
				player_set_animation(player, "lay")
			-- Determine if the player is walking
			elseif controls.up or controls.down or controls.left or controls.right then
				if controls.LMB or controls.RMB then
					player_set_animation(player, "walk_mine", animation_speed_mod)
				else
					player_set_animation(player, is_sneak.."walk", animation_speed_mod)
				end
			elseif controls.LMB or controls.RMB then
				player_set_animation(player, "mine", animation_speed_mod)
			else
				player_set_animation(player, is_sneak.."stand", animation_speed_mod)
			end
		end
	end
end)
