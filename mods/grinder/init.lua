local SL = lord.require_intllib()

local iEnv = minetest.request_insecure_environment()
if not iEnv then
	error('Please add `' .. minetest.get_current_modname() .. '` to secure.trusted_mods in minetest.conf')
end
local modpath     = minetest.get_modpath(minetest.get_current_modname())
iEnv.package.path = modpath .. "/src/?.lua;" .. iEnv.package.path
local old_require = require
require           = iEnv.require

--- @module grinder
grinder = {}

require('grinder.Recipe')

--- register crafting mechanism ---
minetest.register_craft({
	output = 'grinder:roll',
	recipe = {
		{'default:steel_ingot', 'default:diamond', 'default:steel_ingot'},
		{'carts:gear', 'default:steel_ingot', 'carts:gear'},
		{'default:diamond', 'default:steel_ingot', 'default:diamond'},
	}
})

minetest.register_craft({
	output = 'grinder:grinder',
	recipe = {
		{'grinder:roll', '', 'grinder:roll'},
		{'default:steel_ingot', 'carts:gear', 'default:steel_ingot'},
		{'default:obsidian', 'carts:steam_mechanism', 'default:obsidian'},
	}
})

function grinder.get_grinder_active_formspec(pos, percent, item_percent)
	local formspec =
		"size[8,9]"..
		"image[5.25,1.1;1,1;default_furnace_inv.png^default_furnace_fire_bg.png^[lowpart:"..(100-percent)..":default_furnace_fire_fg.png]"..
		"image[1.5,1.6;1,1;gui_furnace_arrow_bg.png^[lowpart:"..(item_percent)..":gui_furnace_arrow_fg.png^[transformR180]"..
		"list[current_name;fuel;5.25,2.1;1,1;]"..
		"list[current_name;src;1.5,0.5;1,1;]"..
		"list[current_name;dst;1,3.5;2,1;]"..
		"list[current_name;dst;1,2.5;2,1;2]"..
		"list[current_player;main;0,5;8,4;]"..
		"listring[current_name;fuel]"..
		"listring[current_player;main]"..
		"listring[current_name;src]"..
		"listring[current_player;main]"..
		"listring[current_name;dst]"..
		"listring[current_player;main]"..
		"background[-0.5,-0.65;9,10.35;gui_grinderbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
	return formspec
end

grinder.grinder_inactive_formspec =
	"size[8,9]"..
	"image[5.25,1.1;1,1;default_furnace_inv.png^default_furnace_fire_bg.png]"..
	"list[current_name;fuel;5.25,2.1;1,1;]"..
	"list[current_name;src;1.5,0.5;1,1;]"..
	"list[current_name;dst;1,3.5;2,1;]"..
	"list[current_name;dst;1,2.5;2,1;2]"..
	"list[current_player;main;0,5;8,4;]"..
	"listring[current_name;fuel]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
  "background[-0.5,-0.65;9,10.35;gui_grinderbg.png]"..
  "listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

minetest.register_node("grinder:grinder", {
	description = SL("Grinder"),
	tiles = {"grinder_top.png", "carts_steam_mechanismn.png",
					"grinder_side_left.png",	"grinder_side_right.png",
					"grinder_side.png", "grinder_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", grinder.grinder_inactive_formspec)
		meta:set_string("infotext", SL("Grinder"))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if listname == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext", SL("Grinder is empty"))
				end
				return stack:get_count()
			else
				return 0
			end
		elseif listname == "src" then
			return stack:get_count()
		elseif listname == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if to_list == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext", SL("Grinder is empty"))
				end
				return count
			else
				return 0
			end
		elseif to_list == "src" then
			return count
		elseif to_list == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,

  	-- backwards compatibility: punch to set formspec
  	on_punch = function(pos,player)
  	    local meta = minetest.get_meta(pos)
        meta:set_string("infotext", SL("Grinder"))
        meta:set_string("formspec",grinder.grinder_inactive_formspec)
    end
})

minetest.register_node("grinder:grinder_active", {
	description = SL("Grinder"),
	tiles = {
		{
			image = "grinder_top_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 1.6
			},
		},	 "grinder_bottom.png",
		{
			image = "grinder_side_left_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 3.2
			},
		},
		{
			image = "grinder_side_right_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 3.2
			},
		},
		{
			image = "grinder_side_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 1.0
			},
		},
		{
			image = "grinder_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 1.0
			},
		}
	},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "grinder:grinder",
	groups = {cracky=2, not_in_creative_inventory=1,hot=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", grinder.grinder_inactive_formspec)
		meta:set_string("infotext", "Grinder");
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext",SL("Grinder is empty"))
				end
				return stack:get_count()
			else
				return 0
			end
		elseif listname == "src" then
			return stack:get_count()
		elseif listname == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if to_list == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext",SL("Grinder is empty"))
				end
				return count
			else
				return 0
			end
		elseif to_list == "src" then
			return count
		elseif to_list == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})


--- @type Processor
local Processor = require('grinder.Processor')
minetest.register_abm({
	nodenames = {"grinder:grinder", "grinder:grinder_active"},
	interval = 1,
	chance = 1,
	action = Processor.act,
})

minetest.register_craftitem("grinder:coal_dust", {
	description = SL("Coal dust"),
	inventory_image = "grinder_coal_dust.png",
	groups = {fuel=1,coal=1},
})

minetest.register_craft({
	type = "fuel",
	recipe = "grinder:coal_dust",
	burntime = 50,
})

minetest.register_craftitem("grinder:roll", {
	description = SL("Roll"),
	inventory_image = "grinder_roll.png",
})

require = old_require
