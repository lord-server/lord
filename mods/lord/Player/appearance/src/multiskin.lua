local table_insert, table_concat
	= table.insert, table.concat


local MULTISKIN_TRANS = "lottarmor_trans.png"

-- TODO: refactoring: separate array for multiskin[name] ; use wield_item.on_index_change()
multiskin = {}

function multiskin:init(player, texture)
	player_api.set_model(player, "lottarmor_character.b3d")
	local name = player:get_player_name()
	multiskin[name] = {
		skin = texture or lord_skins.DEFAULT.SKIN,
		armor = MULTISKIN_TRANS,
		wielditem = MULTISKIN_TRANS,
		clothing = MULTISKIN_TRANS,
	}
end

function multiskin.for_player(player)
	local name = player:get_player_name()
	if not multiskin[name] then
		multiskin:init(player)
	end

	return multiskin[name]
end

function multiskin:update_player_visuals(player)
	if not player then
		return
	end
	local name = player:get_player_name()
	if multiskin.for_player(player) then
		player_api.set_textures(player, {
			multiskin[name].skin,
			multiskin[name].armor,
			multiskin[name].wielditem,
			multiskin[name].clothing,
		})
	end
end

player_api.register_model("lottarmor_character.b3d", {
	animation_speed = 30,
	textures = {
		lord_skins.DEFAULT.SKIN,
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

equipment.on_load(function(player, kind, event, slot, item)
	multiskin.for_player(player)[kind] = overlay_equip_textures(kind, player)
end)
equipment.on_load_all(function(player)
	multiskin.for_player(player).skin = character.of(player):get_skin_texture()
	multiskin:update_player_visuals(player)
end)

-- When *any* equipment changed (armor or clothing),
-- we need to update player model appearance to show clothes and/or armor.
equipment.on_change(function(player, kind, event, slot, item)
	multiskin.for_player(player)[kind] = overlay_equip_textures(kind, player)
	multiskin:update_player_visuals(player)
end)

character.on_skin_change(function(character, skin_no)
	local player = character:get_player()
	multiskin.for_player(player).skin = character:get_skin_texture()
	multiskin:update_player_visuals(player)
end)

minetest.register_on_leaveplayer(function(player, timed_out)
	multiskin[player:get_player_name()] = nil
end)
