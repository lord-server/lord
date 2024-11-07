local lottpotion_nodes = require('artisan_benches.legacy.helpers')
local S = minetest.get_mod_translator("lottpotion")


-- moved AS IS from lottpotion.

local machine_name = "Potion Brewer"

local formspec = "size[8,9]" ..
	"label[0,0;" .. S(machine_name) .. "]" ..
	"image[4,2;1,1;lottpotion_bubble_off.png]" ..
	"image[3,2;1,1;lottpotion_arrow.png]" ..
	"image[5,2;1,1;lottpotion_arrow.png]" ..
	"label[2.9,3.2;" .. S("Fuel:") .. "]" ..
	"list[current_name;fuel;4,3;1,1;]" ..
	"label[1,1.5;" .. S("Ingredients:") .. "]" ..
	"list[current_name;src;1,2;2,1;]" ..
	"label[6,1.5;" .. S("Result:") .. "]" ..
	"list[current_name;dst;6,2;1,1;]" ..
	"list[current_player;main;0,5;8,4;]" ..
	"listring[current_name;fuel]" ..
	"listring[current_player;main]" ..
	"listring[current_name;src]" ..
	"listring[current_player;main]" ..
	"listring[current_name;dst]" ..
	"listring[current_player;main]" ..
	"background[-0.5,-0.65;9,10.35;gui_brewerbg.png]" ..
	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

minetest.register_node(":lottpotion:potion_brewer", {
	description                   = S(machine_name),
	drawtype                      = "plantlike",
	visual_scale                  = 1.0,
	tiles                         = { "lottpotion_potion_brewer.png" },
	inventory_image               = "lottpotion_potion_brewer.png",
	wield_image                   = "lottpotion_potion_brewer.png",
	paramtype                     = "light",
	selection_box                 = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	groups                        = { cracky = 2 },
	sounds                        = default.node_sound_stone_defaults(),
	on_construct                  = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", S(machine_name))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 2)
		inv:set_size("dst", 1)
	end,
	can_dig                       = lottpotion_nodes.can_dig,

	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local inv = minetest.get_meta(pos):get_inventory()
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if from_list == to_list then
			if inv:get_stack(to_list, to_index):is_empty() then
				return 1
			else
				return 0
			end
		else
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

minetest.register_node(":lottpotion:potion_brewer_active", {
	description                   = machine_name,
	drawtype                      = "plantlike",
	visual_scale                  = 1.0,
	tiles                         = { "lottpotion_potion_brewer_active.png" },
	inventory_image               = "lottpotion_potion_brewer.png",
	wield_image                   = "lottpotion_potion_brewer.png",
	paramtype                     = "light",
	light_source                  = 8,
	selection_box                 = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	drop                          = "lottpotion:potion_brewer",
	groups                        = { cracky = 2, not_in_creative_inventory = 1 },
	sounds                        = default.node_sound_stone_defaults(),
	can_dig                       = lottpotion_nodes.can_dig,
	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local inv = minetest.get_meta(pos):get_inventory()
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if from_list == to_list then
			if inv:get_stack(to_list, to_index):is_empty() then
				return 1
			else
				return 0
			end
		else
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

------------------------------ ABM: -----------------------------------
--- @param percent number
local function get_active_info(percent)
	return S(("%s Brewing"):format(machine_name)) .. " (" .. percent .. "%)"
end
--- @param percent number
local function get_active_form(percent)
	return "size[8,9]" ..
		"label[0,0;" .. S(machine_name) .. "]" ..
		"image[4,2;1,1;lottpotion_bubble_off.png^[lowpart:" .. (percent) .. ":lottpotion_bubble.png]" ..
		"image[3,2;1,1;lottpotion_arrow.png]" ..
		"image[5,2;1,1;lottpotion_arrow.png]" ..
		"label[2.9,3.2;" .. S("Fuel:") .. "]" ..
		"list[current_name;fuel;4,3;1,1;]" ..
		"label[1,1.5;" .. S("Ingredients:") .. "]" ..
		"list[current_name;src;1,2;2,1;]" ..
		"label[6,1.5;" .. S("Result:") .. "]" ..
		"list[current_name;dst;6,2;1,1;]" ..
		"list[current_player;main;0,5;8,4;]" ..
		"listring[current_name;fuel]" ..
		"listring[current_player;main]" ..
		"listring[current_name;src]" ..
		"listring[current_player;main]" ..
		"listring[current_name;dst]" ..
		"listring[current_player;main]" ..
		"background[-0.5,-0.65;9,10.35;gui_brewerbg.png]" ..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
end

minetest.register_abm({
	nodenames = { "lottpotion:potion_brewer", "lottpotion:potion_brewer_active" },
	interval  = 1,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		lottpotion_nodes.init(meta, inv)

		local result     = lottpotion_recipe.get("potion", inv:get_list("src"))

		local was_active = false

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			lottpotion_nodes.process(meta, inv, result)
		end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") / meta:get_float("fuel_totaltime") * 100)
			lottpotion_nodes.update_node(
				pos, meta, "lottpotion:potion_brewer_active", get_active_info(percent), get_active_form(percent)
			)
			return
		end

		local recipe = lottpotion_recipe.get("potion", inv:get_list("src"))

		if not recipe then
			if was_active then
				lottpotion_nodes.update_node(
					pos, meta, "lottpotion:potion_brewer", S(("%s is empty"):format(machine_name)), formspec
				)
			end

			return
		end

		if not inv:room_for_item("dst", ItemStack(result.output)) then
			lottpotion_nodes.update_node(
				pos, meta, "lottpotion:potion_brewer", S(("%s Out Of Heat"):format(machine_name)), formspec
			)
			return
		end

		local fuel
		local after_fuel
		local fuel_list = inv:get_list("fuel")

		if fuel_list then
			fuel, after_fuel = minetest.get_craft_result({ method = "fuel", width = 1, items = fuel_list })
		end

		if fuel.time <= 0 then
			lottpotion_nodes.update_node(
				pos, meta, "lottpotion:potion_brewer", S(("%s Out Of Heat"):format(machine_name)), formspec
			)
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)

		inv:set_stack("fuel", 1, after_fuel.items[1])
	end,
})
