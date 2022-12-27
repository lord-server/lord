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
