local Algorithm = require('mountgen.Algorithm')
local ConeAlgo  = require('mountgen.algorithm.Cone')
local FieldType = require('mountgen.config.FieldType')

local S = minetest.get_mod_translator()


--- @class mountgen.config.FieldDefinition
--- @field name        string            name of the config field
--- @field type        string            type of the config field; one of `mountgen.config.FieldType.<CONST>`
--- @field list        table|fun():table possible values if `type` is `FieldType.ONE_OF` or `fun` for lazy loading.
--- @field label       string            human-readable name: label in interfaces
--- @field description string            description for user in interfaces

--- @class mountgen.config.GroupDefinition
--- @field label       string                            human-readable name of group: label in interfaces
--- @field definitions mountgen.config.FieldDefinition[] definitions of fields of group


--- @type string[]
local DEFAULT_MOD_DIRTS = {
	'default:dirt',
	'default:dirt_with_grass',
	'default:dirt_with_grass_footsteps',
	'default:dirt_with_dry_grass',
	'default:dirt_with_rainforest_litter',
	'default:dirt_with_coniferous_litter',
	'default:dirt_with_snow',
	'default:dry_dirt',
	'default:dry_dirt_with_dry_grass',
}

--- @return string[]
local function get_coverage_variants()
	--- @type string[]
	local coverage_nodes_list
	if minetest.global_exists('ground') and ground.dirt and ground.dirt.get_nodes then
		coverage_nodes_list = {}
		for node_name, node in pairs(ground.dirt.get_nodes()) do -- also contains dirts from `default`
			table.insert(coverage_nodes_list, node_name)
		end

		return coverage_nodes_list
	else -- `default` mod not in optional dependencies
		return DEFAULT_MOD_DIRTS
	end
end

--- @type table|any[]
local CONFIG_DEFAULTS = {
	algorithm       = ConeAlgo.NAME,
	foot_height     = 0,
	angle           = 60,

	--- --== Content ==-- ---
	-- Stone
	--stone_node      = 'default:stone', not used yet (hard-coded)

	-- Snow
	snow_line       = 50,
	snow_line_rand  = 4,

	-- Coverage
	coverage_node   = minetest.get_modpath('lord_ground')
		and 'lord_ground:dirt_lorien'
		or  'default:dirt'
	,
	grass_percent   = 10,
	flowers_line    = 35,
	flowers_percent = 10,
	tree_line       = 20,
	tree_promille   = 4,
}

--- @static
--- @class mountgen.Config
local Config = {
	--- @private
	--- Indicates whether the config was built. (Whether the lazy functions of fields definition was loaded.)
	_built   = false,
	--- @type table|any[]
	DEFAULTS = CONFIG_DEFAULTS,
	--- @protected
	FIELDS   = {
		-- Basic
		--- @type mountgen.config.FieldDefinition
		algorithm = {
			name        = 'algorithm',
			type        = FieldType.ONE_OF,
			list        = function() return Algorithm.get_names() end,
			label       = S('Algorithm'),
			description = S('Choose one of methods of mountain generation.'),
		},
		--- @type mountgen.config.FieldDefinition
		foot_height = {
			name        = 'foot_height',
			type        = FieldType.NUMBER,
			label       = S('Foot height'),
			description = S('Altitude of mountain foot, where generation stops.'),
		},
		--- @type mountgen.config.FieldDefinition
		angle = {
			name        = 'angle',
			type        = FieldType.NUMBER,
			label       = S('Angle'),
			description = S('Angle between mountain foot and mountainside'),
		},
		-- Content
		--- @type mountgen.config.FieldDefinition
		snow_line = {
			name        = 'snow_line',
			type        = FieldType.NUMBER,
			label       = S('Snow line height'),
			description = S('Altitude above which the snow generated instead of grass-dirt.'),
		},
		--- @type mountgen.config.FieldDefinition
		coverage_node = {
			name        = 'coverage_node',
			type        = FieldType.ONE_OF,
			list        = get_coverage_variants(),
			label       = S('Coverage node'),
			description = S('Choose one of grass-dirt with which the mountain will be covered.'),
		},
	},
	--- @protected
	--- @type {label:string,fields:string[]}[]
	GROUPS   = {
		basic   = { label = S('Basic Options:'),   fields = { 'algorithm', 'foot_height', 'angle' } },
		content = { label = S('Content Options:'), fields = { 'snow_line', 'coverage_node' } },
	},
}

--- @param algorithm mountgen.AlgorithmInterface
function Config.get_defaults(algorithm)
	algorithm = algorithm or Algorithm.get(CONFIG_DEFAULTS.algorithm)

	return table.merge(Config.DEFAULTS, algorithm.get_config_defaults())
end

--- Just fill `Config.FIELDS.*.list` by run `def.list()` if it was a function for lazy loading
--- @private
--- @return mountgen.Config
function Config.build()
	if not Config._built then
		table.map(Config.FIELDS, function(def, key)
			if def.list and type(def.list) == 'function' then
				def.list = def.list()
			end
			return def
		end)
		Config._built = true
	end

	return Config
end

--- @param field_name string
--- @return mountgen.config.FieldDefinition
function Config.get_definition(field_name)
	return Config.build().FIELDS[field_name]
end

--- @param name string
--- @return mountgen.config.GroupDefinition
function Config.get_group(name)
	Config.build()

	--- @type mountgen.config.GroupDefinition
	local group = {
		label       = Config.GROUPS[name].label,
		definitions = table.only(Config.FIELDS, Config.GROUPS[name].fields)
	}

	return group
end


return Config
