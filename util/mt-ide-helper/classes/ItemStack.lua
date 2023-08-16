---@class ItemStack
ItemStack = {}

--- put some item or stack onto this stack, returns leftover ItemStack
function ItemStack:add_item(item) end

--- increases wear by amount if the item is a tool
---@param amount number
function ItemStack:add_wear(amount) end

--- removes all items from the stack, making it empty
function ItemStack:clear() end

--- returns number of items on the stack
---@return number
function ItemStack:get_count() end

--- returns true/false (success), clears item on failure
---@param count number
function ItemStack:set_count(count) end

--- returns the item definition table
function ItemStack:get_definition() end

--- returns get_stack_max() - get_count()
function ItemStack:get_free_space() end

--- @return MetaDataRef
function ItemStack:get_meta() end

--- returns a string, for compatibility reasons this is equal to get_meta():get_string("")
---@deprecated
function ItemStack:get_metadata() end

--- returns item name (e.g. "default:stone")
---@return string
function ItemStack:get_name() end

--- returns true/false (success), clears item on failure
---@param item_name string
function ItemStack:set_name(item_name) end

--- returns the maximum size of the stack (depends on the item)
function ItemStack:get_stack_max() end

--- returns the digging properties of the item, or those of the hand if none are defined for this item type
function ItemStack:get_tool_capabilities() end

--- returns tool wear (0-65535), 0 for non-tools
function ItemStack:get_wear() end

--- returns true/false (success), clears item on failure
function ItemStack:set_wear(wear) end

--- return true if stack is empty
---@return boolean
function ItemStack:is_empty() end

--- returns true if the item name refers to a defined item type
---@return boolean
function ItemStack:is_known() end

--- returns true if item or stack can be fully added to this one
function ItemStack:item_fits(item) end

--- copy (don't remove) up to n items from this stack; returns copied ItemStack; if n is omitted, n=1 is used
function ItemStack:peek_item(n) end

--- replace the contents of this stack (item can also be an itemstring or table)
function ItemStack:replace(item) end

--- take (and remove) up to n items from this stack; returns taken ItemStack; if n is omitted, n=1 is used
function ItemStack:take_item(n) end

--- returns the stack in itemstring form
function ItemStack:to_string() end

--- returns the stack in Lua table form
---@return table
function ItemStack:to_table() end
