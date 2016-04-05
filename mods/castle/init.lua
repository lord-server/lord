local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

dofile(minetest.get_modpath("castle").."/pillars.lua") --колонны
dofile(minetest.get_modpath("castle").."/arrowslit.lua") --бойницы
dofile(minetest.get_modpath("castle").."/tapestry.lua") --гобелены
dofile(minetest.get_modpath("castle").."/jailbars.lua") --решётки
dofile(minetest.get_modpath("castle").."/town_item.lua") --всяко-разно
dofile(minetest.get_modpath("castle").."/murder_hole.lua") --дыры-убийцы
dofile(minetest.get_modpath("castle").."/shields_decor.lua") --декор.щиты
dofile(minetest.get_modpath("castle").."/rope.lua") --блок с троссом

doors.register_door("castle:oak_door", {
	description = SL("Oak Door"),
	inventory_image = "castle_oak_door_inv.png",
	groups = {choppy=2,door=1, wooden = 1},
	tiles_bottom = {"castle_oak_door_bottom.png", "door_oak.png"},
	tiles_top = {"castle_oak_door_top.png", "door_oak.png"},
	sunlight = true,
})

doors.register_door("castle:oak_door_lock", {
	description = SL("Oak Door With Lock"),
	inventory_image = "castle_oak_door_inv.png^doors_lock.png",
	groups = {choppy=2,door=1, wooden = 1},
	tiles_bottom = {"castle_oak_door_bottom_lock.png", "door_oak.png"},
	tiles_top = {"castle_oak_door_top.png", "door_oak.png"},
	only_placer_can_open = true,
	sunlight = true,
})

doors.register_door("castle:jail_door", {
	description = SL("Jail Door"),
	inventory_image = "castle_jail_door_inv.png",
	groups = {cracky=2,door=1, steel_item=1},
	tiles_bottom = {"castle_jail_door_bottom.png", "door_jail.png"},
	tiles_top = {"castle_jail_door_top.png", "door_jail.png"},
	sunlight = true,
})

doors.register_door("castle:jail_door_lock", {
	description = SL("Jail Door With Lock"),
	inventory_image = "castle_jail_door_inv.png^doors_lock.png",
	groups = {cracky=2,door=1, steel_item=1},
	tiles_bottom = {"castle_jail_door_bottom.png", "door_jail.png"},
	tiles_top = {"castle_jail_door_top.png", "door_jail.png"},
	only_placer_can_open = true,
	sunlight = true,
})

minetest.register_craft({
	output = "castle:oak_door",
	recipe = {
		{"default:tree", "default:tree"},
		{"default:tree", "default:tree"},
		{"default:tree", "default:tree"}
	}
})

minetest.register_craft({
	output = "castle:jail_door",
	recipe = {
		{"castle:jailbars", "castle:jailbars"},
		{"castle:jailbars", "castle:jailbars"},
		{"castle:jailbars", "castle:jailbars"}
	}
})

minetest.register_craft({
	output = "castle:oak_door_lock",
	recipe = {
		{"castle:oak_door", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "castle:jail_door_lock",
	recipe = {
		{"castle:jail_door", "default:steel_ingot"}
	}
})

function default.get_ironbound_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:".. spos .. ";main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]"..
		"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
	return formspec
end

local function has_ironbound_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("castle:ironbound_chest",{
	drawtype = "nodebox",
	description = SL("Ironbound Chest"),
	tiles = {"castle_ironbound_chest_top.png",
	                  "castle_ironbound_chest_top.png",
			"castle_ironbound_chest_side.png",
			"castle_ironbound_chest_side.png",
			"castle_ironbound_chest_back.png",
			"castle_ironbound_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2, wooden = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.312500,0.500000,-0.062500,0.312500},
			{-0.500000,-0.062500,-0.250000,0.500000,0.000000,0.250000}, 
			{-0.500000,0.000000,-0.187500,0.500000,0.062500,0.187500},
			{-0.500000,0.062500,-0.062500,0.500000,0.125000,0.062500}, 
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.500000,-0.400000,0.5,0.200000,0.4},

		},		
	},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", SL("Ironbound Chest (owned by").." "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Ironbound Chest"))
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and has_ironbound_chest_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_ironbound_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_ironbound_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_ironbound_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		if has_ironbound_chest_privilege(meta, clicker) then
			minetest.show_formspec(
				clicker:get_player_name(),
				"castle:ironbound_chest",
				default.get_ironbound_chest_formspec(pos)
			)
		end
	end,
})

minetest.register_craft({
	output = "castle:ironbound_chest",
	recipe = {
		{"default:wood", "default:steel_ingot","default:wood"},
		{"default:wood", "default:steel_ingot","default:wood"}
	}
})

minetest.register_tool("castle:battleaxe", {
	description = SL("Battleaxe"),
	inventory_image = "castle_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=20, maxlevel=3},
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	groups = {steel_item = 1},
})
minetest.register_craft({
	output = "castle:battleaxe",
	recipe = {
		{"default:steel_ingot", "default:mese_crystal","default:steel_ingot"},
		{"default:steel_ingot", "default:stick","default:steel_ingot"},
                  {"", "default:stick",""}
	}
})

stairs.register_stair_and_slab("dungeon_stone", "castle:dungeon_stone",
		{cracky=3},
		{"castle_dungeon_stone.png"},
		SL("Dungeon Stone Stair"),
		SL("Dungeon Stone Slab"),
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("pavement", "castle:pavement",
		{cracky=3},
		{"castle_pavement_brick.png"},
		SL("Castle Pavement Stair"),
		SL("Castle Pavement Slab"),
		default.node_sound_stone_defaults())


if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
