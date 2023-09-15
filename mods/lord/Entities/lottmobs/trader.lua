--This code comes almost exclusively from the trader and inventory of mobf, by Sapier.
--The copyright notice bellow is from mobf:
-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file inventory.lua
--! @brief component containing mob inventory related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-02
--
--! @defgroup Inventory Inventory subcomponent
--! @brief Component handling mob inventory
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
local SL = minetest.get_translator("lottmobs")

function lottmobs.allow_move(inv, from_list, from_index, to_list, to_index, count, player)
	print('allow_move')
	if
		(from_list == "goods" and (to_list ~= "selection" and to_list ~= "goods")) or
		(from_list == "selection" and to_list ~= "goods") or
		from_list == "price" or
		from_list == "payment" or
		from_list == "takeaway" or
		from_list == "identifier"
	then
		return 0
	end
	-- forbid moving of parts of stacks
	local old_stack = inv.get_stack(inv, from_list, from_index)
	if count ~= old_stack.get_count(old_stack) then
		return 0;
	end
	return count
end

function lottmobs.allow_put(inv, listname, index, stack, player)
	if listname == "payment" then
		return 99
	end
	return 0
end

function lottmobs.allow_take(inv, listname, index, stack, player)
	if listname == "takeaway" or
		listname == "payment" then
		return 99
	else
		return 0
	end
end

function lottmobs.on_put(inv, listname, index, stack)
	if listname == "payment" then
		lottmobs.update_takeaway(inv)
	end
end

function lottmobs.on_take(inv, listname, count, index, stack, player)
	if listname == "takeaway" then
		local amount = inv:get_stack("payment",1):get_count()
		local price = inv:get_stack("price",1):get_count()
		local thing = inv:get_stack("payment",1):get_name()
		inv.set_stack(inv,"selection",1,nil)
		inv.set_stack(inv,"price",1,nil)
		inv.set_stack(inv,"takeaway",1,nil)
		inv.set_stack(inv,"payment",1,thing .. " " .. amount-price)
	end

	if listname == "payment" then
		if lottmobs.check_pay(inv,false) then
			local selection = inv.get_stack(inv,"selection", 1)
			if selection ~= nil then
				inv.set_stack(inv,"takeaway",1,selection)
			end
		else
			inv.set_stack(inv,"takeaway",1,nil)
		end
	end
end

function lottmobs.update_takeaway(inv)
	print('update_takeaway')
	if lottmobs.check_pay(inv,false) then
		local selection = inv.get_stack(inv,"selection", 1)

		if selection ~= nil then
			inv.set_stack(inv,"takeaway",1,selection)
		end
	else
		inv.set_stack(inv,"takeaway",1,nil)
	end
end

function lottmobs.check_pay(inv,paynow)
	local now_at_pay = inv.get_stack(inv,"payment",1)
	local count      = now_at_pay.get_count(now_at_pay)
	local name       = now_at_pay.get_name(now_at_pay)

	local price_inv  = inv.get_stack(inv,"price", 1)

	if price_inv:get_name() == name then
		local price = price_inv:get_count()
		if price > 0 and price <= count then
			if paynow then
				now_at_pay.take_item(now_at_pay,price)
				inv.set_stack(inv,"payment",1,now_at_pay)
				return true
			else
				return true
			end
		else
			if paynow then
				inv.set_stack(inv,"payment",1,nil)
			end
		end
	end

	return false
end
lottmobs.trader_inventories = {}

function lottmobs.add_goods(same_race, race)
	for i=1,15 do
		if same_race == true then
			if math.random(0, 100) > race.items_race[i][3] then
				lottmobs.trader_inventory.set_stack(lottmobs.trader_inventory,"goods", i, race.items_race[i][1])
			end
		else
			if math.random(0, 100) > race.items[i][3] then
				lottmobs.trader_inventory.set_stack(lottmobs.trader_inventory,"goods", i, race.items[i][1])
			end
		end
	end
end

function lottmobs.face_pos(self,pos)
	local s = self.object:get_pos()
	local vec = {x=pos.x-s.x, y=pos.y-s.y, z=pos.z-s.z}
	local yaw = math.atan2(vec.z,vec.x)-math.pi/2
	if self.drawtype == "side" then
		yaw = yaw+(math.pi/2)
	end
	self.object:set_yaw(yaw)
	return yaw
end

--- @param good_stack_string string
--- @param trader_def        table
--- @param same_race         boolean
local function get_price_for(good_stack_string, trader_def, same_race)
	local prices = same_race == true
		and trader_def.items_race
		or  trader_def.items

	for _, price in pairs(prices) do
		if price[1] == good_stack_string then
			return price[2]
		end
	end

	return nil
end
----

function lottmobs_trader(self, clicker, entity, race, priv)
	lottmobs.face_pos(self, clicker:get_pos())
	local player_name = clicker:get_player_name()
--	self.messages = tostring(race.messages[math.random(1,#race.messages)])
	if self.id == 0 then
		self.id = (math.random(1, 1000) * math.random(1, 10000)) .. self.name .. (math.random(1, 1000) ^ 2)
	end
	if self.game_name == "mob" then
		self.game_name = tostring(race.names[math.random(1,#race.names)])
		--self.nametag = self.game_name
	end

	local unique_entity_id = player_name.."_trader_"..self.id:gsub(":", "_")

	local is_inventory = minetest.get_inventory({type="detached", name=unique_entity_id})
	local same_race = false
	if minetest.get_player_privs(player_name)[priv] ~= nil then
		same_race = true
	end
	local move_put_take = {
		allow_move = lottmobs.allow_move,
		allow_put = lottmobs.allow_put,
		allow_take = lottmobs.allow_take,
		--- @param inventory  InvRef
		--- @param from_list  string
		--- @param from_index number
		--- @param to_list    string
		--- @param to_index   number
		--- @param count      number
		on_move = function(inventory, from_list, from_index, to_list, to_index, count, _)
			if
				(from_list == "goods" and to_list == "selection") or
				(from_list == "selection" and to_list == "goods")
			then
				local sel_stack = inventory:get_stack("selection", 1)
				local sel_stack_string = sel_stack:get_name() .. " " .. sel_stack:get_count()

				local price = get_price_for(sel_stack_string, race, same_race)
				inventory:set_stack("price", 1, price)
				lottmobs.update_takeaway(inventory)
			end
		end,
		on_put = lottmobs.on_put,
		on_take = lottmobs.on_take
	}
	if is_inventory == nil then
		lottmobs.trader_inventory = minetest.create_detached_inventory(unique_entity_id, move_put_take, player_name)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"goods",15)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"takeaway",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"selection",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"price",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"payment",1)
		lottmobs.add_goods(same_race, race)
	end
	minetest.chat_send_player(
		player_name,
		"[NPC] <" .. SL("Trader") .. " " .. SL(self.game_name) .. "> " ..
			SL("Hello") .. ", " .. player_name .. ", \n" ..
			tostring(race.messages[math.random(1, #race.messages)]) -- messages already translated
	)
	minetest.show_formspec(player_name, "trade",
		"size[8,10;]" ..
		"label[0,0;"..SL("Trader").." " .. SL(self.game_name) .. SL("'s stock:").."]" ..
		"list[detached:" .. unique_entity_id .. ";goods;.5,.5;3,5;]" ..
		"label[4.5,0.5;"..SL("Selection").."]" ..
		"list[detached:" .. unique_entity_id .. ";selection;4.5,1;5.5,2;]" ..
		"label[6,0.5;"..SL("Price").."]" ..
		"list[detached:" .. unique_entity_id .. ";price;6,1;7,2;]" ..
		"label[4.5,3.5;"..SL("Payment").."]" ..
		"list[detached:" .. unique_entity_id .. ";payment;4.5,4;5.5,5;]" ..
		"label[6,3.5;"..SL("Brought items").."]" ..
		"list[detached:" .. unique_entity_id .. ";takeaway;6,4;7.5,5.5;]" ..
		"list[current_player;main;0,6;8,4;]"
	)
end
