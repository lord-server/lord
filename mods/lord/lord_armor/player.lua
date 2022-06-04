lord_armor.skin = {}

DEFAULT_SKIN = "test_skin.png"
TRANSPARENT_SKIN = "lottarmor_trans.png"

function lord_armor.skin_init(player, texture)
	player_api.set_model(player, "lord_armor_character.b3d")
	local name = player:get_player_name()

	lord_armor.skin[name] = {
		skin = texture,
		armor = TRANSPARENT_SKIN,
		clothes = TRANSPARENT_SKIN
	}
end

function lord_armor.upd_player_visuals(player)
	if not player then
		return
	end
	local name = player:get_player_name()

	if lord_armor.skin[name] then
		player_api.set_textures(player, {
			lord_armor.skin[name].skin,
			lord_armor.skin[name].armor,
			lord_armor.skin[name].clothes,
		})
	end
end

function lord_armor.get_skin_name(name)
	if lord_armor.skin[name] then
		return lord_armor.skin[name].skin or DEFAULT_SKIN
	else
		return DEFAULT_SKIN
	end
end

--[[function multiskin:get_preview(name)
	local race = races.get_race(name)
	local gender = races.get_gender(name)
	local skin = races.get_skin(name)
	return races.get_face_preview_name(race, gender, skin)
end]]

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	for field, _ in pairs(fields) do
		if string.find(field, "skins_set") then
			minetest.after(0, function(updated_player)
				local skin = lord_armor.get_skin_name(name)
				if skin then
					lord_armor.skin[name].skin = skin..".png"
					lord_armor.upd_player_visuals(updated_player)
				end
			end, player)
		end
	end
end)

player_api.register_model("lord_armor_character.b3d", {
	animation_speed = 50,
	textures = {
		DEFAULT_SKIN,
		TRANSPARENT_SKIN,
		TRANSPARENT_SKIN,
	},

	animations = {
		stand = {x=0, y=119},
		lay = {x=1020, y=1039},
		walk = {x=120, y=239},
		mine = {x=260, y=379},
		walk_mine = {x=380, y=499},
		sneak_stand = {x=510, y=629},
		sneak_walk = {x=630, y=749},
		sneak_mine = {x=770, y=889},
		sneak_walk_mine = {x=890, y=1009},
		crawl = {x=1210, y=1359},
		swim = {x=1370, y=1569},
		sit = {x=1060, y=1179},
	},
})

minetest.register_on_joinplayer(function(player)
	player_api.player_attached[player:get_player_name()] = false
	player_api.set_model(player, "lord_armor_character.b3d")
	player:set_local_animation(
		{x=0, y=119},
		{x=120, y=239},
		{x=260, y=379},
		{x=380, y=499},
		50
	)
end)

minetest.register_globalstep(function()
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local player_ref = player_api.get_animation(player)
		local model_name = player_ref.model
		local model = model_name and player_api.registered_models[model_name]
		if model and not player_api.player_attached[name] then
			local controls = player:get_player_control()
			local animation_speed_mod = model.animation_speed or 30
			local walktype = ""

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 50
				walktype = "sneak_"
			end

			-- Apply animations based on what the player is doing
			if player:get_hp() == 0 then
				player_api.set_animation(player, "lay")
			-- Determine if the player is walking
			elseif controls.up or controls.down or controls.left or controls.right then
				if controls.LMB or controls.RMB then
					player_api.set_animation(player, walktype.."walk_mine", animation_speed_mod)
				else
					player_api.set_animation(player, walktype.."walk", animation_speed_mod)
				end
			elseif controls.LMB or controls.RMB then
				player_api.set_animation(player, walktype.."mine", animation_speed_mod)
			else
				player_api.set_animation(player, walktype.."stand", animation_speed_mod)
			end
		end
	end
end)
