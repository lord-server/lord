local api     = require('chests.api')
local default = require('chests.default')
local config  = require('chests.config')


chests = {} -- luacheck: ignore unused global variable chests

local function register_api()
	_G.chests = api
end

--- "Registers"(adds) existing chests from `default` to collection. It adds group `chest` for node.
local function add_existing_from_default()
	chests.add_existing('default:chest')
	chests.add_existing('default:chest_locked')
end

--- Registers our racial chests
local function register_racial()
	for name, chest in pairs(config.racial) do
		chests.racial.register(name, chest.title, chest.texture_type, chest.race, chest.craft)
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		default.overwrite_chest_formspec()
		add_existing_from_default()
		register_racial()
		-- todo: `register_lockpick()` - move from `lottblocks` #2049, into separate file
		-- todo: `register_metal()` - extract from `technic_chests`, unify registration. #20248
	end,
}
