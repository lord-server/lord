--- @class DetachedInventoryCallbacksDef
local DetachedInventoryCallbacksDef = {
	--- Called when a player wants to move items inside the inventory.
	--- Return value: number of items allowed to move.
	--- @type fun(inv:InvRef, from_list:string, from_index:number, to_list:string, to_index:number, count:number, player:Player):number
	allow_move = nil,

	--- Called when a player wants to put something into the inventory.
	--- Return value: number of items allowed to put.
	--- Return value -1: Allow and don't modify item count in inventory.
	--- @type fun(inv:InvRef, list_name:string, index:number, stack:ItemStack, player:Player):number
	allow_put = nil,

	--- Called when a player wants to take something out of the inventory.
	--- Return value: number of items allowed to take.
	--- Return value -1: Allow and don't modify item count in inventory.
	--- @type fun(inv:InvRef, list_name:string, index:number, stack:ItemStack, player:Player):number
	allow_take = nil,

	--- Called after the actual action has happened, according to what was allowed (see `allow_move()`).
	--- No return value.
	--- @type fun(inv:InvRef, from_list:string, from_index:number, to_list:string, to_index:number, count:number, player:Player):void
	on_move = nil,
	--- Called after the actual action has happened, according to what was allowed (see `allow_put()`).
	--- No return value.
	--- @type fun(inv:InvRef, list_name:string, index:number, stack:ItemStack, player:Player)
	on_put = nil,
	--- Called after the actual action has happened, according to what was allowed (see `allow_take()`).
	--- No return value.
	--- @type fun(inv:InvRef, list_name:string, index:number, stack:ItemStack, player:Player)
	on_take = nil,
}
