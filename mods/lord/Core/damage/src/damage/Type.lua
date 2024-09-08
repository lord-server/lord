local assert, table_contains, pairs, typeof
    = assert, table.contains, pairs, type

local TypeEvent = require('damage.Type.Event')


--- @static
--- @class damage.Type
local Type = {
	--- @private
	--- @static
	--- @type string
	default = nil,
	--- @private
	--- @static
	--- @type string[]
	registered = {
		-- [1] = 'fleshy'
	}
}

--- @param name string
--- @return damage.Type
function Type.register(name)
	Type.registered[#Type.registered + 1] = name

	TypeEvent.Type[name]        = name
	TypeEvent.subscribers[name] = {}

	return Type
end

--- @return string|nil
function Type.get_default()
	return Type.default or Type.registered[1]
end

--- @param type string
--- @return damage.Type
function Type.set_default(type)
	assert(table_contains(Type.registered, type))
	Type.default = type

	return Type
end

--- @param damage_groups table<string,number>
--- @return string|nil
function Type.get_from_groups(damage_groups)
	for type, damage in pairs(damage_groups) do
		if table_contains(Type.registered, type) then
			return type
		end
	end

	return nil
end

--- @param reason PlayerHPChangeReason
--- @return string
function Type.detect(reason)
	local type = Type.get_default()
	assert(typeof(type) == 'string')

	if reason.node then
		local node_definition = minetest.registered_nodes[reason.node]

		local damage_groups = node_definition.damage_groups or (
			node_definition.tool_capabilities
				and (node_definition.tool_capabilities.damage_groups or {})
				or {}
		)

		type = Type.get_from_groups(damage_groups) or type
	end

	return type
end

--- @return string[]
function Type.get_registered()
	return Type.registered
end

setmetatable(Type, {
	--- @return fun(registered:string[]): (number, string)
	__pairs = function()
		return pairs(Type.registered)
	end
})


return Type
