
--- @class mountgen.AlgorithmInterface
--- @field NAME                string
--- @field get_description     nil|(fun():string|nil)
--- @field get_config_fields   fun():mountgen.config.FieldDefinition[]
--- @field get_config_defaults fun():table
--- @field build_height_map    fun(top_pos:Position, config:table):mountgen.generator.HeightMap,number,number

--- @static
--- @class mountgen.Algorithm
local Algorithm = {
	--- @private
	--- @type mountgen.AlgorithmInterface[]
	collection = {},
}

--- @static
--- @param algorithm mountgen.AlgorithmInterface
--- @return mountgen.Algorithm
function Algorithm.register(algorithm)
	assert(algorithm.NAME)
	assert(algorithm.build_height_map)
	assert(algorithm.get_config_fields)
	assert(algorithm.get_config_defaults)

	Algorithm.collection[algorithm.NAME] = algorithm

	return Algorithm
end

--- @param name string
--- @return mountgen.AlgorithmInterface
function Algorithm.get(name)
	return Algorithm.collection[name]
end

--- @return string[]
function Algorithm.get_names()
	return table.keys(Algorithm.collection)
end

--- @param name string
function Algorithm.is_valid_name(name)
	return Algorithm.collection[name] ~= nil
end


return Algorithm
