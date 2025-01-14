local Algorithm = require('mountgen.Algorithm')
local ConeAlgo  = require('mountgen.algorithm.Cone')


--- @class mountgen.config.FieldDefinition
--- @field name        string name of the config field
--- @field type        string type of the config field; one of `mountgen.config.FieldType.<CONST>`
--- @field label       string human-readable name: label in interfaces
--- @field description string description for user in interfaces


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
	top_cover       = minetest.get_modpath('lord_ground')
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
	--- @type table|any[]
	DEFAULTS = CONFIG_DEFAULTS,
	--- @type mountgen.config.FieldDefinition[]
	FIELDS   = {
		-- TODO #1932
	},
}

--- @param algorithm mountgen.AlgorithmInterface
function Config.get_defaults(algorithm)
	algorithm = algorithm or Algorithm.get(CONFIG_DEFAULTS.algorithm)

	return table.merge(Config.DEFAULTS, algorithm.get_config_defaults())
end


return Config
