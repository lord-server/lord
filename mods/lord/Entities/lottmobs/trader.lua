local SL = minetest.get_translator("lottmobs")

---@param inv        InvRef
---@param from_list  string
---@param from_index number
---@param to_list    string
---@param to_index   number
---@param count      number
---@param player     Player
function lottmobs.allow_move(inv, from_list, from_index, to_list, to_index, count, player)
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
	local old_stack = inv:get_stack(from_list, from_index)
	if count ~= old_stack:get_count() then
		return 0;
	end
	return count
end

---@param inv       InvRef
---@param list_name string
---@param index     number
---@param stack     ItemStack
---@param player    Player
function lottmobs.allow_put(inv, list_name, index, stack, player)
	if list_name == "payment" then
		return stack:get_count()
	end
	return 0
end

---@param inv       InvRef
---@param list_name string
---@param index     number
---@param stack     ItemStack
---@param player    Player
function lottmobs.allow_take(inv, list_name, index, stack, player)
	if list_name == "takeaway" or
		list_name == "payment" then
		return stack:get_count()
	else
		return 0
	end
end

---@param inv       InvRef
---@param list_name string
---@param index     number
---@param stack     ItemStack
---@param player    Player
function lottmobs.on_put(inv, list_name, index, stack, player)
	if list_name == "payment" then
		lottmobs.update_takeaway(inv)
	end
end

---@param inv       InvRef
---@param list_name string
---@param index     number
---@param stack     ItemStack
---@param player    Player
function lottmobs.on_take(inv, list_name, index, stack, player)
	if list_name == "takeaway" then
		local amount = inv:get_stack("payment",1):get_count()
		local price = inv:get_stack("price",1):get_count()
		local thing = inv:get_stack("payment",1):get_name()
		inv:set_stack("selection", 1, nil)
		inv:set_stack("price", 1, nil)
		inv:set_stack("payment", 1, thing .. " " .. amount - price)
	end

	if list_name == "payment" then
		if lottmobs.check_pay(inv, false) then
			local selection = inv:get_stack("selection", 1)
			if selection ~= nil then
				inv:set_stack("takeaway", 1, selection)
			end
		else
			inv:set_stack("takeaway", 1, nil)
		end
	end
end

function lottmobs.update_takeaway(inv)
	if lottmobs.check_pay(inv, false) then
		local selection = inv:get_stack("selection", 1)

		if selection ~= nil then
			inv:set_stack("takeaway", 1, selection)
		end
	else
		inv:set_stack("takeaway", 1, nil)
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

--- @type trader.Form
local Form = dofile(minetest.get_modpath("lottmobs").."/trader_Form.lua")

--- @param entity         LuaEntity
--- @param clicker        Player
--- @param trader_def     TraderDef
--- @param race_privilege string
function lottmobs_trader(entity, clicker, trader_def, race_privilege)
	lottmobs.face_pos(entity, clicker:get_pos())
	local player_name = clicker:get_player_name()
--	self.messages = tostring(race.messages[math.random(1,#race.messages)])
	if entity.id == 0 then
		entity.id = (math.random(1, 1000) * math.random(1, 10000)) .. entity.name .. (math.random(1, 1000) ^ 2)
	end
	if entity.game_name == "mob" then
		entity.game_name = tostring(trader_def.names[math.random(1,#trader_def.names)])
		--self.nametag = self.game_name
	end

	local inventory_id = player_name.."_trader_".. entity.id:gsub(":", "_")

	local is_inventory = minetest.get_inventory({type="detached", name= inventory_id })
	local same_race    = false
	if minetest.get_player_privs(player_name)[race_privilege] ~= nil then
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

				local price = get_price_for(sel_stack_string, trader_def, same_race)
				inventory:set_stack("price", 1, price)
				lottmobs.update_takeaway(inventory)
			end
		end,
		on_put = lottmobs.on_put,
		on_take = lottmobs.on_take
	}
	if is_inventory == nil then
		lottmobs.trader_inventory = minetest.create_detached_inventory(inventory_id, move_put_take, player_name)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"goods",15)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"takeaway",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"selection",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"price",1)
		lottmobs.trader_inventory.set_size(lottmobs.trader_inventory,"payment",1)
		lottmobs.add_goods(same_race, trader_def)
	end
	minetest.chat_send_player(
		player_name,
		"[NPC] <" .. SL("Trader") .. " " .. SL(entity.game_name) .. "> " ..
			SL("Hello") .. ", " .. player_name .. ", \n" ..
			tostring(trader_def.messages[math.random(1, #trader_def.messages)]) -- messages already translated
	)

	Form:new(clicker, inventory_id, entity.game_name):open()

end
