--local S_tt = minetest.get_translator("tt_base")

require("lord_archery.behavior.mechanics_throwing")

local registered_bows      = {}
local registered_crossbows = {}

--- @class archery.BowDefinition
--- @field inventory_image string  texture name without file format (`.png`)
--- @field description     string  item description shown on hovering on it in an inventory
--- @field groups          table   minetest item definition groups table
--- @field uses            number  number of shots available until the bow breaks

--- @class archery.BowStages
--- @field charging_time table  a numerical table starting from 0 containing charging times for each stage
--- @field stages        table  a numerical table starting from 0 containing stage names (itemstring)

--- @class archery.BowRegistration
--- @field definition archery.BowDefinition  definition for creating the base bow and stages
--- @field bow_stages archery.BowStages      the stages and time taken to charge configuration

--- @param name string                   itemstring "<mod>:<bow_name>"
--- @param reg  archery.BowRegistration  bow registration table
local function register_bow(name, reg)
	local def          = reg.definition
	local wield_scale  = { x = 2, y = 2, z = 0.75, }
	local stage_groups = table.merge({ not_in_creative_inventory = 1, }, def.groups)

	minetest.register_tool(name, {
		range             = 3,
		description       = def.description,
		wield_scale       = wield_scale,
		inventory_image   = def.inventory_image .. ".png",
		wield_image       = def.inventory_image .. ".png",
		groups            = def.groups,
		tool_capabilities = def.tool_capabilities,
		_sound_on_release = def.sound_on_release,
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
			_sound_on_release = def.sound_on_release,
		})
	end
	registered_bows[name] = {
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

local function register_crossbow(name, reg)
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
	registered_crossbows[name] = {
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

return {
	register_bow      = register_bow,
	register_crossbow = register_crossbow,
	get_bows          = function() return registered_bows end,
	get_crossbows     = function() return registered_crossbows end,
}
