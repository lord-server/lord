if not minetest.settings:get_bool("enable_damage", false) then
	return
end


local S = minetest.get_translator("hb.armor")
local N = function(s) return s end


local hbarmor = {
	--- Time difference in seconds between updates to the HUD armor bar.
	--- Increase this number for slow servers.
	tick          = math.limit(
		tonumber(minetest.settings:get("hbarmor_tick")) or 0.2,
		0.2,
		4
	),
	--- If true, the armor bar is hidden when the player does not wear any armor
	auto_hide     = minetest.settings:get_bool("hbarmor_autohide", true),
}

hb.register_hudbar(
	"armor",
	0xFFFFFF,
	S("Armor"),
	{ icon = "hbarmor_icon.png", bgicon = "hbarmor_bgicon.png", bar = "hbarmor_bar.png" },
	0,
	100,
	hbarmor.auto_hide,
	N("@1: @2%"),
	{
		order      = { "label", "value" },
		textdomain = "hbarmor"
	},
	3
)

--- @param arm number
--- @return number
local function arm_printable(arm)
	return math.ceil(math.floor(arm + 0.5))
end

--- @param player Player
local function init_custom_hud_for(player)
	local arm  = defense.for_player(player).fleshy or 0
	local hide = hbarmor.auto_hide and arm == 0

	hb.init_hudbar(player, "armor", arm_printable(arm), nil, hide)
end

--- update hud elemtens if value has changed
--- @param player Player
local function update_hud_for(player)
	local arm = defense.for_player(player).fleshy or 0

	if hbarmor.auto_hide then
		-- hide armor bar completely when there is none
		if arm == 0 then
			hb.hide_hudbar(player, "armor")
		else
			hb.change_hudbar(player, "armor", arm_printable(arm))
			hb.unhide_hudbar(player, "armor")
		end
	else
		hb.change_hudbar(player, "armor", arm_printable(arm))
	end
end

equipment.on_load(equipment.Kind.ARMOR, function(player)
	init_custom_hud_for(player)
end)

--- @param player     Player
--- @param delta_time number
minetest.foreach_player_every(hbarmor.tick, function(player, delta_time)
	-- TODO: don't refresh each tick. Use callbacks, when defense of player changed.
	-- update all hud elements
	update_hud_for(player)
end)
