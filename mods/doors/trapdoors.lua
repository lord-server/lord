local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

doors.register_trapdoor("doors:trapdoor", {
	description = SL("Trapdoor"),
	inventory_image = "doors_trapdoor.png",
	wield_image = "doors_trapdoor.png",
	tile_front = "doors_trapdoor.png",
	tile_side = "doors_trapdoor_side.png",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1,wooden=1},
	sounds = default.node_sound_wood_defaults(),
	sound_open = "doors_door_open",
	sound_close = "doors_door_close"
})

minetest.register_craft({
	output = 'doors:trapdoor 2',
	recipe = {
		{'default:wood', 'default:wood', ''},
		{'default:wood', 'default:wood', ''},
		{'', '', ''},
	}
})
