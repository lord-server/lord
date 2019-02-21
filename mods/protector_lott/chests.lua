local SL = lord.require_intllib()

-- Protected Chest

minetest.register_node("protector_lott:chest", {
	description = SL("Protected Chest"),
	tiles = {
		"default_chest_top.png", "default_chest_top.png",
		"default_chest_side.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_front.png^protector_logo.png"
	},
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, unbreakable = 1, wooden = 1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", SL("Protected Chest"))
		meta:set_string("name", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,

	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:is_empty("main") then
			if not minetest.is_protected(pos, player:get_player_name()) then
				return true
			end
		end
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
		" moves stuff to protected chest at " .. minetest.pos_to_string(pos))
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
		" takes stuff from protected chest at " .. minetest.pos_to_string(pos))
	end,

	on_rightclick = function(pos, node, clicker)
		if not minetest.is_protected(pos, clicker:get_player_name()) then
		local meta = minetest.get_meta(pos)
		local spos = pos.x .. "," .. pos.y .. "," ..pos.z
		local formspec = "size[8,9]"..
			prot.gui_bg..prot.gui_bg_img..prot.gui_slots
			.. "list[nodemeta:".. spos .. ";main;0,0.3;8,4;]"
			.. "button[0,4.5;2,0.25;toup;"..SL("To Chest").."]"
			.. "field[2.3,4.8;4,0.25;chestname;;"
			.. meta:get_string("name") .. "]"
			.. "button[6,4.5;2,0.25;todn;"..SL("To Inventory").."]"
			.. "list[current_player;main;0,5;8,1;]"
			.. "list[current_player;main;0,6.08;8,3;8]"
			.. "listring[nodemeta:" .. spos .. ";main]"
			.. "listring[current_player;main]"
			.. prot.get_hotbar_bg(0,5)

			minetest.show_formspec(
				clicker:get_player_name(),
				"protector_lott:chest_" .. minetest.pos_to_string(pos),
				formspec)
		end
	end,
})

-- Protected Chest formspec buttons

minetest.register_on_player_receive_fields(function(player, formname, fields)

	if string.sub(formname, 0, string.len("protector_lott:chest_")) == "protector_lott:chest_" then

		local pos_s = string.sub(formname,string.len("protector_lott:chest_") + 1)
		local pos = minetest.string_to_pos(pos_s)
		local meta = minetest.get_meta(pos)
		local chest_inv = meta:get_inventory()
		local player_inv = player:get_inventory()

		if fields.toup then

			-- copy contents of players inventory to chest
			for i, v in ipairs (player_inv:get_list("main") or {}) do
				if (chest_inv and chest_inv:room_for_item('main', v)) then
					local leftover = chest_inv:add_item('main', v)
					player_inv:remove_item("main", v)
					if (leftover and not(leftover:is_empty())) then
						player_inv:add_item("main", v)
					end
				end
			end

		elseif fields.todn then

			-- copy contents of chest to players inventory
			for i, v in ipairs (chest_inv:get_list('main') or {}) do
				if (player_inv:room_for_item("main", v)) then
					local leftover = player_inv:add_item("main", v)
					chest_inv:remove_item('main', v)
					if( leftover and not(leftover:is_empty())) then
						chest_inv:add_item('main', v)
					end
				end
			end

		elseif fields.chestname then

			-- change chest infotext to display name
			if fields.chestname ~= "" then
				meta:set_string("name", fields.chestname)
				meta:set_string("infotext",
				SL("Protected Chest").." (" .. fields.chestname .. ")")
			else
				meta:set_string("infotext", SL("Protected Chest"))
			end

		end
	end

end)

-- Protected Chest recipe

minetest.register_craft({
	output = 'protector_lott:chest',
	recipe = {
		{'default:chest', 'protector_lott:protect2', ''},
	}
})
