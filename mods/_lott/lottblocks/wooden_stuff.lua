local S = minetest.get_translator("lottblocks")

function lottblocks.register_wooden_stuff(name, description, texture, wood_name)
	local node_groups     = table.copy(minetest.registered_nodes[wood_name].groups)
	node_groups["wood"]   = nil
	node_groups["wooden"] = 1

	local groups_door     = table.copy(node_groups)
	groups_door.door      = 1
	if name ~= "wood" then -- to not overwrite registrations from minetest_game
		local door_reg_name = "lottblocks:door_" .. name
		local door_inv_texture       = "lottblocks_door_" .. name .. ".png"
		local door_uv_texture        = "lottblocks_door_" .. name .. "_uv.png"
		doors.register(door_reg_name, {
			tiles           = {{ name = door_uv_texture, backface_culling = true }},
			description     = S(description .. " Door"),
			inventory_image = door_inv_texture,
			sound_open      = "doors_door_open",
			sound_close     = "doors_door_close",
			groups          = groups_door,
			recipe = {
				{ wood_name, wood_name },
				{ wood_name, wood_name },
				{ wood_name, wood_name },
			},
		})
		doors.register(door_reg_name .. "_lock", {
			tiles           = {{ name = door_uv_texture, backface_culling = true }},
			description     = S(description .. " Door With Lock"),
			inventory_image = door_inv_texture .. "^lord_doors_lock.png",
			sound_open      = "doors_door_open",
			sound_close     = "doors_door_close",
			groups          = groups_door,
			recipe          = {
				{ door_reg_name, "default:steel_ingot", }
			},
			protected       = true,
		})

		local hatch_reg_name = "lottblocks:hatch_" .. name
		local hatch_inv_texture = "lottblocks_hatch_" .. name .. ".png"
		node_groups.not_in_creative_inventory = 0
		doors.register_trapdoor(hatch_reg_name, {
			description     = S(description .. " Trapdoor"),
			inventory_image = hatch_inv_texture,
			wield_image     = hatch_inv_texture,
			tile_front      = hatch_inv_texture,
			tile_side       = "doors_trapdoor_side.png",
			groups          = node_groups,
		})
		minetest.register_craft({
			output = hatch_reg_name,
			recipe = {
				{ wood_name, wood_name },
				{ wood_name, wood_name },
			}
		})

		if name ~= "junglewood" then
			default.register_fence("lottblocks:fence_" .. name, {
				description = S(description .. " Fence"),
				texture = "lottblocks_fence_"..name.."_wood.png",
				inventory_image = "default_fence_overlay.png^lottplants_"..name.."wood.png^" ..
							"default_fence_overlay.png^[makealpha:255,126,126",
				wield_image = "default_fence_overlay.png^lottplants_"..name.."wood.png^" ..
							"default_fence_overlay.png^[makealpha:255,126,126",
				material = wood_name,
				groups = node_groups,
				sounds = default.node_sound_wood_defaults()
			})
			default.register_fence_rail("lottblocks:fence_rail_" .. name, {
				description = S(description .. " Fence Rail"),
				texture = "lottplants_"..name.."wood.png",
				inventory_image = "default_fence_rail_overlay.png^lottplants_"..name.."wood.png^" ..
							"default_fence_rail_overlay.png^[makealpha:255,126,126",
				wield_image = "default_fence_rail_overlay.png^lottplants_"..name.."wood.png^" ..
							"default_fence_rail_overlay.png^[makealpha:255,126,126",
				material = wood_name,
				groups = node_groups,
				sounds = default.node_sound_wood_defaults()
			})
		end

		-- STICK | ПАЛОЧКА
		local stick_reg_name = "lottblocks:stick_" .. name
		minetest.register_craftitem(stick_reg_name, {
			description     = S(description .. " Stick"),
			inventory_image = "lottblocks_" .. name .. "_stick.png",
			groups          = { stick = 1 },
		})
		minetest.register_craft({
			output = stick_reg_name .. " 4",
			recipe = {
				{ wood_name },
			}
		})

		-- LADDER | ЛЕСТНИЦА
		local ladder_reg_name = "lottblocks:ladder_" .. name
		local ladder_tile_texture = "lottblocks_" .. name .. "_planks.png"
		local ladder_inv_texture = "lottblocks_" .. name .. "_ladder.png"
		minetest.register_node(ladder_reg_name, {
			description               = S(description .. " Ladder"),
			drawtype                  = "nodebox",
			tiles                     = { ladder_tile_texture },
			particle_image            = { ladder_tile_texture },
			inventory_image           = ladder_inv_texture,
			wield_image               = ladder_inv_texture,
			paramtype                 = "light",
			paramtype2                = "facedir",
			walkable                  = true,
			climbable                 = true,
			is_ground_content         = false,
			node_box                  = {
				type  = "fixed",
				fixed = {
					{ -0.5, -0.5, 0.5 - 1 / 7, -0.5 + 1 / 7, 0.5, 0.5 },
					{ 0.5 - 1 / 7, -0.5, 0.5 - 1 / 7, 0.5, 0.5, 0.5 },
					{ -0.5 + 1 / 7, 0.5 - 1 / 6 - 1 / 12, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12, 0.5 },
					{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 3, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 2, 0.5 },
					{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 5, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 4, 0.5 },
				},
			},
			selection_box             = {
				type  = "fixed",
				fixed = {
					{ -0.5, -0.5, 0.5 - 1 / 7, -0.5 + 1 / 7, 0.5, 0.5 },
					{ 0.5 - 1 / 7, -0.5, 0.5 - 1 / 7, 0.5, 0.5, 0.5 },
					{ -0.5 + 1 / 7, 0.5 - 1 / 6 - 1 / 12, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12, 0.5 },
					{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 3, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 2, 0.5 },
					{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 5, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 4, 0.5 },
				},
			},
			on_place                  = function(itemstack, placer, pointed_thing)
				if pointed_thing.type == "node" and
					minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].buildable_to == true then
					local under      = pointed_thing.under
					local node_under = minetest.get_node(under)
					local param2     = nil
					local above      = pointed_thing.above
					local above_2    = { x = above.x, y = above.y, z = above.z }
					above_2.y        = above_2.y + 1

					if minetest.registered_nodes[node_under.name].on_rightclick then
						return minetest.registered_nodes[node_under.name].on_rightclick(under, node_under, placer, itemstack)
					end

					if minetest.is_protected(above, placer:get_player_name()) or
						minetest.is_protected(above_2, placer:get_player_name()) then
						minetest.record_protection_violation(above, placer:get_player_name())
						return itemstack
					end

					if pointed_thing.above.x < pointed_thing.under.x then
						param2 = 1
					elseif pointed_thing.above.x > pointed_thing.under.x then
						param2 = 3
					elseif pointed_thing.above.z < pointed_thing.under.z then
						param2 = 0
					elseif pointed_thing.above.z > pointed_thing.under.z then
						param2 = 2
					end

					if param2 then
						minetest.set_node(pointed_thing.above, { name = "lottblocks:ladder_" .. name, param2 = param2 })
						if not default.creative then
							itemstack:take_item()
						end
					end
					return itemstack
				end
			end,
			node_placement_prediction = "",
			groups                    = { choppy = 2, oddly_breakable_by_hand = 3, flammable = 2, wooden = 1 },
			legacy_wallmounted        = true,
			sounds                    = default.node_sound_wood_defaults(),
		})
		minetest.register_craft({
			output = ladder_reg_name .. " 7",
			recipe = {
				{ stick_reg_name, "",             stick_reg_name },
				{ stick_reg_name, stick_reg_name, stick_reg_name },
				{ stick_reg_name, "",             stick_reg_name },
			}
		})

		-- STANCHION | СТОЙКИ
		local stanchion_reg_name = "lottblocks:" .. name .. "_stanchion"
		minetest.register_node(stanchion_reg_name, {
			description         = S(description .. " Stanchion"),
			tiles               = { texture },
			drawtype            = "nodebox",
			sunlight_propagates = true,
			paramtype           = 'light',
			paramtype2          = "facedir",
			node_box            = {
				type  = "fixed",
				fixed = {
					{ -0.5,	-0.5,	-0.5,	-0.4,	0.5,	-0.4 },
					{  0.4,	-0.5,	-0.5,	 0.5,	0.5,	-0.4 },
					{ -0.5,	-0.5,	 0.4,	-0.4,	0.5,	 0.5 },
					{  0.4,	-0.5,	 0.4,	 0.5,	0.5,	 0.5 },
				},
			},
			groups              = node_groups
		})
		minetest.register_craft({
			output = stanchion_reg_name,
			recipe = {
				{ stick_reg_name, '', stick_reg_name },
				{ '',             '', ''             },
				{ stick_reg_name, '', stick_reg_name },
			}
		})
	end

	-- TABLE | СТОЛ
	local table_reg_name = "lottblocks:" .. name .. "_table"
	minetest.register_node(table_reg_name, {
		description         = S(description .. " Table"),
		tiles               = { texture },
		drawtype            = "nodebox",
		sunlight_propagates = true,
		paramtype           = 'light',
		paramtype2          = "facedir",
		node_box            = {
			type  = "fixed",
			fixed = {
				{ -0.4, -0.5, -0.4, -0.3, 0.4, -0.3 },
				{ 0.3, -0.5, -0.4, 0.4, 0.4, -0.3 },
				{ -0.4, -0.5, 0.3, -0.3, 0.4, 0.4 },
				{ 0.3, -0.5, 0.3, 0.4, 0.4, 0.4 },
				{ -0.5, 0.4, -0.5, 0.5, 0.5, 0.5 },
				{ -0.4, -0.2, -0.3, -0.3, -0.1, 0.3 },
				{ 0.3, -0.2, -0.4, 0.4, -0.1, 0.3 },
				{ -0.3, -0.2, -0.4, 0.4, -0.1, -0.3 },
				{ -0.3, -0.2, 0.3, 0.3, -0.1, 0.4 },
			},
		},
		groups              = node_groups
	})
	minetest.register_craft({
		output = table_reg_name,
		recipe = {
			{ wood_name,     wood_name,     wood_name     },
			{ 'group:stick', 'group:stick', 'group:stick' },
			{ 'group:stick', '',            'group:stick' },
		}
	})

	-- CHAIR | КРЕСЛА
	local chair_reg_name = "lottblocks:" .. name .. "_chair"
	minetest.register_node(chair_reg_name, {
		description         = S(description .. " Chair"),
		tiles               = { texture },
		drawtype            = "nodebox",
		sunlight_propagates = true,
		paramtype           = 'light',
		paramtype2          = "facedir",
		node_box            = {
			type  = "fixed",
			fixed = {
				{ -0.3, -0.5, 0.2, -0.2, 0.5, 0.3 },
				{ 0.2, -0.5, 0.2, 0.3, 0.5, 0.3 },
				{ -0.3, -0.5, -0.3, -0.2, -0.1, -0.2 },
				{ 0.2, -0.5, -0.3, 0.3, -0.1, -0.2 },
				{ -0.3, -0.1, -0.3, 0.3, 0, 0.2 },
				{ -0.2, 0.1, 0.25, 0.2, 0.4, 0.26 }
			},
		},
		selection_box       = {
			type  = "fixed",
			fixed = { -0.3, -0.5, -0.3, 0.3, 0.5, 0.3 },
		},
		groups              = node_groups
	})
	minetest.register_craft({
		output = chair_reg_name,
		recipe = {
			{ 'group:stick', ''            },
			{ wood_name,     wood_name     },
			{ 'group:stick', 'group:stick' },
		}
	})
	minetest.register_craft({
		output = chair_reg_name,
		recipe = {
			{ '',            'group:stick' },
			{ wood_name,     wood_name },
			{ 'group:stick', 'group:stick' },
		}
	})
end

lottblocks.register_wooden_stuff("wood", "Wooden", "default_wood.png", "default:wood")
lottblocks.register_wooden_stuff("junglewood", "Junglewood", "default_junglewood.png", "default:junglewood")
lottblocks.register_wooden_stuff("alder", "Alder", "lottplants_alderwood.png", "lottplants:alderwood")
lottblocks.register_wooden_stuff("birch", "Birch", "lottplants_birchwood.png", "lottplants:birchwood")
lottblocks.register_wooden_stuff("pine", "Pine", "lottplants_pinewood.png", "lottplants:pinewood")
lottblocks.register_wooden_stuff("lebethron", "Lebethron", "lottplants_lebethronwood.png", "lottplants:lebethronwood")
lottblocks.register_wooden_stuff("mallorn", "Mallorn", "lottplants_mallornwood.png", "lottplants:mallornwood")

minetest.register_alias("lottblocks:fence_junglewood", "default:fence_junglewood")


--***********************************************************
--**          WOODEN STANCHION | СТОЙКИ ИЗ ЯБЛОНИ          **
--***********************************************************
minetest.register_node("lottblocks:wooden_stanchion", {
	description         = S("Wooden Stanchion"),
	tiles               = { "default_wood.png" },
	drawtype            = "nodebox",
	sunlight_propagates = true,
	paramtype           = 'light',
	paramtype2          = "facedir",
	node_box            = {
		type  = "fixed",
		fixed = {
			{ -0.5,	-0.5,	-0.5,	-0.4,	0.5,	-0.4 },
			{  0.4,	-0.5,	-0.5,	 0.5,	0.5,	-0.4 },
			{ -0.5,	-0.5,	 0.4,	-0.4,	0.5,	 0.5 },
			{  0.4,	-0.5,	 0.4,	 0.5,	0.5,	 0.5 },
		},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1}
})
minetest.register_craft({
	output = "lottblocks:wooden_stanchion",
	recipe = {
		{ 'default:stick', '', 'default:stick' },
		{ '', '', '' },
		{ 'default:stick', '', 'default:stick' },
	}
})
