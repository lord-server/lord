local S = minetest.get_translator("lord_traders")

---
--- @class traders.trader.Form
---
local Form = {
	--- @const
	--- @type string
	NAME = "trade",

	--- @type string
	player_name   = nil,
	--- @type string
	inventory_id = nil,
	--- @type string
	trader_name = nil,
}

--- Constructor
--- @public
--- @param player       Player
--- @param inventory_id string
--- @return traders.trader.Form
function Form:new(player, inventory_id, trader_name)
	local class = self
	self = {}

	self.player_name  = player:get_player_name()
	self.inventory_id = inventory_id
	self.trader_name  = trader_name

	return setmetatable(self, { __index = class })
end

--- @public
function Form:open()
	minetest.show_formspec(self.player_name, self.NAME, self:get_spec())
end

--- @private
--- @return string
function Form:get_spec()
	return "size[8,10;]" ..
		"label[0,0;" .. S("Trader") .. " " .. S(self.trader_name) .. S("'s stock:") .. "]" ..
		"list[detached:" .. self.inventory_id .. ";goods;.5,.5;3,5;]" ..
		"label[4.5,0.5;" .. S("Selection") .. "]" ..
		"list[detached:" .. self.inventory_id .. ";selection;4.5,1;5.5,2;]" ..
		"label[6,0.5;" .. S("Price") .. "]" ..
		"list[detached:" .. self.inventory_id .. ";price;6,1;7,2;]" ..
		"label[4.5,3.5;" .. S("Payment") .. "]" ..
		"list[detached:" .. self.inventory_id .. ";payment;4.5,4;5.5,5;]" ..
		"label[6,3.5;" .. S("Brought items") .. "]" ..
		"list[detached:" .. self.inventory_id .. ";takeaway;6,4;7.5,5.5;]" ..
		"list[current_player;main;0,6;8,4;]"
end


return Form
