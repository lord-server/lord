

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
	--- @overridable
	--- @static
	--- @protected
	--- @type string[]
	lists_for_return = {}
}

--- @public
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

--- @return InvRef
function DetachedInventory:get_detached()
	return minetest.get_inventory({ type = 'detached', name = self.id })
end

--- @protected
--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @return GenericDetachedInventory
function DetachedInventory:get_or_create()
	self.id = self:generate_id()
	local exists = self:get_detached()

	return exists and self or self:create()
end

--- @public
--- @return string
function DetachedInventory:get_id()
	return self.id or self:get_or_create().id
end

--- @public
function DetachedInventory:return_forgotten()
	if table.is_empty(self.lists_for_return) then  return  end

	local player_inventory = minetest.get_inventory({ type = 'player', name = self.player_name })
	local detached_inventory = self:get_detached()

	for _, list in pairs(self.lists_for_return) do
		for i, stack in pairs(detached_inventory:get_list(list)) do
			if not stack:is_empty() then
				detached_inventory:set_stack(list, i, nil)
				if player_inventory:room_for_item('main', stack) then
					player_inventory:add_item('main', stack)
				else
					local player = minetest.get_player_by_name(self.player_name)
					minetest.item_drop(stack, player, player:get_pos())
				end
			end
		end
	end
end


return DetachedInventory
