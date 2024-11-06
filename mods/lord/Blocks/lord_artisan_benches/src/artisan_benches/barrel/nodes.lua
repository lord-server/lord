local SL = minetest.get_mod_translator()

-- moved AS IS from lottpotion.

local geometry = require('artisan_benches.barrel.nodes.geometry')

local machine_name = "Brewer"

local formspec     = "size[8,9]" ..
	"label[0,0;" .. SL(machine_name) .. "]" ..
	"image[4,2;1,1;default_brewer_inv.png]" ..
	"image[3,2;1,1;lottpotion_arrow.png]" ..
	"image[5,2;1,1;lottpotion_arrow.png]" ..
	"label[2.9,3.2;" .. SL("Fuel:") .. "]" ..
	"list[current_name;fuel;4,3;1,1;]" ..
	"label[1,1.5;" .. SL("Ingredients:") .. "]" ..
	"list[current_name;src;1,2;2,1;]" ..
	"label[6,1.5;" .. SL("Result:") .. "]" ..
	"list[current_name;dst;6,2;1,1;]" ..
	"list[current_name;dst2;6,3;1,1;]" ..
	"list[current_player;main;0,5;8,4;]" ..
	"listring[current_name;fuel]" ..
	"listring[current_player;main]" ..
	"listring[current_name;src]" ..
	"listring[current_player;main]" ..
	"listring[current_name;dst]" ..
	"listring[current_player;main]" ..
	"listring[current_name;dst2]" ..
	"listring[current_player;main]" ..
	"background[-0.5,-0.65;9,10.35;gui_brewerbg.png]" ..
	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

minetest.register_node(":lottpotion:brewer", {
	description                   = SL(machine_name),
	drawtype                      = "nodebox",
	tiles                         = { "default_wood.png" },
	node_box                      = {
		type  = "fixed",
		fixed = geometry.make_pipe(
			{
				{ f = 0.9,  h1 = -0.2,  h2 = 0.2,   b = 0 },
				{ f = 0.75, h1 = -0.50, h2 = -0.35, b = 0 },
				{ f = 0.75, h1 = 0.35,  h2 = 0.5,   b = 0 },
				{ f = 0.82, h1 = -0.35, h2 = -0.2,  b = 0 },
				{ f = 0.82, h1 = 0.2,   h2 = 0.35,  b = 0 },
				{ f = 0.75, h1 = 0.37,  h2 = 0.42,  b = 1 },
				{ f = 0.75, h1 = -0.42, h2 = -0.37, b = 1 },
			},
			0
		),
	},
	paramtype                     = "light",
	groups                        = { choppy = 2, oddly_breakable_by_hand = 2 },
	sounds                        = default.node_sound_stone_defaults(),
	selection_box                 = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	on_construct                  = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", SL(machine_name))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 2)
		inv:set_size("dst", 1)
		inv:set_size("dst2", 1)
	end,
	can_dig                       = lottpotion_nodes.can_dig,
	--backwards compatibility: punch to set formspec
	on_punch                      = function(pos, player)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL(machine_name))
		meta:set_string("formspec", formspec)
	end,

	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if listname == 'dst' or listname == 'dst2' then
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
		--return 1
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})

minetest.register_node(":lottpotion:brewer_active", {
	description                   = SL(machine_name),
	drawtype                      = "nodebox",
	tiles                         = { "default_wood.png" },
	node_box                      = {
		type  = "fixed",
		fixed = geometry.make_pipe(
			{
				{ f = 0.9,  h1 = -0.2,  h2 = 0.2,   b = 0 },
				{ f = 0.75, h1 = -0.50, h2 = -0.35, b = 0 },
				{ f = 0.75, h1 = 0.35,  h2 = 0.5,   b = 0 },
				{ f = 0.82, h1 = -0.35, h2 = -0.2,  b = 0 },
				{ f = 0.82, h1 = 0.2,   h2 = 0.35,  b = 0 },
				{ f = 0.75, h1 = 0.37,  h2 = 0.42,  b = 1 },
				{ f = 0.75, h1 = -0.42, h2 = -0.37, b = 1 }
			},
			0
		),
	},
	paramtype                     = "light",
	selection_box                 = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	drop                          = "lottpotion:brewer",
	groups                        = { cracky = 2, not_in_creative_inventory = 1 },
	sounds                        = default.node_sound_stone_defaults(),
	can_dig                       = lottpotion_nodes.can_dig,
	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if listname == 'dst' or listname == 'dst2' then
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
		--return 1
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})

minetest.register_abm({
	nodenames = { "lottpotion:brewer", "lottpotion:brewer_active" },
	interval  = 1,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()

		if meta:get_string("infotext") == "" then
			meta:set_string("formspec", formspec)
			meta:set_string("infotext", machine_name)
			inv:set_size("fuel", 1)
			inv:set_size("src", 2)
			inv:set_size("dst", 1)
		end

		if inv:get_size("src") == 1 then -- Old furnace -> convert it
			inv:set_size("src", 2)
			inv:set_stack("src", 2, inv:get_stack("src2", 1))
			inv:set_size("src2", 0)
		end

		for _, name in pairs({
			"fuel_totaltime",
			"fuel_time",
			"src_totaltime",
			"src_time" }) do
			if not meta:get_float(name) then
				meta:set_float(name, 0.0)
			end
		end

		local result     = lottpotion_recipe.get("brew", inv:get_list("src"))

		local was_active = false

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_int("fuel_time", meta:get_int("fuel_time") + 1)
			if result then
				meta:set_int("src_time", meta:get_int("src_time") + 1)
				if meta:get_int("src_time") >= result.time then
					meta:set_int("src_time", 0)
					local result_stack = ItemStack(result.output)
					local result_2_stack = ItemStack(result.output_2)
					if inv:room_for_item("dst", result_stack) and inv:room_for_item("dst2", result_2_stack) then
						inv:set_list("src", result.new_input)
						inv:add_item("dst", result_stack)
						if result.output_2 ~= "" then
							inv:add_item("dst2", ItemStack(result.output_2))
						end
					end
				end
			else
				meta:set_int("src_time", 0)
			end
		end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
				meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext", SL(("%s Brewing"):format(machine_name)) .. " (" .. percent .. "%)")
			lottpotion_nodes.swap_node(pos, "lottpotion:brewer_active")
			meta:set_string("formspec",
				"size[8,9]" ..
					"label[0,0;" .. SL(machine_name) .. "]" ..
					"image[4,2;1,1;default_brewer_inv.png^[lowpart:" ..
					(percent) .. ":lottpotion_bubble.png]" ..
					"image[3,2;1,1;lottpotion_arrow.png]" ..
					"image[5,2;1,1;lottpotion_arrow.png]" ..
					"label[2.9,3.2;" .. SL("Fuel:") .. "]" ..
					"list[current_name;fuel;4,3;1,1;]" ..
					"label[1,1.5;" .. SL("Ingredients:") .. "]" ..
					"list[current_name;src;1,2;2,1;]" ..
					"label[6,1.5;" .. SL("Result:") .. "]" ..
					"list[current_name;dst;6,2;1,1;]" ..
					"list[current_name;dst2;6,3;1,1;]" ..
					"list[current_player;main;0,5;8,4;]" ..
					"listring[current_name;fuel]" ..
					"listring[current_player;main]" ..
					"listring[current_name;src]" ..
					"listring[current_player;main]" ..
					"listring[current_name;dst]" ..
					"listring[current_player;main]" ..
					"listring[current_name;dst2]" ..
					"listring[current_player;main]" ..
					"background[-0.5,-0.65;9,10.35;gui_brewerbg.png]" ..
					"listcolors[#606060AA;#888;#141318;#30434C;#FFF]")
			return
		end

		local recipe = lottpotion_recipe.get("brew", inv:get_list("src"))

		if not recipe then
			if was_active then
				meta:set_string("infotext", SL(("%s is empty"):format(machine_name)))
				lottpotion_nodes.swap_node(pos, "lottpotion:brewer")
				meta:set_string("formspec", formspec)
			end
			return
		end

		local fuel     = nil
		local afterfuel
		local fuellist = inv:get_list("fuel")

		if fuellist then
			fuel, afterfuel = minetest.get_craft_result({ method = "fuel", width = 1, items = fuellist })
		end

		if fuel.time <= 0 then
			meta:set_string("infotext", SL(("%s Out Of Heat"):format(machine_name)))
			lottpotion_nodes.swap_node(pos, "lottpotion:brewer")
			meta:set_string("formspec", formspec)
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)

		inv:set_stack("fuel", 1, afterfuel.items[1])
	end,
})

-- LBMS
minetest.register_lbm({
	label = "formspec brewer replacement",
	name = ":lottpotion:brewer_formspec_replacement_2",
	nodenames = {"lottpotion:brewer"},
	run_at_every_load = false,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		meta:set_string('formspec', formspec)
	end
})
