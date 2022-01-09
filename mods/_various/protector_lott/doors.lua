local SL = lord.require_intllib()

-- Register Protected Doors

local function on_rightclick(pos, dir, check_name, replace, replace_dir, params)
	pos.y = pos.y+dir
	if not minetest.get_node(pos).name == check_name then
		return
	end
	local p2 = minetest.get_node(pos).param2
	p2 = params[p2 + 1]

	minetest.swap_node(pos, {name = replace_dir, param2 = p2})

	pos.y = pos.y-dir
	minetest.swap_node(pos, {name = replace, param2 = p2})

	local snd_1 = "doors_door_close"
	local snd_2 = "doors_door_open"
	if params[1] == 3 then
		snd_1 = "doors_door_open"
		snd_2 = "doors_door_close"
	end

	if minetest.get_meta(pos):get_int("right") ~= 0 then
		minetest.sound_play(snd_1, {
			pos = pos, gain = 0.3, max_hear_distance = 10})
	else
		minetest.sound_play(snd_2, {
			pos = pos, gain = 0.3, max_hear_distance = 10})
	end
end

local function reg_prot_door(desc, name, door, mat, texture_i, texture_a, texture_b, texture_c)
	local gd
	if mat == "wood" then
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1, wooden = 1}
	elseif mat == "steel" then
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1, steel_item = 1}
	elseif mat == "galvorn" then
		gd = {door = 1, forbidden = 1, cracky = 1, level = 2}
	elseif mat == "tilkal" then
		gd = {door = 1, forbidden = 1}
	else
		gd = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, door = 1, unbreakable = 1}
	end
	doors.register_door(name, {
		description = SL(desc),
		inventory_image = texture_i.."^protector_logo_i.png",
		groups = gd,
		tiles_bottom = {texture_b.."^protector_logo.png", texture_c},
		tiles_top = {texture_a, texture_c},
		sounds = default.node_sound_wood_defaults(),
		sunlight = true,
	})

	minetest.override_item(name .. "_b_1", {
		on_rightclick = function(pos, node, clicker)
			if not minetest.is_protected(pos, clicker:get_player_name()) then
				on_rightclick(pos, 1,
				name .. "_t_1", name .. "_b_2", name .. "_t_2", {1, 2, 3, 0})
			end
		end,
	})

	minetest.override_item(name.."_t_1", {
		on_rightclick = function(pos, node, clicker)
			if not minetest.is_protected(pos, clicker:get_player_name()) then
				on_rightclick(pos, -1,
				name .. "_b_1", name .. "_t_2", name .. "_b_2", {1, 2, 3, 0})
			end
		end,
	})

	minetest.override_item(name.."_b_2", {
		on_rightclick = function(pos, node, clicker)
			if not minetest.is_protected(pos, clicker:get_player_name()) then
				on_rightclick(pos, 1,
				name .. "_t_2", name .. "_b_1", name .. "_t_1", {3, 0, 1, 2})
			end
		end,
	})

	minetest.override_item(name.."_t_2", {
		on_rightclick = function(pos, node, clicker)
			if not minetest.is_protected(pos, clicker:get_player_name()) then
				on_rightclick(pos, -1,
				name .. "_b_2", name .. "_t_1", name .. "_b_1", {3, 0, 1, 2})
			end
		end,
	})

	minetest.register_craft({
		output = name,
		recipe = {
			{door, "protector_lott:protect2"}
		}
	})
end


-- from doors mod

reg_prot_door(
	"Protected Wooden Door", "protector_lott:door_wood", "doors:door_wood", "wood",
	"doors_wood.png",
	"doors_wood_a.png",
	"doors_wood_b.png",
	"doors_brown.png"
)

reg_prot_door(
	"Protected Steel Door", "protector_lott:door_steel", "doors:door_steel", "steel",
	"doors_steel.png", "doors_steel_a.png", "doors_steel_b.png", "doors_grey.png"
)

reg_prot_door(
	"Protected Glass Door", "protector_lott:door_glass", "doors:door_glass", "glass",
	"doors_glass.png",
	"doors_glass_a.png",
	"doors_glass_b.png",
	"doors_glass_side.png"
)

reg_prot_door(
	"Protected Obsidian Glass Door", "protector_lott:door_obsidian_glass", "doors:door_obsidian_glass", "glass",
	"doors_obsidian_glass.png",
	"doors_obsidian_glass_a.png",
	"doors_obsidian_glass_b.png",
	"doors_obsidian_glass_side.png"
)

-- from lottblocks mod

reg_prot_door(
	"Protected Junglewood Door", "protector_lott:door_junglewood", "lottblocks:door_junglewood", "wood",
	"lottblocks_door_junglewood.png",
	"lottblocks_door_junglewood_a.png",
	"lottblocks_door_junglewood_b.png",
	"lottblocks_edge_junglewood.png"
)

reg_prot_door(
	"Protected Alder Door", "protector_lott:door_alder", "lottblocks:door_alder", "wood",
	"lottblocks_door_alder.png",
	"lottblocks_door_alder_a.png",
	"lottblocks_door_alder_b.png",
	"lottblocks_edge_alder.png"
)

reg_prot_door(
	"Protected Birch Door", "protector_lott:door_birch", "lottblocks:door_birch", "wood",
	"lottblocks_door_birch.png",
	"lottblocks_door_birch_a.png",
	"lottblocks_door_birch_b.png",
	"lottblocks_edge_birch.png"
)

reg_prot_door(
	"Protected Pine Door", "protector_lott:door_pine", "lottblocks:door_pine", "wood",
	"lottblocks_door_pine.png", "lottblocks_door_pine_a.png", "lottblocks_door_pine_b.png", "lottblocks_edge_pine.png"
)

reg_prot_door(
	"Protected Lebethron Door", "protector_lott:door_lebethron", "lottblocks:door_lebethron", "wood",
	"lottblocks_door_lebethron.png",
	"lottblocks_door_lebethron_a.png",
	"lottblocks_door_lebethron_b.png",
	"lottblocks_edge_lebethron.png"
)

reg_prot_door(
	"Protected Mallorn Door", "protector_lott:door_mallorn", "lottblocks:door_mallorn", "wood",
	"lottblocks_door_mallorn.png",
	"lottblocks_door_mallorn_a.png",
	"lottblocks_door_mallorn_b.png",
	"lottblocks_edge_mallorn.png"
)

-- from castle mod
reg_prot_door(
	"Protected Oak Door", "protector_lott:oak_door", "castle:oak_door", "wood",
	"castle_oak_door_inv.png",
	"castle_oak_door_top.png",
	"castle_oak_door_bottom.png",
	"door_oak.png"
)

reg_prot_door(
	"Protected Steel Jail Door", "protector_lott:jail_door_steel", "jailbars:jail_door_steel", "steel",
	"castle_jail_door_steel_inv.png",
	"castle_jail_door_steel_top.png",
	"castle_jail_door_steel_bottom.png",
	"door_jail.png"
)

reg_prot_door(
	"Protected Tilkal Jail Door", "protector_lott:jail_door_tilkal", "jailbars:jail_door_tilkal", "tilkal",
	"castle_jail_door_tilkal_inv.png",
	"castle_jail_door_tilkal_top.png",
	"castle_jail_door_tilkal_bottom.png",
	"door_jail.png"
)

reg_prot_door(
	"Protected Galvorn Jail Door", "protector_lott:jail_door_galvorn", "jailbars:jail_door_galvorn", "galvorn",
	"castle_jail_door_galvorn_inv.png",
	"castle_jail_door_galvorn_top.png",
	"castle_jail_door_galvorn_bottom.png",
	"door_jail.png"
)

