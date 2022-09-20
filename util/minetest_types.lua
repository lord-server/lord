---@meta

--
-- Engine-provided globals
--

-- INIT = "game"

--
-- Classes
--

---@class Node
---@field name string
---@field param1 number
---@field param2 number
NodeTable = {}

---@class NodeMetaRef
NodeMetaRef = {}

---@param key string
---@return boolean | nil
function NodeMetaRef:contains(key) end

---@param key string
---@return string | nil
function NodeMetaRef:get(key) end

---@param key string
---@param value string
---@return number
function NodeMetaRef:set_string(key, value) end

---@param key string
---@return number
function NodeMetaRef:get_string(key) end

---@param key string
---@param value number
---@return number
function NodeMetaRef:set_int(key, value) end

---@param key string
---@return number
function NodeMetaRef:get_int(key) end

---@param key string
---@param value number
---@return number
function NodeMetaRef:set_float(key, value) end

---@param key string
---@return number
function NodeMetaRef:get_float(key) end

---@return table | nil
function NodeMetaRef:to_table() end

---@param value table | nil
---@return boolean
function NodeMetaRef:from_table(value) end

---@param other NodeMetaRef
---@return boolean
function NodeMetaRef:equals(other) end

---@class VoxelManip
VoxelManip = {}

---@class VoxelArea
VoxelArea = {}

---@param cuboid { MinEdge: any, MaxEdge: any }
function VoxelArea:new(cuboid) end

---@class Player
Player = {}

---@return string
function Player:get_player_name() end
function Player:get_inventory() end

---@class PseudoRandom
PseudoRandom = {}

---@class pointed_thing
---@field type string
pointed_thing = {}

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

--- returns a MetaDataRef
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

--- @class InvRef
InvRef = {}

--- return true if list is empty
--- @param list_name string
--- @return boolean
function InvRef:is_empty(list_name) end
--- get size of a list
--- @param list_name string
function InvRef:get_size(list_name) end
--- set size of a list, avoid e.g. , 7*3), use , 21) --7*3 instead to avoid confusion with formspec#list
--- @param list_name string
function InvRef:set_size(list_name, size) end
--- get width of a list
--- @param list_name string
function InvRef:get_width(list_name) end
--- set width of list; currently used for crafting
--- @param list_name string
function InvRef:set_width(list_name, width) end
--- get a copy of stack index i in list
--- @param list_name string
function InvRef:get_stack(list_name, i) end
--- copy stack to index i in list
--- @param list_name string
function InvRef:set_stack(list_name, i, stack) end
--- return full list
--- @param list_name string
function InvRef:get_list(list_name) end
--- set full list (size will not change)
--- @param list_name string
function InvRef:set_list(list_name, list) end
--- return full lists. Ex: {main={ItemStack,ItemStack...}, craft={..},hand={..}...}
function InvRef:get_lists() end
--- set full lists. Ex: {main={ItemStack,ItemStack...}, craft={..},hand={..}...}
--- @param lists table
function InvRef:set_lists(lists) end
--- add item somewhere in list, returns leftover ItemStack
--- @param list_name string
function InvRef:add_item(list_name, stack) end
--- returns true if the stack of items can be fully added to the list
--- @param list_name string
function InvRef:room_for_item(list_name, stack) end
--- returns true if the stack of items can be fully taken from the list
--- @param list_name string
function InvRef:contains_item(list_name, stack) end
--- take as many items as specified from the list, returns the items that were actually removed (as an ItemStack)
--- @param list_name string
function InvRef:remove_item(list_name, stack) end

--
-- Built-in libraries and extensions
--

---@generic T : table
---@param value `T`
---@return `T`
function table.copy(value) end

---@param obj any
---@param dumped table
---@return string
function dump(obj, dumped) end

--
-- Non-existent mods
--
unified_inventory = nil
dungeon_loot = nil
invisibility = nil

---
--- Implementation-specific Lua libraries
---

--- LuaJIT support library
--- https://luajit.org/ext_jit.html
jit = {}

-- Legacy function, should be removed after upgrading to 5.5
---@deprecated
function spawn_falling_node(pos, nodename) end
