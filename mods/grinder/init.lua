local iEnv = minetest.request_insecure_environment()
if not iEnv then
	error('Please add `' .. minetest.get_current_modname() .. '` to secure.trusted_mods in minetest.conf')
end
local modpath     = minetest.get_modpath(minetest.get_current_modname())
iEnv.package.path = modpath .. "/src/?.lua;" .. iEnv.package.path
local old_require = require
require           = iEnv.require


require('grinder')


require = old_require
