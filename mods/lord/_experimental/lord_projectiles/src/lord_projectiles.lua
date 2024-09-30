local config = require("lord_projectiles.config")

local function register_projectiles()
	for name, registration in pairs(config.projectiles) do
		projectiles.register_projectile(name, registration)
	end
end

return {
	init = function()
		register_projectiles()
	end,
}
