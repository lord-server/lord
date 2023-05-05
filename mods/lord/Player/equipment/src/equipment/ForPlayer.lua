local setmetatable, ipairs
	= setmetatable, ipairs


--- @class equipment.ForPlayer
local ForPlayer = {
	--- @type Player
	player = nil,
	--- @static
	--- @type equipment.Event
	event = nil,
}

--- Constructor
--- @public
--- @param player Player
--- @return equipment.ForPlayer
function ForPlayer:new(player)
	---@type equipment.ForPlayer
	local new_object = {}

	new_object.player = player

	setmetatable(new_object, {__index = self})

	return new_object
end

--- @param kind string
--- @param slot number
--- @return ItemStack
function ForPlayer:get(kind, slot)
	return self.player:get_inventory():get_stack(kind, slot)
end

--- Returns numeric iterator (`ipairs()`) for items of `kind`.
---
--- Use:
---	```lua
---	    for slot, item in equipment.for_player(player):items(kind) do
---	        <statements>
---	    end
--- ```
--- @param kind string    kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
--- @return fun(tbl:table<number,ItemStack>):number,ItemStack
function ForPlayer:items(kind)
	return ipairs(self.player:get_inventory():get_list(kind))
end

--- @param kind string    kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
--- @param slot number    slot number
--- @param item ItemStack item to set into slot
function ForPlayer:set(kind, slot, item)
	self.player:get_inventory():set_stack(kind, slot, item)
	self.event.trigger(self.player, kind, "set", slot, item) -- TODO use Event.SET constant
end

--- @param kind string    kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
--- @param slot number    slot number
function ForPlayer:delete(kind, slot)
	local item = self.player:get_inventory():get_stack(kind, slot)
	self.player:get_inventory():set_stack(kind, slot, nil)
	self.event.trigger(self.player, kind, "delete", slot, item) -- TODO use Event.DELETE constant
end

--- Deletes all existing slots, also triggers `delete` event & so,
---   calls all subscribed to `on_delete`&`on_change` callbacks.
--- @param kind string    kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
function ForPlayer:clear(kind)
	for slot, item in self:items(kind) do
		if not item:is_empty() then
			self:delete(kind, slot)
		end
	end
end

--- @param kind      string    kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
--- @param inventory InvRef    inventory to move to
--- @param list_name string    list name in inventory to moe to
function ForPlayer:move_to(kind, inventory, list_name)
	for slot, item in self:items(kind) do
		if not item:is_empty() then
			self:delete(kind, slot)
			inventory:add_item(list_name, item)
		end
	end
end


return ForPlayer
