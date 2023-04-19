MULTISKIN_DEFAULT_SKIN = "character.png"
MULTISKIN_DEFAULT_PREVIEW = "character_preview.png"
MULTISKIN_TRANS = "lottarmor_trans.png"

multiskin = {}

function multiskin:init(player, texture)
	player_api.set_model(player, "lottarmor_character.b3d")
	local name = player:get_player_name()
	multiskin[name] = {
		skin = texture,
		armor = MULTISKIN_TRANS,
		wielditem = MULTISKIN_TRANS,
		clothing = MULTISKIN_TRANS,
	}
end

function multiskin:update_player_visuals(player)
	if not player then
		return
	end
	local name = player:get_player_name()
	if multiskin[name] then
		player_api.set_textures(player, {
			multiskin[name].skin,
			multiskin[name].armor,
			multiskin[name].wielditem,
			multiskin[name].clothing,
		})
	end
end

function multiskin:get_skin_name(name)
	if multiskin[name] then
		return multiskin[name].skin or MULTISKIN_DEFAULT_SKIN
	else
		return MULTISKIN_DEFAULT_SKIN
	end
end

function multiskin:get_preview(name)
	local race = races.get_race(name)
	local gender = races.get_gender(name)
	local skin = races.get_skin(name)
	return races.get_face_preview_name(race, gender, skin) or MULTISKIN_DEFAULT_PREVIEW
end

player_api.register_model("lottarmor_character.b3d", {
	animation_speed = 30,
	textures = {
		MULTISKIN_DEFAULT_SKIN,
		MULTISKIN_TRANS,
		MULTISKIN_TRANS,
		MULTISKIN_TRANS,
	},
	animations = {
		stand = {x=0, y=79},
		lay = {x=162, y=166},
		walk = {x=168, y=187},
		mine = {x=189, y=198},
		walk_mine = {x=200, y=219},
		sit = {x=81, y=160},
	},
})
