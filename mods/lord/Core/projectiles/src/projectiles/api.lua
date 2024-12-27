local S_tt = minetest.get_translator("tt_base")

local registered_projectiles = {}
local entity = require("projectiles.entity")

--- @class projectiles.Registration
--- @field projectile_texture table           table of textures used for projectile entity
--- @field definition         ItemDefinition  definition of projectile craftitem
--- @field entity_name        string          itemstring <mod>:<name>; used to name the projectile entity
--- @field damage             number          damage base value of projectile that used to calculate resulting damage
--- @field speed              number          projectile speed multiplier that used to calculate the flight trajectory
--- @field type               string          a type of projectile

--- @param name               string                    itemstring "<mod>:<projectile_name>"
--- @param reg                projectiles.Registration  projectile registration table
--- @param not_register_item  boolean                   whether to register craftitem or not (false/nil = register)
local function register_projectile(name, reg, not_register_item)
	local def       = reg.definition
	reg.type        = reg.type
	reg.entity_name = reg.entity_name or name

	registered_projectiles[name] = reg

	entity.register_projectile_entity(reg.entity_name, reg.entity_reg)

	if not_register_item then
		return
	end

	minetest.register_craftitem(name, table.overwrite({
		_tt_help = S_tt("Damage: @1", reg.damage_tt)
	}, def))
end


return {
	register_projectile = register_projectile,
	get_projectiles     = function() return registered_projectiles end,
}
