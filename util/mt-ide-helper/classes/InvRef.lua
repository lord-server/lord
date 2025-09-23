--- @diagnostic disable: missing-return


--- @class InvRef
InvRef = {}

--- return true if list is empty
--- @param list_name string
--- @return boolean
function InvRef:is_empty(list_name) end
--- get size of a list
--- @param list_name string
--- @return number
function InvRef:get_size(list_name) end
--- set size of a list, avoid e.g. , 7*3), use , 21) --7*3 instead to avoid confusion with formspec#list
--- @param list_name string
--- @param size number
--- @return boolean returns `false` on error (e.g. invalid `listname` or `size`)
function InvRef:set_size(list_name, size) end
--- get width of a list
--- @param list_name string
--- @return number
function InvRef:get_width(list_name) end
--- set width of list; currently used for crafting
--- @param list_name string
--- @param width number
function InvRef:set_width(list_name, width) end
--- get a copy of stack index i in list
--- @param list_name string
--- @param i number
--- @return ItemStack
function InvRef:get_stack(list_name, i) end
--- copy stack to index i in list
--- @param list_name string
--- @param i         number
--- @param stack     ItemStack?
function InvRef:set_stack(list_name, i, stack) end
--- return full list
--- @param list_name string
--- @return ItemStack[]
function InvRef:get_list(list_name) end
--- set full list (size will not change)
--- @param list_name string
--- @param list ItemStack[]|table<number,ItemStack>
function InvRef:set_list(list_name, list) end
--- return full lists. Ex: {main={ItemStack,ItemStack...}, craft={..},hand={..}...}
--- @return ItemStack[][]|table<string,ItemStack[]>|table<string,table<number,ItemStack>>
function InvRef:get_lists() end
--- set full lists. Ex: {main={ItemStack,ItemStack...}, craft={..},hand={..}...}
--- @param lists ItemStack[][]|table<string,ItemStack[]>|table<string,table<number,ItemStack>>
function InvRef:set_lists(lists) end
--- add item somewhere in list, returns leftover ItemStack
--- @param list_name string
--- @param stack ItemStack
--- @return ItemStack leftover ItemStack
function InvRef:add_item(list_name, stack) end
--- returns true if the stack of items can be fully added to the list
--- @param list_name string
--- @param stack ItemStack
--- @return boolean
function InvRef:room_for_item(list_name, stack) end
--- returns true if the stack of items can be fully taken from the list
--- @overload fun(list_name:string, stack:ItemStack):boolean
--- @param list_name string
--- @param stack ItemStack
--- @param match_meta boolean If `match_meta` is false, only the items' names are compared (default: `false`).
--- @return boolean
function InvRef:contains_item(list_name, stack, match_meta) end
--- take as many items as specified from the list, returns the items that were actually removed (as an ItemStack).
--- note that any item metadata is ignored,
--- so attempting to remove a specific unique item this way will likely remove the wrong one -- to do that use
---  `set_stack` with an empty `ItemStack`.
--- @param list_name string
--- @param stack ItemStack
--- @return ItemStack
function InvRef:remove_item(list_name, stack) end
--- returns a location compatible to `minetest.get_inventory(location)`. e.g.
---    * `{type="player", name="celeron55"}`
---    * `{type="node", pos={x=, y=, z=}}`
---    * `{type="detached", name="creative"}`
--- returns `{type="undefined"}` in case location is not known.
--- @see minetest.get_inventory
--- @return table
function InvRef:get_location() end
