local table_contains, pairs
	= table.contains, pairs


--- @static
--- @class damage.Type.Resolver
local Resolver = {
	--- @private
	--- @static
	--- @type string[]
	damage_types = nil
}

--- @param registered_damage_types string[]
--- @return damage.Type.Resolver
function Resolver.init(registered_damage_types)
	Resolver.damage_types = registered_damage_types

	return Resolver
end

--- @param damage_groups table<string,number>
--- @return string|nil
function Resolver.by_damage_groups(damage_groups)
	for type, damage in pairs(damage_groups) do
		if table_contains(Resolver.damage_types, type) then
			return type
		end
	end

	return nil
end

--- @param definition ItemDefinition
--- @return string|nil
function Resolver.by_definition(definition)
	local damage_groups = definition.damage_groups or (
		definition.tool_capabilities
			and (definition.tool_capabilities.damage_groups or {})
			or {}
	)

	return Resolver.by_damage_groups(damage_groups)
end

--- @param reason PlayerHPChangeReason
--- @return string|nil
function Resolver.by_reason(reason)

	if reason.type == 'node_damage' and reason.node then

		return Resolver.by_definition(minetest.registered_nodes[reason.node])

	elseif reason.type == 'punch' and reason.object then

		--- @type Player|Entity
		local player_or_mob = reason.object
		local item = player_or_mob:get_wielded_item()

		if player_or_mob:is_player() then                                -- `damage.Type` of:
			return Resolver.by_definition(item:get_definition())         -- Player wielded item
				or Resolver.by_definition(minetest.registered_nodes[""]) -- Player hand
		else
			return item:get_name() ~= ""                             -- `damage.Type` of:
				and Resolver.by_definition(item:get_definition())    -- Entity wielded item
				or  player_or_mob:get_luaentity().damage_type        -- Entity hand
		end

	end

	return nil
end


return Resolver
