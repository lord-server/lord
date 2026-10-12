dofile(core.get_modpath("lord_overwrites_mtg_carts").."/crafting.lua")
dofile(core.get_modpath("lord_overwrites_mtg_carts").."/placing.lua")

local S       = core.get_mod_translator()
local S_carts = core.get_translator('carts')
core.override_item('carts:cart', {
	description = S_carts('Cart'),
	_hint       = S('Sneak+Click to pick up'),
})
