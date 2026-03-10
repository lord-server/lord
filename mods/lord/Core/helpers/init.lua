local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. '/src/' .. name:gsub('%.', '/') .. '.lua') end

Voxrame = Voxrame or {}
--- @module 'Voxrame.map'
Voxrame.helpers = 'loaded'

require('types')
require('term')
require('lua_ext.global')
require('lua_ext.table')
require('lua_ext.string')
require('lua_ext.math')
require('lua_ext.io')
require('lua_ext.os')
require('lua_ext.debug')


require = old_require
