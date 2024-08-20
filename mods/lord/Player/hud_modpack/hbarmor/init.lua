if not minetest.settings:get_bool("enable_damage", false) then
	return
end


local S = minetest.get_translator("hb.armor")
local N = function(s) return s end


if (not armor) or (not armor.def) then
	minetest.log("error", "[hbarmor] Outdated lottarmor version. Please update your version of lottarmor!")
end

local hbarmor       = {
	--- HUD statbar values
	armor         = {},
	--- Stores if player's HUD bar has been initialized so far.
	player_active = {},
	--- Time difference in seconds between updates to the HUD armor bar.
	--- Increase this number for slow servers.
	tick          = math.limit(
		tonumber(minetest.settings:get("hbarmor_tick")) or 0.2,
		0.2,
		4
	),
	--- If true, the armor bar is hidden when the player does not wear any armor
	autohide      = minetest.settings:get_bool("hbarmor_autohide", true),
}

--- @param player_name string
--- @return boolean
local function must_hide(player_name, arm)
	return ((not armor.def[player_name].count or armor.def[player_name].count == 0) and arm == 0)
end

--- @param arm number
--- @return number
local function arm_printable(arm)
	return math.ceil(math.floor(arm + 0.5))
end

--- @param player Player
local function custom_hud(player)
	local name = player:get_player_name()

	local ret = hbarmor.get_armor(player)
	if ret == false then
		minetest.log("error", "[hbarmor] Call to hbarmor.get_armor in custom_hud returned with false!")
	end
	local arm = tonumber(hbarmor.armor[name])
	if not arm then arm = 0 end
	local hide
	if hbarmor.autohide then
		hide = must_hide(name, arm)
	else
		hide = false
	end
	hb.init_hudbar(player, "armor", arm_printable(arm), nil, hide)
end


hb.register_hudbar(
	"armor",
	0xFFFFFF,
	S("Armor"),
	{ icon = "hbarmor_icon.png", bgicon = "hbarmor_bgicon.png", bar = "hbarmor_bar.png" },
	0,
	100,
	hbarmor.autohide,
	N("@1: @2%"),
	{
		order      = { "label", "value" },
		textdomain = "hbarmor"
	},
	3
)

--- @param player Player
--- @return boolean
function hbarmor.get_armor(player)
	if not player or not armor.def then
		return false
	end
	local name = player:get_player_name()
	local def  = armor.def[name] or nil
	if def and def.state and def.count then
		hbarmor.set_armor(name, def.state, def.count)
	else
		return false
	end
	return true
end

--- @param player_name string
--- @param ges_state   number
--- @param items       number
function hbarmor.set_armor(player_name, ges_state, items)
	local max_items = 4
	if items == 5 then
		max_items = items
	end
	local max = max_items * 65535
	local lvl = (max - ges_state) / max
	if ges_state == 0 and items == 0 then
		lvl = 0
	end

	hbarmor.armor[player_name] = math.max(0, math.min(lvl * (items * (100 / max_items)), 100))
end

--- update hud elemtens if value has changed
--- @param player Player
local function update_hud(player)
	local name = player:get_player_name()
	--armor
	local arm  = tonumber(hbarmor.armor[name])
	if not arm then
		arm = 0
		hbarmor.armor[name] = 0
	end
	if hbarmor.autohide then
		-- hide armor bar completely when there is none
		if must_hide(name, arm) then
			hb.hide_hudbar(player, "armor")
		else
			hb.change_hudbar(player, "armor", arm_printable(arm))
			hb.unhide_hudbar(player, "armor")
		end
	else
		hb.change_hudbar(player, "armor", arm_printable(arm))
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	custom_hud(player)
	hbarmor.player_active[name] = true
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	hbarmor.player_active[name] = false
end)

minetest.foreach_player_every(hbarmor.tick, function(player, delta_time)
	local name = player:get_player_name()
	if hbarmor.player_active[name] == true then
		local ret = hbarmor.get_armor(player)
		if ret == false then
			minetest.log("error", "[hbarmor] Call to hbarmor.get_armor in globalstep returned with false!")
		end
		-- update all hud elements
		update_hud(player)
	end
end)
