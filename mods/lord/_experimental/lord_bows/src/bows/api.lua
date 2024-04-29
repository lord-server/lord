require("bows.behavior.mechanics_throwing")
local entity_projectiles = require("bows.behavior.entity_projectiles")

local bows = {
	--- @type table<string,bows.BowRegistration>
	registered_bows        = {},
	--- @type table<string,bows.ProjectileRegistration>
	registered_projectiles = {},
}


--- @class bows.BowDefinition
--- @field inventory_image string  texture name without file format (`.png`)
--- @field description     string  item description shown on hovering on it in an inventory
--- @field groups          table   minetest item definition groups table
--- @field uses            number  number of shots available until the bow breaks

--- @class bows.BowStages
--- @field charging_time table  a numerical table starting from 0 containing charging times for each stage
--- @field stages        table  a numerical table starting from 0 containing stage names (itemstring)

--- @class bows.BowRegistration
--- @field definition bows.BowDefinition  definition for creating the base bow and stages
--- @field bow_stages bows.BowStages      the stages and time taken to charge configuration

--- @param name string                itemstring "<mod>:<bow_name>"
--- @param reg  bows.BowRegistration  bow registration table
local function register_bow(name, reg)
	local def = reg.definition
	local wield_scale      = { x = 2, y = 2, z = 0.75, }

	local stage_groups = table.merge({ not_in_creative_inventory = 1, }, def.groups)

	minetest.register_tool(name, {
		range             = 3,
		description       = def.description,
		wield_scale       = wield_scale,
		inventory_image   = def.inventory_image .. ".png",
		wield_image       = def.inventory_image .. ".png",
		groups            = def.groups,
		tool_capabilities = def.tool_capabilities,
	})

	local stages = {}
	stages[0] = name

	for i = 1, 3 do
		local stage_name = name .. "_" .. i
		stages[i]    = stage_name
		minetest.register_tool(name .. "_" .. i, {
			description       = def.description,
			range             = 0,
			wield_scale       = wield_scale,
			inventory_image   = def.inventory_image .. "_" .. i .. ".png",
			wield_image       = def.inventory_image .. "_" .. i .. ".png",
			groups            = stage_groups,
			tool_capabilities = def.tool_capabilities,
		})
	end
	bows.registered_bows[name] = {
		definition = def,
		bow_stages = {
			stages        = stages,
			charging_time = reg.bow_stages.charging_time or {
				[0] = 0,
				[1] = 0.5,
				[2] = 1,
				[3] = 1.5,
			},
		},
	}
end


--- @class bows.ProjectileRegistration
--- @field projectile_texture table           table of textures used for projectile entity
--- @field definition         ItemDefinition  definition of projectile craftitem
--- @field entity_name        string          itemstring <mod>:<name>; used to name the projectile entity
--- @field damage             number          damage base value of projectile that used to calculate resulting damage
--- @field speed              number          projectile speed multiplier that used to calculate the flight trajectory
--- @field type               string          a type of projectile

--- @param name string                       itemstring "<mod>:<projectile_name>"
--- @param reg  bows.ProjectileRegistration  projectile registration table
local function register_projectile(name, reg)
	local def       = reg.definition
	reg.type        = reg.type or "arrow"
	reg.entity_name = reg.entity_name or name

	bows.registered_projectiles[name] = reg

	entity_projectiles.projectiles.register_projectile_type(reg.entity_name, name, {
		textures = reg.projectile_texture or {"projectile_arrow.png"},
		damage   = reg.damage or 10,
	})

	minetest.register_craftitem(name, def)
end

return {
	register_bow        = register_bow,
	register_projectile = register_projectile,
	get_bows            = function() return bows.registered_bows end,
	get_projectiles     = function() return bows.registered_projectiles end,
}
