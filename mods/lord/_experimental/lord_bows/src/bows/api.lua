require("bows.behavior.mechanics_throwing")
local entity_projectiles = require("bows.behavior.entity_projectiles")

local bows = {
	registered_bows        = {},
	registered_projectiles = {},
}


--- @param name string  itemstring "<mod>:<bow_name>"
--- @param reg  table   table {definition = {<item settings>}, bow_stages = {charging_time = {[0] = <seconds> ...}}}
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


--- @param name string  itemstring "<mod>:<projectile_name>"
--- @param reg  table   table with fields `definition`, `damage`, `speed`, `entity_name`, `projectile_texture`
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
