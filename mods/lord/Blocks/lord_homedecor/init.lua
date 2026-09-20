-- Minetest 0.4 mod: lord_homedecor
-- See README.txt for licensing and other information.

local S       = core.get_mod_translator()
local modpath = core.get_modpath("lord_homedecor")

-- Definitions made by this mod that other mods can use too
lord_homedecor = {}

lord_homedecor = {
	modpath = modpath,

	-- infinite stacks
	expect_infinite_stacks = function(player)
		return core.is_creative_enabled(player)
	end
}


lrfurn = {}
screwdriver = screwdriver or {}

lrfurn.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

lrfurn.colors = { -- mod changed to use colorize feature of minetest engine (cg72)
	{ "black",       "#000000:230" },
	{ "brown",       "#251005:225" },
	{ "blue",        "#0000d0:225" },
	{ "cyan",        "#009fa7:250" },
	{ "dark_grey",   "#101010:175" },
	{ "dark_green",  "#007000:230" },
	{ "green",       "#00d000:250" },
	{ "grey",        "#101010:100" },
	{ "magenta",     "#e0048b:250" },
	{ "orange",      "#ff6600:240" },
	{ "pink",        "#ff90b0:250" },
	{ "red",         "#800000:240" },
	{ "violet",      "#9000d0:250" },
	{ "white",       "#000000:000" },
	{ "yellow",      "#dde000:240" }
}

--- @param pos               Position
--- @param placer            Player
--- @param protected_message string message for the case when the spot is protected
--- @return boolean true if the spot is free (`air`) and not protected
local function is_free_and_unprotected(pos, placer, protected_message)
	local node = core.get_node(pos)
	if node and node.name ~= 'air' then
		return false
	end
	if core.is_protected(pos, placer:get_player_name()) then
		core.chat_send_player(placer:get_player_name(), protected_message)

		return false
	end

	return true
end

function lrfurn.check_forward(pos, fdir, long, placer)
	if not fdir or fdir > 3 then fdir = 0 end

	local fwd  = lrfurn.fdir_to_fwd[fdir+1]
	local pos2 = { x = pos.x + fwd[1],     y=pos.y, z = pos.z + fwd[2]     }
	local pos3 = { x = pos.x + fwd[1] * 2, y=pos.y, z = pos.z + fwd[2] * 2 }

	local message2 = long
		and S('Someone else owns the spot where the middle or far end goes!')
		or  S('Someone else owns the spot where other end goes!')
	if not is_free_and_unprotected(pos2, placer, message2) then
		return false
	end

	return not long or is_free_and_unprotected(pos3, placer, S('Someone else owns the spot where the other end goes!'))
end

--- @return boolean|nil true if the `on_rightclick` of the pointed node was called
local function delegate_to_on_rightclick(itemstack, placer, pointed_thing, unode, undef)
	if undef and undef.on_rightclick then
		undef.on_rightclick(pointed_thing.under, unode, placer, itemstack, pointed_thing)

		return true
	end
end

--- @param def table|nil
local function is_buildable(def)
	return def and def.buildable_to
end

function lord_homedecor.find_ceiling(itemstack, placer, pointed_thing)
	-- most of this is copied from the rotate-and-place function in builtin
	local unode = core.get_node_or_nil(pointed_thing.under)
	if not unode then
		return
	end
	local undef = core.registered_nodes[unode.name]
	if delegate_to_on_rightclick(itemstack, placer, pointed_thing, unode, undef) then
		return
	end

	local above = pointed_thing.above
	local under = pointed_thing.under
	local isceiling = above.y < under.y
	local anode = core.get_node_or_nil(above)
	if not anode then
		return
	end
	local pos = pointed_thing.above
	local node = anode

	if is_buildable(undef) then
		pos = pointed_thing.under
		node = unode
	end

	if core.is_protected(pos, placer:get_player_name()) then
		core.record_protection_violation(pos, placer:get_player_name())
		return
	end

	if not is_buildable(core.registered_nodes[node.name]) then
		return
	end
	return isceiling, pos
end

-- Load files
dofile(core.get_modpath("lord_homedecor").."/building_blocks.lua")

-- load different handler subsystems
dofile(modpath.."/handlers/init.lua")

dofile(modpath.."/longsofas.lua")
dofile(modpath.."/sofas.lua")
dofile(modpath.."/armchairs.lua")
dofile(modpath.."/coffeetable.lua")
dofile(modpath.."/endtable.lua")
dofile(modpath.."/exterior.lua")
--dofile(modpath.."/roofing.lua")
dofile(modpath.."/furniture_medieval.lua")
dofile(modpath.."/furniture_recipes.lua")
dofile(modpath.."/shutters.lua")
dofile(modpath.."/lighting.lua")
dofile(modpath.."/misc-nodes.lua")
dofile(modpath.."/window_treatments.lua")
dofile(modpath.."/crafts.lua")
dofile(modpath.."/roofing.lua")
