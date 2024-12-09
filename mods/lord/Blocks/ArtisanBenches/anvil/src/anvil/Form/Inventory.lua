local InventoryCallbacks = require('anvil.Form.InventoryCallbacks')


--- @class anvil.Form.Inventory: base_classes.DetachedInventory
local Inventory = base_classes.DetachedInventory:extended({
	--- @type string
	player_name = nil,
	--- @type string
	id          = nil,
	--- @type DetachedInventoryCallbacksDef
	callbacks   = InventoryCallbacks,
	--- @type string[]
	lists_for_return = { 'craft' }
})

--- @protected
--- @return string
function Inventory:generate_id()
	return self.player_name .. '_anvil'
end

--- @protected
--- @param detached InvRef
function Inventory:build(detached)
	detached:set_size('craft', 3 * 3)
	detached:set_size('craft_result', 1)
end

function Inventory:close()
	self:get_detached():set_list('craft_result', {})
	self:return_forgotten()
end


return Inventory
