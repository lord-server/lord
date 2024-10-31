if not minetest.settings:get_bool("enable_damage", false) then
	return
end


local S = minetest.get_mod_translator()
local N = function(s) return s end


local hbarmor = {
	--- If true, the armor bar is hidden when the player does not have any defense
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
	hb.init_hudbar(player, "armor", arm_printable(0), nil, hbarmor.auto_hide)
end

--- update hud elemtens if value has changed
--- @param player Player
--- @param defense defense.PlayerDefense
local function update_hud_for(player, defense)
	local arm = defense:default() or 0

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

defense.on_init(function(player, defense)
	init_custom_hud_for(player)
end)

defense.on_change(function(player, defense)
	update_hud_for(player, defense)
end)
