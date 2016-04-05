local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local shop = {}
shop.current_shop = {}
shop.formspec = {
	customer = function(pos)
		local list_name = "nodemeta:"..pos.x..','..pos.y..','..pos.z
		local formspec = "size[8,9]"..
		"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"..

		"label[0,-0.35;"..SL("Owner gives").."]"..
		"list["..list_name..";owner_gives;0,0.1;2,2;]"..

		"label[0,1.95;"..SL("Owner wants").."]"..
		"list["..list_name..";owner_wants;0,2.4;2,2;]"..

		"label[3,-0.35;"..SL("Customer gives (pay here !)").."]"..
		"list[current_player;customer_gives;3,0.1;5,2;]"..

		"label[3,1.95;"..SL("Customer gets").."]"..
		"list[current_player;customer_gets;3,2.4;5,2;]"..

		"button[0,4.35;8,1;exchange;"..SL("Exchange").."]"..
		"list[current_player;main;0,5.3;8,4;]"
		return formspec
	end,
	owner = function(pos)
		local list_name = "nodemeta:"..pos.x..','..pos.y..','..pos.z
		local formspec = "size[8,9]"..
		"background[-0.5,-0.65;9,10.35;gui_chestbg.png]"..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"..

		"label[0,-0.35;"..SL("In exchange, you give:").."]"..
		"list["..list_name..";owner_gives;0,0.1;2,2;]"..

		"label[0,1.95;"..SL("You want:").."]"..
		"list["..list_name..";owner_wants;0,2.4;2,2;]"..

		"label[3,-0.35;"..SL("Your stock:").."]"..
		"list["..list_name..";stock;3,0.1;5,2;]"..

		"label[3,1.95;"..SL("Customers gave:").."]"..
		"list["..list_name..";customers_gave;3,2.4;5,2;]"..

		"label[0,4.35;"..SL("Owner, Use(E)+Place(RMB) for customer interface").."]"..
		"list[current_player;main;0,5.3;8,4;]"
		return formspec
	end,
}

shop.check_privilege = function(listname,playername,meta)
	--[[if listname == "pl1" then
		if playername ~= meta:get_string("pl1") then
			return false
		elseif meta:get_int("pl1step") ~= 1 then
			return false
		end
	end
	if listname == "pl2" then
		if playername ~= meta:get_string("pl2") then
			return false
		elseif meta:get_int("pl2step") ~= 1 then
			return false
		end
	end]]
	return true
end


shop.give_inventory = function(inv,list,playername)
	player = minetest.env:get_player_by_name(playername)
	if player then
		for k,v in ipairs(inv:get_list(list)) do
			player:get_inventory():add_item("main",v)
			inv:remove_item(list,v)
		end
	end
end


minetest.register_node("lord_money:shop", {
	description = SL("Shop Chest"),
	tiles = {"shop_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2, wooden=1},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local owner = placer:get_player_name()
		local meta = minetest.env:get_meta(pos)
		meta:set_string("infotext", SL("Exchange shop (owned by").." "..owner..")")
		meta:set_string("owner",owner)
		--[[meta:set_string("pl1","")
		meta:set_string("pl2","")]]
		local inv = meta:get_inventory()
		inv:set_size("customers_gave", 5*2)
		inv:set_size("stock", 5*2)
		inv:set_size("owner_wants", 2*2)
		inv:set_size("owner_gives", 2*2)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		clicker:get_inventory():set_size("customer_gives", 5*2)
		clicker:get_inventory():set_size("customer_gets", 5*2)
		shop.current_shop[clicker:get_player_name()] = pos
		local meta = minetest.env:get_meta(pos)
		if clicker:get_player_name() == meta:get_string("owner") and not clicker:get_player_control().aux1 then
			minetest.show_formspec(clicker:get_player_name(),"lord_money:shop_formspec",shop.formspec.owner(pos))
		else
			minetest.show_formspec(clicker:get_player_name(),"lord_money:shop_formspec",shop.formspec.customer(pos))
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if player:get_player_name() ~= meta:get_string("owner") then return 0 end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if player:get_player_name() ~= meta:get_string("owner") then return 0 end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if player:get_player_name() ~= meta:get_string("owner") then return 0 end
		return stack:get_count()
	end,
	can_dig = function(pos, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("stock") and inv:is_empty("customers_gave") and inv:is_empty("owner_wants") and inv:is_empty("owner_gives")
	end
})

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if formname == "lord_money:shop_formspec" and fields.exchange ~= nil and fields.exchange ~= "" then
		local name = sender:get_player_name()
		local pos = shop.current_shop[name]
		local meta = minetest.env:get_meta(pos)
		if meta:get_string("owner") == name then
			minetest.chat_send_player(name, SL("This is your own shop, you can't exchange to yourself!"))
		else
			local minv = meta:get_inventory()
			local pinv = sender:get_inventory()
			local invlist_tostring = function(invlist)
				local out = {}
				for i, item in pairs(invlist) do
					out[i] = item:to_string()
				end
				return out
			end
			local wants = minv:get_list("owner_wants")
			local gives = minv:get_list("owner_gives")
			if wants == nil or gives == nil then return end -- do not crash the server
			-- Check if we can exchange
			local can_exchange = true
			local owners_fault = false
			local buffer_w = {}
			for i, item in pairs(wants) do
				if pinv:contains_item("customer_gives",item) then
					pinv:remove_item("customer_gives",item)
					buffer_w[i] = item
				else
					can_exchange = false
					owners_fault = true
				end
			end
			for i, item in pairs(buffer_w) do
				pinv:add_item("customer_gives",item)
			end
			local buffer_g = {}
			for i, item in pairs(gives) do
				if minv:contains_item("stock",item) then
					minv:remove_item("stock",item)
					buffer_g[i] = item
				else
					can_exchange = false
					owners_fault = true
				end
			end
			for i, item in pairs(buffer_g) do
				minv:add_item("stock",item)
			end
			if can_exchange then
				for i, item in pairs(wants) do
					pinv:remove_item("customer_gives",item)
					minv:add_item("customers_gave",item)
				end
				for i, item in pairs(gives) do
					minv:remove_item("stock",item)
					pinv:add_item("customer_gets",item)
				end
				minetest.chat_send_player(name, SL("Exchanged!"))
			else
				if minv:is_empty("stock") then
					local mail = get_mail(meta:get_string("owner"))
					if not mail then
						minetest.chat_send_player(name, SL("Exchange can not be done, contact the shop owner."))
					else
						minetest.chat_send_player(name, SL("Exchange can not be done, visit later."))
						local report = SL("In your store").." "..minetest.pos_to_string(pos).." "..SL("ended goods.")
						os.execute("echo '"..report.."' | mail -s 'store' "..mail)
					end
				else
					minetest.chat_send_player(name, SL("Exchange can not be done, check if you put all items!"))
				end
--[[
				if owners_fault then
					minetest.chat_send_player(name, SL("Exchange can not be done, contact the shop owner."))
				else
					minetest.chat_send_player(name, SL("Exchange can not be done, check if you put all items!"))
				end
]]--
			end
		end
	end
end)

