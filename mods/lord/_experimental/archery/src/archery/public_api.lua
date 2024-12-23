--local S_tt = minetest.get_translator("tt_base")

local registered_bows       = {}
local registered_crossbows  = {}
local registered_throwables = {}

--- @class archery.Definition
--- @field inventory_image  string  texture name without file format (`.png`)
--- @field description      string  item description shown on hovering on it in an inventory
--- @field groups           table   minetest item definition groups table
--- @field uses             number  number of shots available until the archery item breaks

--- @class archery.StageConf
--- @field charging_time  table  a numerical table starting from 0 containing charging times for each stage
--- @field stages         table  a numerical table starting from 0 containing stage names (itemstring)

--- @class archery.Registration
--- @field definition      archery.Definition        definition for creating the base archery item and stages
--- @field stage_conf      archery.StageConf         the StageConf table
--- @field projectile_reg  projectiles.Registration  the StageConf table

--- @param name string                itemstring "<mod>:<archery_item_name>"
--- @param reg  archery.Registration  archery item registration table
local function register_bow(name, reg)
	local def          = reg.definition
	local wield_scale  = { x = 2, y = 2, z = 0.75, }
	local stage_groups = table.merge({
		not_in_creative_inventory = 1,
		is_loaded = 1,
	}, def.groups)

	minetest.register_tool(name, {
		range             = def.range or 3,
		description       = def.description,
		wield_scale       = wield_scale,
		inventory_image   = def.inventory_image .. ".png",
		wield_image       = def.inventory_image .. ".png",
		groups            = def.groups,
		tool_capabilities = def.tool_capabilities,
		touch_interaction = {
			pointed_nothing = "short_dig_long_place",
			pointed_node    = "long_dig_short_place",
			pointed_object  = "short_dig_long_place",
		},
		_original_state   = name,
		_sound_on_release = def.sound_on_release,
		_used_projectiles = def.used_projectiles,
	})

	local stages = {}
	stages[0] = name

	for i = 1, 3 do
		local stage_name = name .. "_" .. i
		stages[i]        = stage_name
		minetest.register_tool(stage_name, {
			description       = def.description,
			range             = 0,
			wield_scale       = wield_scale,
			inventory_image   = def.inventory_image .. "_" .. i .. ".png",
			wield_image       = def.inventory_image .. "_" .. i .. ".png",
			groups            = stage_groups,
			tool_capabilities = def.tool_capabilities,
			touch_interaction = {
				pointed_nothing = "short_dig_long_place",
				pointed_node    = "long_dig_short_place",
				pointed_object  = "short_dig_long_place",
			},
			_original_state   = name,
			_sound_on_release = def.sound_on_release,
			_used_projectiles = def.used_projectiles,
		})
	end
	registered_bows[name] = {
		definition = def,
		stage_conf = {
			stages        = stages,
			charging_time = reg.stage_conf.charging_time or {
				[0] = 0,
				[1] = 0.5,
				[2] = 1,
				[3] = 1.5,
			},
		},
	}
end

--- @param name string                itemstring "<mod>:<archery_item_name>"
--- @param reg  archery.Registration  archery item registration table
local function register_crossbow(name, reg)
	local def         = reg.definition
	local wield_scale = { x = 2, y = 2, z = 0.75, }

	local stage_groups = table.merge({
		not_in_creative_inventory = 1,
		is_loaded = 1,
		allow_hold_abort = 1,
	}, def.groups)

	minetest.register_tool(name, {
		range             = def.range or 3,
		description       = def.description,
		wield_scale       = wield_scale,
		inventory_image   = def.inventory_image .. ".png",
		wield_image       = def.inventory_image .. ".png",
		groups            = table.merge({ allow_hold_abort = 1 }, def.groups),
		tool_capabilities = def.tool_capabilities,
		touch_interaction = {
			pointed_nothing = "short_dig_long_place",
			pointed_node    = "long_dig_short_place",
			pointed_object  = "short_dig_long_place",
		},
		_original_state   = name,
		_sound_on_release = def.sound_on_release,
		_used_projectiles = def.used_projectiles,
	})

	local stages = {}
	stages[0] = name
	local max_stage = 3

	for i = 1, max_stage do
		local stage_name = name .. "_" .. i
		stages[i]        = stage_name
		local stage_groups_temp = table.copy(stage_groups)
		if i == max_stage then
			stage_groups_temp["allow_hold_abort"] = nil
			stage_groups_temp["crossbow_charged"] = 1
		end

		minetest.register_tool(stage_name, {
			description       = def.description,
			range             = 0,
			wield_scale       = wield_scale,
			inventory_image   = def.inventory_image .. "_" .. i .. ".png",
			wield_image       = def.inventory_image .. "_" .. i .. ".png",
			groups            = stage_groups_temp,
			tool_capabilities = def.tool_capabilities,
			touch_interaction = {
				pointed_nothing = "short_dig_long_place",
				pointed_node    = "long_dig_short_place",
				pointed_object  = "short_dig_long_place",
			},
			_original_state   = name,
			_sound_on_release = def.sound_on_release,
			_used_projectiles = def.used_projectiles,
		})
	end

	registered_crossbows[name] = {
		definition = def,
		stage_conf = {
			stages        = stages,
			charging_time = reg.stage_conf.charging_time or {
				[0] = 0,
				[1] = 0.5,
				[2] = 1,
				[3] = 1.5,
			},
		},
	}
end

local function register_throwable(name, reg)
	local def          = reg.definition
	local wield_scale  = { x = 2, y = 2, z = 0.75, }

	minetest.register_tool(name, {
		range             = def.range or 3,
		description       = def.description,
		wield_scale       = def.wield_scale or wield_scale,
		inventory_image   = def.inventory_image .. ".png",
		wield_image       = def.inventory_image .. ".png",
		groups            = def.groups,
		tool_capabilities = def.tool_capabilities,
		touch_interaction = def.touch_interaction or {
			pointed_nothing = "short_dig_long_place",
			pointed_node    = "long_dig_short_place",
			pointed_object  = "short_dig_long_place",
		},
		_original_state   = name,
		_sound_on_release = def.sound_on_release,
		_used_projectiles = def.used_projectiles,
	})

	local stages = {}
	stages[0] = name

	for i = 1, 1 do
		stages[i] = name
	end

	projectiles.register_projectile(reg.projectile_reg.entity_name, reg.projectile_reg, true)

	registered_throwables[name] = {
		definition  = def,
		entity_name = reg.projectile_reg.entity_name,
		stage_conf  = {
			stages        = stages,
			charging_time = reg.stage_conf.charging_time or {
				[0] = 0,
				[1] = 0.5,
				[2] = 1.5,
			},
		},
	}
end

local function link_existing_throwable(name, reg)
	local stages = {}
	stages[0] = name

	for i = 1, 1 do
		stages[i] = name
	end

	projectiles.register_projectile(reg.projectile_reg.entity_name, reg.projectile_reg, true)

	registered_throwables[name] = {
		definition = minetest.registered_items[name],
		stage_conf = {
			stages        = stages,
			charging_time = reg.stage_conf.charging_time or {
				[0] = 0,
				[1] = 0.5,
				[2] = 1.5,
			},
		},
	}
end

return {
	register_bow            = register_bow,
	register_crossbow       = register_crossbow,
	register_throwable      = register_throwable,
	link_existing_throwable = link_existing_throwable,
	get_bows       = function() return registered_bows end,
	get_crossbows  = function() return registered_crossbows end,
	get_throwables = function() return registered_throwables end,
}
