local S = minetest.get_translator("lottblocks")

--- @type string
local DS = os.DIRECTORY_SEPARATOR

--- @param sub_folder string
--- @return string
local function textures_folder(sub_folder)
	return minetest.get_mod_textures_folder("wooden_stuff" .. DS .. sub_folder)
end

--- @param name string
--- @param description_prefix string
--- @param wood_name string
--- @param node_groups table
local function register_doors(name, description_prefix, wood_name, node_groups)
	local door_groups = table.merge(node_groups, { door = 1 })

	local door_reg_name    = "lottblocks:door_" .. name
	local door_inv_texture = "lottblocks_door_" .. name .. ".png"
	local door_uv_texture  = "lottblocks_door_" .. name .. "_uv.png"

	if
		not io.file_exists(textures_folder("doors") .. door_inv_texture) or
		not io.file_exists(textures_folder("doors") .. door_uv_texture)
	then
		return
	end

	local common_definition = {
		tiles           = {{ name = door_uv_texture, backface_culling = true }},
		sound_open      = "doors_door_open",
		sound_close     = "doors_door_close",
		groups          = door_groups,
	}
	doors.register(door_reg_name, table.merge(common_definition, {
		description     = S(description_prefix .. " Door"),
		inventory_image = door_inv_texture,
		recipe = {
			{ wood_name, wood_name },
			{ wood_name, wood_name },
			{ wood_name, wood_name },
		},
	}))
	doors.register(door_reg_name .. "_lock", table.merge(common_definition, {
		description     = S(description_prefix .. " Door With Lock"),
		inventory_image = door_inv_texture .. "^lord_doors_lock.png",
		recipe          = {
			{ door_reg_name, "default:steel_ingot", }
		},
		protected       = true,
	}))
end

--- @param name               string node name postfix (`"lottblocks:hatch_"..name`). Also used for textures names.
--- @param description_prefix string used: `S(description_prefix .. " Trapdoor")`
--- @param wood_name          string technical name of planks node (ex.: `"default:wood"`) for craft.
--- @param node_groups        table  groups to apply to. Group `{ hatch = 1 }` will be added.
--- @param texture            string which texture to use, if `"lottblocks_"..name.."_planks.png"` doesn't exists.
local function register_hatch(name, description_prefix, wood_name, node_groups, texture)
	local hatch_reg_name = "lottblocks:hatch_" .. name
	local front_texture  = "lottblocks_hatch_" .. name .. ".png"
	local side_texture   = "lottblocks_hatch_" .. name .. "_side.png"
	if not io.file_exists(textures_folder("hatches") .. front_texture) then
		front_texture = texture .. "^[transformR90^lottblocks_hatch__overlay.png"
	end
	if not io.file_exists(textures_folder("hatches") .. side_texture) then
		side_texture = texture
	end
	doors.register_trapdoor(hatch_reg_name, {
		description     = S(description_prefix .. " Trapdoor"),
		inventory_image = front_texture,
		wield_image     = front_texture,
		tile_front      = front_texture,
		tile_side       = side_texture,
		groups          = table.merge(node_groups, { hatch = 1 }),
	})
	minetest.register_craft({
		output = hatch_reg_name,
		recipe = {
			{ wood_name, wood_name },
			{ wood_name, wood_name },
		}
	})
end

---@param name_postfix string
---@param desc_prefix string
---@param wood_name string
---@param node_groups table<string,number>
local function register_reinforced_hatch(name_postfix, desc_prefix, wood_name, node_groups)
	local name = "lottblocks:hatch_reinforced_" .. name_postfix
	local texture = "lottblocks_hatch_reinforced_" .. name_postfix .. ".png"
	doors.register_trapdoor(name, {
		description = string.format("Reinforced %s Hatch", desc_prefix),
		inventory_image = texture,
		wield_image = texture,
		tile_front = texture,
		tile_side = texture,
		groups = table.merge(node_groups, { hatch = 1, }),
	})

	minetest.register_craft({
		output = name,
		recipe = {
			{ "", "lottores:tin_ingot", "", },
			{ wood_name, wood_name, wood_name, },
			{ wood_name, wood_name, wood_name, },
		}
	})
end

--- @param name string
--- @param description_prefix string
--- @param wood_name string
--- @param node_groups table
local function register_fence(name, description_prefix, wood_name, node_groups)
	if name == "junglewood" then
		return
	end

	local texture   = "lord_planks_"..name..".png"
	default.register_fence("lottblocks:fence_" .. name, {
		description = S(description_prefix .. " Fence"),
		texture = texture,
		material = wood_name,
		groups = node_groups,
		sounds = default.node_sound_wood_defaults()
	})
	default.register_fence_rail("lottblocks:fence_rail_" .. name, {
		description = S(description_prefix .. " Fence Rail"),
		texture = texture,
		material = wood_name,
		groups = node_groups,
		sounds = default.node_sound_wood_defaults()
	})
end

--- @param name string
--- @param description_prefix string
--- @param wood_name string
local function register_stick(name, description_prefix, wood_name)
	local stick_reg_name = "lottblocks:stick_" .. name
	minetest.register_craftitem(stick_reg_name, {
		description     = S(description_prefix .. " Stick"),
		inventory_image = "lottblocks_" .. name .. "_stick.png",
		groups          = { stick = 1 },
	})
	minetest.register_craft({
		output = stick_reg_name .. " 4",
		recipe = {
			{ wood_name },
		}
	})
	return stick_reg_name
end

--- @param name               string node name postfix (`"lottblocks:ladder_"..name`). Also used for textures names.
--- @param description_prefix string used: `S(description_prefix .. " Ladder")`
--- @param stick_reg_name     string technical name of stick item (ex.: `"default:stick"`) for craft.
--- @param texture            string which texture to use, if `"lottblocks_"..name.."_planks.png"` doesn't exists.
local function register_ladder(name, description_prefix, stick_reg_name, texture)
	local ladder_reg_name = "lottblocks:ladder_" .. name
	local ladder_tile_texture = "lottblocks_" .. name .. "_planks.png"
	local ladder_inv_texture = "lottblocks_" .. name .. "_ladder.png"
	if not io.file_exists(textures_folder("planks") .. ladder_tile_texture) then
		ladder_tile_texture = texture
	end
	if not io.file_exists(textures_folder("ladders") .. ladder_inv_texture) then
		ladder_inv_texture = nil
	end
	minetest.register_node(ladder_reg_name, {
		description               = S(description_prefix .. " Ladder"),
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
					if not minetest.is_creative_enabled(placer) then
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
end

--- @param name string
--- @param description_prefix string
--- @param texture string
--- @param node_groups table
--- @param stick_reg_name string
local function register_stanchion(name, description_prefix, texture, node_groups, stick_reg_name)
	local stanchion_reg_name = "lottblocks:" .. name .. "_stanchion"
	minetest.register_node(stanchion_reg_name, {
		description         = S(description_prefix .. " Stanchion"),
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

--- @param name string
--- @param description_prefix string
--- @param texture string
--- @param wood_name string
--- @param node_groups table
local function register_table(name, description_prefix, texture, wood_name, node_groups)
	local table_reg_name = "lottblocks:" .. name .. "_table"
	minetest.register_node(table_reg_name, {
		description         = S(description_prefix .. " Table"),
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
		groups              = node_groups,
		sounds              = default.node_sound_wood_defaults(),
	})
	minetest.register_craft({
		output = table_reg_name,
		recipe = {
			{ wood_name,     wood_name,     wood_name     },
			{ 'group:stick', 'group:stick', 'group:stick' },
			{ 'group:stick', '',            'group:stick' },
		}
	})
end

--- @param name string
--- @param description_prefix string
--- @param texture string
--- @param wood_name string
--- @param node_groups table
local function register_chair(name, description_prefix, texture, wood_name, node_groups)
	local chair_reg_name = "lottblocks:" .. name .. "_chair"
	minetest.register_node(chair_reg_name, {
		description         = S(description_prefix .. " Chair"),
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
		groups              = node_groups,
		sounds              = default.node_sound_wood_defaults(),
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
			{ wood_name,     wood_name     },
			{ 'group:stick', 'group:stick' },
		}
	})
end

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

---@param name string
---@param description string
---@param texture string
---@param wood_name string
function lottblocks.register_wooden_stuff(name, description, texture, wood_name)
	local node_groups     = table.copy(minetest.registered_nodes[wood_name].groups)
	node_groups["wood"]   = nil
	node_groups["wooden"] = 1

	local stick_reg_name

	if name ~= "wood" then --  in order to not overwrite registrations from minetest_game
		register_doors(name, description, wood_name, node_groups)
		register_hatch(name, description, wood_name, node_groups, texture)
		register_fence(name, description, wood_name, node_groups) -- except junglewood
		stick_reg_name =
		register_stick(name, description, wood_name)
		register_ladder(name, description, stick_reg_name, texture)
	end

	if table.contains({ "wood", "junglewood", "beech", "elm"}, name) then
		register_reinforced_hatch(name, description, wood_name, node_groups)
	end

	register_stanchion(name, description, texture, node_groups, stick_reg_name or "default:stick")
	register_table(name, description, texture, wood_name, node_groups)
	register_chair(name, description, texture, wood_name, node_groups)
end

lottblocks.register_wooden_stuff("wood", "Wooden", "default_wood.png", "default:wood")
lottblocks.register_wooden_stuff("junglewood", "Junglewood", "default_junglewood.png", "default:junglewood")
lottblocks.register_wooden_stuff("alder", "Alder", "lord_planks_alder.png", "lord_planks:alder")
lottblocks.register_wooden_stuff("beech", "Beech", "lord_planks_beech.png", "lord_planks:beech")
lottblocks.register_wooden_stuff("birch", "Birch", "lord_planks_birch.png", "lord_planks:birch")
lottblocks.register_wooden_stuff("cherry", "Cherry", "lord_planks_cherry.png", "lord_planks:cherry")
lottblocks.register_wooden_stuff("culumalda", "Culumalda", "lord_planks_culumalda.png", "lord_planks:culumalda")
lottblocks.register_wooden_stuff("elm", "Elm", "lord_planks_elm.png", "lord_planks:elm")
lottblocks.register_wooden_stuff("fir", "Fir", "lord_planks_fir.png", "lord_planks:fir")
lottblocks.register_wooden_stuff("hardwood", "Hardwood", "lord_planks_hardwood.png", "lord_planks:hardwood")
lottblocks.register_wooden_stuff("lebethron", "Lebethron", "lord_planks_lebethron.png", "lord_planks:lebethron")
lottblocks.register_wooden_stuff("mallorn", "Mallorn", "lord_planks_mallorn.png", "lord_planks:mallorn")
lottblocks.register_wooden_stuff("pine", "Pine", "lord_planks_pine.png", "lord_planks:pine")
lottblocks.register_wooden_stuff("plum", "Plum", "lord_planks_plum.png", "lord_planks:plum")

minetest.register_alias("lottblocks:wooden_stanchion", "lottblocks:wood_stanchion")
minetest.register_alias("lottblocks:fence_junglewood", "default:fence_junglewood")
