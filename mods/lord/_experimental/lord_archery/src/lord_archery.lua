local config = require("lord_archery.config")

local function register_bows()
	for name, registration in pairs(config.bows) do
		archery.register_bow(name, registration)
	end
	for name, registration in pairs(config.crossbows) do
		archery.register_crossbow(name, registration)
	end
end

return {
	init = function()
		register_bows()
	end,
}
