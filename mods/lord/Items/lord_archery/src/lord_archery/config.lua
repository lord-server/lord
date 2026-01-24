local config_bows       = require("lord_archery.config.bows")
local config_crossbows  = require("lord_archery.config.crossbows")
local config_throwables = require("lord_archery.config.throwables")
require("lord_archery.config.crafts")

return {
	bows       = config_bows,
	crossbows  = config_crossbows,
	throwables = config_throwables,
}
