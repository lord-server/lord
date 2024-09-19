

--- @class base_classes.DetachedInventory
local DetachedInventory = {
	--- @protected
	--- @type string
	player_name = nil,
	--- @protected
	--- @type string
	id = nil,
	--- @overridable
	--- @static
	--- @protected
	--- @type DetachedInventoryCallbacksDef
	callbacks = nil,
}

--- @protected
--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @param child_class GenericDetachedInventory
--- @return GenericDetachedInventory
function DetachedInventory:extended(child_class)
	return setmetatable(child_class or {}, { __index = self })
end

--- Constructor
--- @public
--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @param player Player
--- @return GenericDetachedInventory
function DetachedInventory:new(player)
	local class = self
	self = {}

	self.player_name = player:get_player_name()

	return setmetatable(self, { __index = class })
end

--- @protected
--- @abstract
--- @return string
function DetachedInventory:generate_id()
	return error('You should override method `DetachedInventory:generate_id()` in your inventory class')
end

--- @protected
--- @abstract
--- @param detached InvRef
--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @return GenericDetachedInventory
function DetachedInventory:build(detached)
	return error('You should override method `DetachedInventory:build()` in your inventory class')
end

--- @protected
--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @return GenericDetachedInventory
function DetachedInventory:create()
	local detached = minetest.create_detached_inventory(self.id, self.callbacks, self.player_name)
	self:build(detached)

	return self
end

--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @return GenericDetachedInventory
function DetachedInventory:get_or_create()
	self.id = self:generate_id()
	local exists = minetest.get_inventory({ type = "detached", name = self.id })

	return exists and self or self:create()
end

--- @public
--- @return string
function DetachedInventory:get_id()
	return self.id or self:get_or_create().id
end


return DetachedInventory
