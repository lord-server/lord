local S = minetest.get_translator("lord_traders")

--- @class traders.trader.Form.Event
local Event = {
	CLOSE = "close",
}

---
--- @class traders.trader.Form
---
local Form = {
	--- @const
	--- @type string
	NAME         = "lord_traders:trade",
	--- @static
	--- @private
	--- @type table<string,traders.trader.Form>
	opened_for   = {},
	--- @static
	--- @type table <string,fun(form:traders.trader.Form)[]>
	event_callback = {
		["on_"..Event.CLOSE] = {}
	},

	--- @type string
	player_name  = nil,
	--- @type string
	inventory_id = nil,
	--- @type string
	trader_name  = nil,
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
--- @static
--- @param player Player
function Form.get_opened_for(player)
	return Form.opened_for[player:get_player_name()]
end

--- @private
--- @param event string
function Form:trigger(event)
	for _, callback in pairs(self.event_callback["on_"..event]) do
		callback(self)
	end
end

--- @public
--- @static
--- @param callback fun(form:traders.trader.Form)
function Form.on_close(callback)
	table.insert(Form.event_callback["on_" .. Event.CLOSE], callback)
end

--- @public
function Form:open()
	self.opened_for[self.player_name] = self;
	minetest.show_formspec(self.player_name, self.NAME, self:get_spec())
end

--- @public
function Form:close()
	self.opened_for[self.player_name] = nil
	self:trigger(Event.CLOSE)
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
		"list[current_player;main;0,6;8,4;]" ..
		"listring[current_player;main]" ..
		"listring[detached:" .. self.inventory_id .. ";payment]" ..
		"listring[current_player;main]" ..
		"listring[detached:" .. self.inventory_id .. ";takeaway]" ..
		"listring[current_player;main]" ..
		"listring[detached:" .. self.inventory_id .. ";goods]" ..
		"listring[detached:" .. self.inventory_id .. ";selection]" ..
		"listring[detached:" .. self.inventory_id .. ";goods]"
end

--- @public
--- @static
--- @param player    Player
--- @param form_name string
--- @param fields    table
function Form.handler(player, form_name, fields)
	if form_name ~= Form.NAME then
		return
	end

	local form = Form.get_opened_for(player)
	if not form then return end

	if fields.quit then
		form:close()
	end
end

minetest.register_on_player_receive_fields(Form.handler)

--- @param player Player
minetest.register_on_leaveplayer(function(player, timed_out)
	local form = Form.get_opened_for(player);
	if form then
		form:close()
	end
end)


return Form
