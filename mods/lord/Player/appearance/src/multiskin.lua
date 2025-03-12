local table_insert, table_concat
	= table.insert, table.concat


local MULTISKIN_DEFAULT_SKIN = "character.png"
local MULTISKIN_DEFAULT_PREVIEW = "character_preview.png"
local MULTISKIN_TRANS = "lottarmor_trans.png"

multiskin = {}

function multiskin:init(player, texture)
	player_api.set_model(player, "lottarmor_character.b3d")
	local name = player:get_player_name()
	multiskin[name] = {
		skin = texture or MULTISKIN_DEFAULT_SKIN,
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
	local skin = races.get_skin_number(name)

	return lord_skins.get_preview_name('front', race, gender, skin) or MULTISKIN_DEFAULT_PREVIEW
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

--- @param kind   string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
--- @param player Player the `Player` MT object
--- @return table|string[]
local function get_equip_textures(kind, player)
	local textures = {}
	for _, item in equipment.for_player(player):not_empty(kind) do
		table_insert(textures, item:get_name():gsub("%:", "_") .. ".png")
	end

	return textures
end

--- @param kind   string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>
--- @param player Player the `Player` MT object
--- @return string overlaid (via "^") textures names of `kind`-equipment or transparent texture name
local function overlay_equip_textures(kind, player)
	local textures = get_equip_textures(kind, player)
	if #textures == 0 then
		return MULTISKIN_TRANS
	end

	return table_concat(textures, "^")
end

-- moved from lottarmor/armor.lua & lottclothing/clothing.lua
-- TODO: remove using `races.register_init_callback`, instead use `equipment.on_load_all` & `character.get_texture`
races.register_init_callback(function(name, race, gender, skin, texture, face)
	local joined_player = minetest.get_player_by_name(name)
	multiskin:init(joined_player, texture)
end)
equipment.on_load(function(player, kind, event, slot, item)
	multiskin[player:get_player_name()][kind] = overlay_equip_textures(kind, player)
end)
equipment.on_load_all(function(player)
	multiskin:update_player_visuals(player)
end)
-- end TODO

-- When *any* equipment changed (armor or clothing),
-- we need to update player model appearance to show clothes and/or armor.
equipment.on_change(function(player, kind, event, slot, item)
	multiskin[player:get_player_name()][kind] = overlay_equip_textures(kind, player)
	multiskin:update_player_visuals(player)
end)
