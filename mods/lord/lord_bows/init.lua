-- lord bows
GRAVITY = 9.81

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/entities_projectiles.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/mechanics_throwing.lua")

local function table_concat(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end

local stage_groups = {not_in_creative_inventory = 1}

local function register_bow(name, def)
	local wield_scale      = {x = 2, y = 2, z = 0.75}

	local all_stage_groups = table_concat(stage_groups, def.groups)

	minetest.register_tool(name, {
		range             = 1,
		description       = def.desc,
		wield_scale       = wield_scale,
		inventory_image   = def.inventory_image .. ".png",
		wield_image       = def.inventory_image .. ".png",
		tool_capabilities = def.tool_capabilities,
		groups            = def.groups,
	})

	for i = 2, 4 do
		minetest.register_tool(name .. "_" .. i, {
			description       = def.desc,
			range             = 0,
			wield_scale       = wield_scale,
			inventory_image   = def.inventory_image .. "_" .. i .. ".png",
			wield_image       = def.inventory_image .. "_" .. i .. ".png",
			tool_capabilities = def.tool_capabilities,
			groups            = all_stage_groups,
		})
	end
end

register_bow("lord_bows:bow_wooden", {
	desc              = "Wooden bow",
	inventory_image   = "items_tools_bow_wooden", -- указывается без .png
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level      = 0,
		groupcaps           = {
			crumbly = {
				times    = {[1] = 3.00, [2] = 1.60, [3] = 0.60},
				uses     = 10,
				maxlevel = 1
			},
		},
		damage_groups       = {fleshy = 2},
	},
	groups            = {wooden = 1, bow = 1},
})

minetest.register_craftitem("lord_bows:arrow", {
	description     = "Arrow",
	inventory_image = "items_tools_arrow.png",
	groups          = {projectiles = 1, arrow = 1},
	stack_max       = 99
})
