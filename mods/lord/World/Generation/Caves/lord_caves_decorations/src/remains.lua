
local config = require('remains.config')


return {
init = function()
	minetest.register_decoration(table.merge(config.deep_level_1, config.common))
	minetest.register_decoration(table.merge(config.deep_level_2, config.common))
	minetest.register_decoration(table.merge(config.deep_level_3, config.common))
--	minetest.register_decoration(table.merge(config.deep_level_4, config.common))
end
}
