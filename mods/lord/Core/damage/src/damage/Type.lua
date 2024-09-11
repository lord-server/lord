local assert, table_contains, table_insert, setmetatable, typeof
    = assert, table.contains, table.insert, setmetatable, type

local TypeEvent    = require('damage.Type.Event')
local TypeResolver = require('damage.Type.Resolver')


--- @alias damage.Type.Modifier fun(player:Player,hp_change:number,reason:PlayerHPChangeReason):number,boolean|nil

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
	},
	--- @private
	--- @static
	--- @type table<string,damage.Type.Modifier[]>
	modifiers = {
		-- fleshy = { function(), function(), ... }
	},

	--- @type string
	name = nil,
}

TypeResolver.init(Type.registered)

--- @param name string
--- @return damage.Type
function Type:of(name)
	assert(table_contains(self.registered, name))
	local class = self

	self = {}
	self.name = name

	return setmetatable(self, { __index = class })
end

--- @static
--- @param name string
--- @return damage.Type
function Type.register(name)
	Type.registered[#Type.registered + 1] = name
	Type.modifiers[name] = {}

	TypeEvent.Type[name]        = name
	TypeEvent.subscribers[name] = {}

	return Type
end

--- @static
--- @return string|nil
function Type.get_default()
	return Type.default or Type.registered[1]
end

--- @static
--- @param type string
--- @return damage.Type
function Type.set_default(type)
	assert(table_contains(Type.registered, type))
	Type.default = type

	return Type
end

--- @static
--- @param damage_groups table<string,number>
--- @return string|nil
function Type.get_from_groups(damage_groups)
	return TypeResolver.by_damage_groups(damage_groups)
end

--- @static
--- @param definition ItemDefinition
--- @return string|nil
function Type.get_by_definition(definition)
	return TypeResolver.by_definition(definition)
end

--- @static
--- @param reason PlayerHPChangeReason
--- @return string
function Type.detect(reason)
	local default_type = Type.get_default()
	assert(typeof(default_type) == 'string')

	return TypeResolver.by_reason(reason) or default_type
end

--- @static
--- @return string[]
function Type.get_registered()
	return Type.registered
end

--- @param modifier damage.Type.Modifier
--- @return damage.Type
function Type:add_modifier(modifier)
	table_insert(self.modifiers[self.name], modifier)

	return self
end

--- @param player    Player
--- @param hp_change number
--- @param reason    PlayerHPChangeReason
--- @return number
function Type:modify_hp(player, hp_change, reason)
	local stop_propagation
	for _, modifier in pairs(self.modifiers[self.name]) do
		hp_change, stop_propagation = modifier(player, hp_change, reason)
		if stop_propagation then
			break
		end
	end

	return hp_change
end


return Type
