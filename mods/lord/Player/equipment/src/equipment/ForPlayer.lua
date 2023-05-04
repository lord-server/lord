local setmetatable
	= setmetatable


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
function ForPlayer:get(kind, slot)
	self.player:get_inventory():get_stack(kind, slot)
end

--- @param kind string    kind(type) of equipment. For ex. "armor"|"clothing"|<your one>
--- @param slot number    slot number
--- @param item ItemStack item to set into slot
function ForPlayer:set(kind, slot, item)
	self.player:get_inventory():set_stack(kind, slot, item)
	self.event.trigger(self.player, kind, "set", slot, item) -- TODO use Event.SET constant
end

--- @param kind string    kind(type) of equipment. For ex. "armor"|"clothing"|<your one>
--- @param slot number    slot number
function ForPlayer:delete(kind, slot)
	local item = self.player:get_inventory():get_stack(kind, slot)
	self.player:get_inventory():set_stack(kind, slot, nil)
	self.event.trigger(self.player, kind, "delete", slot, item) -- TODO use Event.DELETE constant
end


return ForPlayer
