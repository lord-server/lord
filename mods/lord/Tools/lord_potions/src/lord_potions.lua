local api    = require('lord_potions.api')
local config = require('lord_potions.config')


potions = {} -- luacheck: ignore unused global variable potions

local function register_api()
	_G.potions = api
end

local function register_potions()
	for _, potion_group in pairs(config) do
		api.register_potion_group(potion_group)
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		local environment = minetest.settings:get('environment')
		if not environment or environment == 'production' then
			return
		end
		register_api()
		register_potions()
	end,
}
