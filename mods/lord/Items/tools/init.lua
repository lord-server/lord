core.mod(function(mod)

	-- Load tables
	local tools = {
		pick      = require('picks'),
		shovel    = require('shovels'),
		axe       = require('axes'),
		sword     = require('swords'),
		battleaxe = require('battleaxes'),
		warhammer = require('warhammers'),
		spear     = require('spears'),
		dagger    = require('daggers'),
		racial    = require('racial'),
		special   = require('special'),
	}

	-- Source materials
	tools.sources = {
		wood    = 'group:wood',
		stone   = 'group:stone',
		steel   = 'default:steel_ingot',
		bronze  = 'default:bronze_ingot',
		copper  = 'default:copper_ingot',
		tin     = 'lottores:tin_ingot',
		silver  = 'lottores:silver_ingot',
		gold    = 'default:gold_ingot',
		galvorn = 'lottores:galvorn_ingot',
		mithril = 'lottores:mithril_ingot',
	}

	-- A special item - the hand
	core.register_item(':', {
		type              = 'none',
		wield_image       = 'wieldhand.png',
		wield_scale       = { x = 1, y = 1, z = 2.5 },
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level      = 0,
			groupcaps           = {
				crumbly                 = { times = { [2] = 3.00, [3] = 0.70 }, uses = 0, maxlevel = 1 },
				snappy                  = { times = { [3] = 0.40 }, uses = 0, maxlevel = 1 },
				oddly_breakable_by_hand = { times = { [1] = 3.50, [2] = 2.00, [3] = 0.70 }, uses = 0 }
			},
			damage_groups       = { fleshy = 1 },
		}
	})

	--- LG-2263: geometric progression for `mineable.times`.
	--- @param base     number  @ `times[1]`, time on the easiest ore tier for this pick
	--- @param max_tier integer @ highest ore tier this pick can mine
	--- @return table<integer, number>
	local function mineable_times(base, max_tier)
		local times = {}
		for tier = 1, max_tier do
			times[tier] = base * 1.5 ^ (tier - 1)
		end

		return times
	end

	--- Build a tool_capabilities groupcap table from an item definition
	--- @param item_def ItemDefinition
	--- @param cap      string         name of the capability to get from the item_def (e.g. "cracky", "choppy", etc.)
	local function get_capability(item_def, cap)
		if item_def[cap] == nil then
			return nil
		end
		local caps = {
			times    = item_def[cap].times,
			uses     = item_def[cap].uses,
			maxlevel = item_def[cap].maxlevel,
			maxwear  = item_def[cap].maxwear,
		}
		-- LG-2263: get `uses` from `_durability` when not set explicitly.
		--   In engine: `real_uses = uses * 3^leveldiff`, where
		--   `leveldiff = cap.maxlevel - node.level`.
		--   We do not know the node level at this time,
		--   but for `mineable` nodes we have `node.level = 0` and `leveldiff = cap.maxlevel`,
		--   so we can use:
		--     `uses = _durability / 3^maxlevel`.
		if caps.uses == nil and item_def._durability and caps.maxlevel then
			caps.uses = item_def._durability / 3 ^ caps.maxlevel
		end

		-- LG-2263: get `times` from `_speed`/`_tier` when not set explicitly.
		if caps.times == nil and item_def._speed and item_def._tier then
			caps.times = mineable_times(item_def._speed, item_def._tier)
		end

		return caps
	end

	local function register_tool(type, material, item_def)
		core.register_tool('tools:' .. type .. '_' .. material, {
			description       = item_def.description,
			inventory_image   = 'tools_' .. type .. '_' .. material .. '.png' ..
				(item_def.image_transform or ''),
			wield_image       = 'tools_' .. type .. '_' .. material .. '.png' ..
				(item_def.wield_image_transform or ''),
			range             = item_def.range,
			_rank             = item_def._rank,
			_durability       = item_def._durability,
			_tier             = item_def._tier,
			_speed            = item_def._speed,
			tool_capabilities = {
				full_punch_interval = item_def.full_punch_interval,
				max_drop_level      = item_def.max_drop_level,
				groupcaps           = {
					cracky   = get_capability(item_def, 'cracky'),
					choppy   = get_capability(item_def, 'choppy'),
					snappy   = get_capability(item_def, 'snappy'),
					crumbly  = get_capability(item_def, 'crumbly'),
					mineable = get_capability(item_def, 'mineable'),
				},
				damage_groups       = item_def.damage_groups,
			},
			groups            = item_def.groups,
		})
	end

	local function register_craft(type, material)
		if tools.sources[material] == nil then
			mod.logger.error('Cannot find source material for the craft recipe (output=\'%s\')', material)
		end
		for _, r in pairs(tools[type].get_recipes(tools.sources[material])) do
			core.register_craft({
				output = 'tools:' .. type .. '_' .. material,
				recipe = r
			})
		end
	end

	local tool_types = {
		'pick', 'shovel', 'axe', 'sword', 'battleaxe', 'warhammer', 'spear', 'dagger'
	}

	for _, tool_type in ipairs(tool_types) do
		for material, _ in pairs(tools[tool_type]) do
			local item_def = tools[tool_type][material]
			if type(item_def) == 'table' then
				register_tool(tool_type, material, item_def)
				register_craft(tool_type, material)
			end
		end
	end

	dofile(core.get_modpath('tools') .. '/aliases.lua')
end)

