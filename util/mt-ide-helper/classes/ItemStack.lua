--- @diagnostic disable: missing-return


--- @class ItemStack
ItemStack = {}

--- @class ItemStackTable: table
--- @field name     string
--- @field count    number
--- @field wear     number
--- @field metadata string

--- @alias ItemStackString string

--- Put some item or stack onto this stack, returns leftover ItemStack
--- @param item ItemStack|ItemStackString|ItemStackTable
--- @return self
function ItemStack:add_item(item) end

--- Increases wear by amount if the item is a tool, otherwise does nothing.
--- Wear is only added if the item is a tool. Adding wear might destroy the item.
--- @param amount number Valid amount range is [0,65536]
--- @return boolean Returns true if the item is (or was) a tool.
function ItemStack:add_wear(amount) end

--- Removes all items from the stack, making it empty
--- @return boolean it seams that it always return `true`
function ItemStack:clear() end

--- Returns number of items on the stack
--- @return number
function ItemStack:get_count() end

--- Returns true/false (success), clears item on failure
--- @param count number count > 0 && count <= 65535  -- or clears
--- @return boolean
function ItemStack:set_count(count) end

--- @return ItemDefinition returns the item definition table
function ItemStack:get_definition() end

--- Returns get_stack_max() - get_count()
--- @return number
function ItemStack:get_free_space() end

--- @return MetaDataRef
function ItemStack:get_meta() end

--- Returns a string, for compatibility reasons this is equal to get_meta():get_string("")
--- @deprecated
function ItemStack:get_metadata() end

--- Returns item name (e.g. "default:stone")
--- @return string
function ItemStack:get_name() end

--- Returns true/false (success), clears item on failure
--- @param item_name string
--- @return boolean
function ItemStack:set_name(item_name) end

--- Returns the maximum size of the stack (depends on the item)
--- @return number
function ItemStack:get_stack_max() end

--- Returns the digging properties of the item, or those of the hand if none are defined for this item type
--- @return table
function ItemStack:get_tool_capabilities() end

--- Returns tool wear (0-65535), 0 for non-tools
--- @return number
function ItemStack:get_wear() end

--- Returns true/false (success), clears item on failure
--- @param wear number wear <= 65535, otherwise clears
--- @return boolean
function ItemStack:set_wear(wear) end

--- Return true if stack is empty
--- @return boolean
function ItemStack:is_empty() end

--- Returns true if the item name refers to a defined item type
--- @return boolean
function ItemStack:is_known() end

--- Returns true if item or stack can be fully added to this one
--- @param item ItemStack|ItemStackString|ItemStackTable
--- @return boolean
function ItemStack:item_fits(item) end

--- Copy (don't remove) up to n items from this stack; returns copied ItemStack; if n is omitted, n=1 is used
--- @param count number
--- @return ItemStack
function ItemStack:peek_item(count) end

--- Replace the contents of this stack (item can also be an itemstring or table)
--- @param item ItemStack|ItemStackString|ItemStackTable
--- @return boolean seams always `true`
function ItemStack:replace(item) end

--- Take (and remove) up to n items from this stack; returns taken ItemStack; if n is omitted, n=1 is used
--- @param count number
--- @return ItemStack
function ItemStack:take_item(count) end

--- Returns the stack in itemstring form
--- @return string
function ItemStack:to_string() end

--- Returns the stack in Lua table form or `nil` if empty.
--- @return table|nil
function ItemStack:to_table() end
