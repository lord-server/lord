local config = require("lord_archery.config")

local function register_archery_items()
	for name, registration in pairs(config.bows) do
		archery.register_bow(name, registration)
	end
	for name, registration in pairs(config.crossbows) do
		archery.register_crossbow(name, registration)
	end
end

local function register_throwables()
	for name, registration in pairs(config.throwables) do
		archery.register_throwable(name, registration)
	end
end


return {
	init = function()
		register_archery_items()
		register_throwables()
	end,
}
