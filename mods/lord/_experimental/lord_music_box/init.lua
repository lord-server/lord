
core.mod(function(mod)
	core.register_node("lord_music_box:music_box", {
		description = "Music box",
		tiles = {'default_stone.png'},
		groups = {not_in_creative_inventory=1},
	})

	core.register_abm({
		nodenames = {"lord_music_box:music_box"},
		interval = 12,
		chance = 1,
		action = function(pos, node)
			core.sound_play("markiza",
				{pos = pos, max_hear_distance = 10, gain = 0.05})
		end,
	})
end)
