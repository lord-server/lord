local S = minetest.get_translator("lord_inventory")

local get_formspec = function(player, page)
	if page == "bags" then
		return "size[8,7.5]"
			.. "list[current_player;main;0,3.5;8,4;]"
			.. "button[0,0;2,0.5;main;" .. S("Back") .. "]"
			.. "button[0,2;2,0.5;bag1;" .. S("Bag") .. " 1]"
			.. "button[2,2;2,0.5;bag2;" .. S("Bag") .. " 2]"
			.. "button[4,2;2,0.5;bag3;" .. S("Bag") .. " 3]"
			.. "button[6,2;2,0.5;bag4;" .. S("Bag") .. " 4]"
			.. "list[detached:" .. player:get_player_name() .. "_bags;bag1;0.5,1;1,1;]"
			.. "list[detached:" .. player:get_player_name() .. "_bags;bag2;2.5,1;1,1;]"
			.. "list[detached:" .. player:get_player_name() .. "_bags;bag3;4.5,1;1,1;]"
			.. "list[detached:" .. player:get_player_name() .. "_bags;bag4;6.5,1;1,1;]"
	end
	for i = 1, 4 do
		if page == "bag" .. i then
			local image = player:get_inventory():get_stack("bag" .. i, 1):get_definition().inventory_image
			return "size[8,8.5]"
				.. "list[current_player;main;0,4.5;8,4;]"
				.. "button[0,0;2,0.5;main;" .. S("Main") .. "]"
				.. "button[2,0;2,0.5;bags;" .. S("Bags") .. "]"
				.. "image[7,0;1,1;" .. image .. "]"
				.. "list[current_player;bag" .. i .. "contents;0,1;8,3;]"
				.. "listring[current_player;bag" .. i .. "contents]"
				.. "listring[current_player;main]"
		end
	end
end

minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if fields.bags then
		minetest.show_formspec(player:get_player_name(), "custom", get_formspec(player, "bags"))
		return
	end
	for i = 1, 4 do
		local page = "bag" .. i
		if fields[page] then
			if player:get_inventory():get_stack(page, 1):get_definition().groups.bagslots == nil then
				page = "bags"
			end
			minetest.show_formspec(player:get_player_name(), "custom", get_formspec(player, page))
			return
		end
	end
end)

--- @param joined_player Player
minetest.register_on_joinplayer(function(joined_player, last_login)
	local player_name = joined_player:get_player_name()
	local player_inv  = joined_player:get_inventory()

	local bags_inv    = minetest.create_detached_inventory(player_name .. "_bags", {
		on_put     = function(inv, list_name, index, stack, player)
			player:get_inventory():set_stack(list_name, index, stack)
			player:get_inventory():set_size(list_name .. "contents", stack:get_definition().groups.bagslots)
		end,
		on_take    = function(inv, list_name, index, stack, player)
			player:get_inventory():set_stack(list_name, index, nil)
		end,
		allow_put  = function(inv, list_name, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, list_name, index, stack, player)
			if player:get_inventory():is_empty(list_name .. "contents") == true then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	}, player_name)

	for i = 1, 4 do
		local bag = "bag" .. i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag, 1, player_inv:get_stack(bag, 1))
	end
end)
