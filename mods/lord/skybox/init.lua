--- @module
local skybox      = {}

skybox.height     = {
	SPACE = 30000,
	UNDER_GROUND = -50,
}

skybox.definition = {
	SPACE = {
		sky = { base_color = { r = 0x13, g = 0x01, b = 0x24 }, type = "skybox", textures = {
			"galaxybox_1.png^[transform6",
			"galaxybox_2.png",
			"galaxybox_3.png^[transform7",
			"galaxybox_4.png^[transform1",
			"galaxybox_5.png^[transform4",
			"galaxybox_6.png",
		} },
		day_night_ratio = 0.25
	},
	AIR = {
		sky = { base_color = { r = 0, g = 0, b = 0 }, type = "regular" },
		day_night_ratio = nil
	},
	UNDER_GROUND = {
		sky = { base_color = { r = 0, g = 0, b = 0 }, type = "plain" },
		day_night_ratio = 0.1
	}
}

--- @param y number the height coordinate
--- @return string return layer name. One of {"SPACE"|"AIR"|"UNDER_GROUND"}
local function detect_height_layer(y)
	if y > skybox.height.SPACE then
		return "SPACE"
	elseif y < skybox.height.UNDER_GROUND then
		return "UNDER_GROUND"
	else
		return "AIR"
	end
end

--- @param player     Player player for whom the sky changes
--- @param definition table  table with keys: `sky`(table) - set_sky definition  & `day_night_ratio`(float)
local function change_player_sky(player, definition)
	player:set_sky(definition.sky)
	player:override_day_night_ratio(definition.day_night_ratio)
end

minetest.register_globalstep(function(_)
	for _, player in pairs(minetest.get_connected_players()) do
		local layer = detect_height_layer(player:get_pos().y)
		change_player_sky(player, skybox.definition[layer])
	end
end)
