local S = minetest.get_translator("lord_wooden_stuff")


local register_stick = require("lord_wooden_stuff.register.stick")

--- Contains wooden stuff type to function accordance
---@type table<string,fun()>
local stuff2func = {
	["doors"]     = require("lord_wooden_stuff.register.doors"),
	["hatch"]     = require("lord_wooden_stuff.register.hatch"),
	["Rhatch"]    = require("lord_wooden_stuff.register.reinforced_hatch"),
	["fence"]     = require("lord_wooden_stuff.register.fence"),
	["ladder"]    = require("lord_wooden_stuff.register.ladder"),
	["stanchion"] = require("lord_wooden_stuff.register.stanchion"),
	["table"]     = require("lord_wooden_stuff.register.table"),
	["chair"]     = require("lord_wooden_stuff.register.chair"),
}

--- Registers doors, hatches, fences (with reinforced ones), sticks, ladders, stanchions, tables, chairs of given wood
--- with some exceptions.
---@param wood string
---@param def LordWoodenStuffDefinition
---@param exceptions string[] @list with stuff types which will be not registered
local function register_wooden_stuff(wood, def, exceptions)
	local node_groups     = table.copy(minetest.registered_nodes[def.wood_name].groups)
	node_groups["wood"]   = nil
	node_groups["wooden"] = 1

	local stick = "default:stick"
	if not table.contains(exceptions, "stick") then
		stick = register_stick(wood, def)
	end

	for stuff_type, register in pairs(stuff2func) do
		if not table.contains(exceptions, stuff_type) then
			register(wood, def, node_groups, stick)
		end
	end
end


return { register_wooden_stuff = register_wooden_stuff }
