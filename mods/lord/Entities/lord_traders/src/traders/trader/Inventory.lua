--- @param inv InvRef
--- @return boolean
local function check_pay(inv)
	local payment     = inv:get_stack("payment", 1)
	local price       = inv:get_stack("price", 1)
	local price_count = price:get_count()

	return
		price:get_name() == payment:get_name() and
		price_count > 0 and price_count <= payment:get_count()
end

--- @param inv InvRef
local function update_takeaway(inv)
	if check_pay(inv) then
		local selection = inv:get_stack("selection", 1)

		if selection ~= nil then
			inv:set_stack("takeaway", 1, selection)
		end
	else
		inv:set_stack("takeaway", 1, nil)
	end
end

--- @param trader_inventory InvRef
--- @param goods_config     traders.config.good[]
local function add_goods(trader_inventory, goods_config)
	local max_goods = trader_inventory:get_size("goods")
	local i = 1

	for name, good in pairs(goods_config) do
		-- FIXME: оказывается это какой-то обратный процент, т.к. ">", а не "<"
		if not good.chance or math.random(0, 100) > good.chance then
			trader_inventory:set_stack("goods", i, name)
			i = i + 1
			if i > max_goods then
				break
			end
		end
	end
end

--- @param price     string stack string (for ex.: "lord_money:silver_coin 9")
--- @param same_race boolean
local function get_discount(price, same_race)
	-- TODO: calc same race discount
	return price
end

--- @param price string|number
--- @return string  stack string (for ex.: "lord_money:silver_coin 9")
local function price_to_stack_string(price)
	if type(price) == "string" then return price end

	if price % 1000 == 0 then return "lord_money:diamond_coin " .. (price / 1000) end
	if price % 100  == 0 then return "lord_money:gold_coin "    .. (price / 100 ) end
	if price % 10   == 0 then return "lord_money:silver_coin "  .. (price / 10  ) end
	return                           "lord_money:copper_coin "  ..  price
end

--- @param good_stack_string string
--- @param goods_config      traders.config.good[]
--- @param same_race         boolean
--- @return string|nil stack string (for ex.: "lord_money:silver_coin 9")
local function get_price_for(good_stack_string, goods_config, same_race)
	local good = goods_config[good_stack_string]
	if not good then return nil end

	return price_to_stack_string(get_discount(good.price, same_race))
end

------------------------------------------------------------------------------------------------------------------------

---
--- @class traders.trader.Inventory
---
local Inventory = {
	--- @type string
	player_name = nil,
	--- @type LuaEntity
	entity_id = nil,
	--- @type string
	detached_inv_id = nil,
	--- @type traders.config.good[]
	goods_config = nil,
	--- @type boolean
	same_race = false,
}

--- @type table<string,traders.trader.Inventory>
local inventories_by_id = {}

------------------------------------------------------------------------------------------------------------------------

--- @type DetachedInventoryCallbacksDef
local inventory_callbacks = {}

---@param inv        InvRef
---@param from_list  string
---@param from_index number
---@param to_list    string
---@param to_index   number
---@param count      number
---@param player     Player
function inventory_callbacks.allow_move(inv, from_list, from_index, to_list, to_index, count, player)
	if
		(from_list == "goods" and (to_list ~= "selection" and to_list ~= "goods")) or
		(from_list == "selection" and to_list ~= "goods") or
		from_list:is_one_of({"price", "payment", "takeaway"})
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
function inventory_callbacks.allow_put(inv, list_name, index, stack, player)
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
function inventory_callbacks.allow_take(inv, list_name, index, stack, player)
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
function inventory_callbacks.on_put(inv, list_name, index, stack, player)
	if list_name == "payment" then
		update_takeaway(inv)
	end
end

---@param inv       InvRef
---@param list_name string
---@param index     number
---@param stack     ItemStack
---@param player    Player
function inventory_callbacks.on_take(inv, list_name, index, stack, player)
	if list_name == "takeaway" then
		local amount = inv:get_stack("payment",1):get_count()
		local price = inv:get_stack("price",1):get_count()
		local thing = inv:get_stack("payment",1):get_name()

		local good_name = inv:get_stack("selection",1):to_string()
		local inventory_id = inv:get_location().name
		local good = Inventory.get_by_id(inventory_id).goods_config[good_name]

		if good and good.stock then
			inv:set_stack("selection", 1, nil)
			inv:set_stack("price", 1, nil)
		end
		inv:set_stack("payment", 1, thing .. " " .. amount - price)
		update_takeaway(inv)
	end

	if list_name == "payment" then
		if check_pay(inv) then
			local selection = inv:get_stack("selection", 1)
			if selection ~= nil then
				inv:set_stack("takeaway", 1, selection)
			end
		else
			inv:set_stack("takeaway", 1, nil)
		end
	end
end



--- Constructor
--- @public
--- @param player         Player
--- @param entity         LuaEntity
--- @param goods_config   traders.config.good[]
--- @param race_privilege string
--- @return traders.trader.Inventory
function Inventory:new(player, entity, goods_config, race_privilege)
	local class = self
	self = {}

	self.player_name  = player:get_player_name()
	self.entity_id    = entity.id
	self.goods_config = goods_config
	if minetest.get_player_privs(self.player_name)[race_privilege] ~= nil then
		self.same_race = true
	end

	return setmetatable(self, { __index = class })
end

--- @static
--- @param inventory_id string
--- @return traders.trader.Inventory|nil
function Inventory.get_by_id(inventory_id)
	return inventories_by_id[inventory_id]
end

--- @private
--- @param inventory_id string
--- @return InvRef
function Inventory:create_detached_inventory(inventory_id)
	--- @type DetachedInventoryCallbacksDef
	local callbacks = {
		allow_move = inventory_callbacks.allow_move,
		allow_put = inventory_callbacks.allow_put,
		allow_take = inventory_callbacks.allow_take,
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

				local price = get_price_for(sel_stack_string, self.goods_config, self.same_race)
				inventory:set_stack("price", 1, price)
				update_takeaway(inventory)
			end
		end,
		on_put = inventory_callbacks.on_put,
		on_take = inventory_callbacks.on_take
	}

	local trader_inventory = minetest.create_detached_inventory(inventory_id, callbacks, self.player_name)
	trader_inventory:set_size("goods", 15)
	trader_inventory:set_size("takeaway", 1)
	trader_inventory:set_size("selection", 1)
	trader_inventory:set_size("price", 1)
	trader_inventory:set_size("payment", 1)
	add_goods(trader_inventory, self.goods_config)

	return trader_inventory
end

--- @private
--- @return InvRef
function Inventory:get_or_create_detached_inventory()
	self.detached_inv_id = self.player_name.."_trader_".. self.entity_id:gsub(":", "_")
	inventories_by_id[self.detached_inv_id] = self

	local trader_inventory = minetest.get_inventory({ type ="detached", name = self.detached_inv_id })
	if trader_inventory ~= nil then
		return trader_inventory
	end

	return self:create_detached_inventory(self.detached_inv_id)
end

--- @public
--- @return string
function Inventory:get_id()
	if self.detached_inv_id == nil then
		self:get_or_create_detached_inventory()
	end

	return self.detached_inv_id
end

return Inventory
