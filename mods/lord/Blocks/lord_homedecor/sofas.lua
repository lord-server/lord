local S = core.get_mod_translator()


local sofa_sbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 1.5}
}

local sofa_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 1.5 },
		{-0.5, -0.5, 0.5, -0.4, 0.5, 1.5 }
	}
}

for i in ipairs(lrfurn.colors) do
	local colour = lrfurn.colors[i][1]
	local hue = lrfurn.colors[i][2]

	core.register_node("lord_homedecor:sofa_"..colour, {
		description = S("Sofa ("..colour..")"),
		drawtype = "mesh",
		mesh = "lrfurn_sofa_short.obj",
		tiles = {
			"lrfurn_bg_white.png^[colorize:"..hue.."^lrfurn_sofa_overlay.png",
			"lrfurn_sofa_bottom.png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
		selection_box = sofa_sbox,
		node_box = sofa_cbox,
		on_rotate = screwdriver.disallow,

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if core.is_protected(pos, placer:get_player_name()) then return true end

			local fdir = core.dir_to_facedir(placer:get_look_dir(), false)

			if lrfurn.check_forward(pos, fdir, false, placer) then
				core.set_node(pos, {name = "lord_homedecor:sofa_"..colour, param2 = fdir})
				itemstack:take_item()
			else
				core.chat_send_player(placer:get_player_name(), S("No room to place the sofa!"))
				core.set_node(pos, { name = "air" })

			end
			return itemstack
		end,
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:set_pos(pos)
			clicker:set_hp(20)
		end
	})

	core.register_alias("lord_homedecor:sofa_left_"..colour, "air")
	core.register_alias("lord_homedecor:sofa_right_"..colour, "lord_homedecor:sofa_"..colour)

	core.register_craft({
		output = "lord_homedecor:sofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "", },
			{"stairs:slab_wood", "stairs:slab_wood", "", },
			{"group:stick", "group:stick", "", }
		}
	})

	core.register_craft({
		output = "lord_homedecor:sofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "", },
			{"stairs:slab_lebethronwood", "stairs:slab_lebethronwood", "", },
			{"group:stick", "group:stick", "", }
		}
	})

end
