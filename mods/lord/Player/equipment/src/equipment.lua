local Event     = require("equipment.Event")
local ForPlayer = require("equipment.ForPlayer")

ForPlayer.event = Event

--- @return string
function __FUNC__(depth) return debug.getinfo(2 + (depth or 0), 'n').name end


--- @param kind          string|fun(player:Player,kind:string,event:string,slot:number,item:ItemStack)
--- @param callback      fun(player:Player,kind:string,event:string,slot:number,item:ItemStack)|nil
--- @param function_name string
--- @return string, fun(player:Player,kind:string,event:string,slot:number,item:ItemStack)
local function assertion(kind, callback, function_name)
	if callback == nil then
		assert(
			type(kind) == "function",
			"`equipment."..function_name.."()` bad argument: If #2 argument not passed, #1 argument must be callback function"
		)
		callback = kind
		kind     = "*any*"
	else
		assert(type(kind) == "string")
		assert(type(callback) == "function")
	end

	return kind, callback
end

--- @param event    string
--- @param kind     string|fun(player:Player,kind:string,event:string,slot:number,item:ItemStack)
--- @param callback fun(player:Player,kind:string,event:string,slot:number,item:ItemStack)|nil
local function on(event, kind, callback)
	kind, callback = assertion(kind, callback, __FUNC__(1))
	Event.subscribe(kind, event, callback)
end

equipment = {}
local function register_api()
	equipment = {
		--- @param player Player
		for_player = function(player)
			return ForPlayer:new(player)
		end,

		--- @param kind     string|fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)
		--- @param callback fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)|nil
		on_change = function(kind, callback)
			on("change", kind, callback)
		end,

		--- @param kind     string|fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)
		--- @param callback fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)|nil
		on_set = function(kind, callback)
			on("set", kind, callback)
		end,

		--- @param kind     string|fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)
		--- @param callback fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)|nil
		on_delete = function(kind, callback)
			on("delete", kind, callback)
		end,
	}
end

return {
	init = function()
		register_api()
	end
}
