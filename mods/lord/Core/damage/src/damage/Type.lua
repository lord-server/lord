local assert, table_contains, typeof
    = assert, table.contains, type

local TypeEvent    = require('damage.Type.Event')
local TypeResolver = require('damage.Type.Resolver')


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

TypeResolver.init(Type.registered)

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
	return TypeResolver.by_damage_groups(damage_groups)
end

--- @param definition ItemDefinition
--- @return string|nil
function Type.get_by_definition(definition)
	return TypeResolver.by_definition(definition)
end

--- @param reason PlayerHPChangeReason
--- @return string
function Type.detect(reason)
	local default_type = Type.get_default()
	assert(typeof(default_type) == 'string')

	return TypeResolver.by_reason(reason) or default_type
end

--- @return string[]
function Type.get_registered()
	return Type.registered
end


return Type
