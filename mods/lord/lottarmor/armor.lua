local SL = minetest.get_translator("lottarmor")

ARMOR_INIT_DELAY = 1
ARMOR_UPDATE_TIME = 1

-- Armor API

armor = {
	player_hp = {},
	elements = {"head", "torso", "legs", "feet", "shield"},
	physics = {"jump","speed","gravity"},
	textures = {},
	def = {state=0, count = 0},
	version = "0.4.4",
}


equipment.on_change(equipment.Kind.ARMOR, function(player, kind, event, slot, item)
	armor:set_player_armor(player)
end)


function armor:set_player_armor(player)
	local name, player_inv = armor.get_valid_player(player, "[set_player_armor]")
	if not name then
		return
	end
	local armor_texture = "lottarmor_trans.png"
	local armor_level = 0
	local armor_heal = 0
	local armor_fire = 0
	local state = 0
	local items = 0
	local elements = {}
	local textures = {}
	local physics_o = {speed=1,gravity=1,jump=1}
	local material = {type=nil, count=1}
	local preview = multiskin:get_preview(name)
	for _,v in ipairs(self.elements) do
		elements[v] = false
	end
	for i = 1, 5 do
		local stack = player_inv:get_stack("armor", i)
		local item = stack:get_name()
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			for k, v in pairs(elements) do
				if v == false then
					local level = def.groups["armor_"..k]
					if level and not def.groups["clothes"] then
						local texture = item:gsub("%:", "_")
						table.insert(textures, texture..".png")
						preview = preview.."^"..texture.."_preview.png"
						armor_level = armor_level + level
						state = state + stack:get_wear()
						items = items + 1
						local heal = def.groups["armor_heal"] or 0
						armor_heal = armor_heal + heal
						local fire = def.groups["armor_fire"] or 0
						armor_fire = armor_fire + fire
						for kk,vv in ipairs(self.physics) do
							local o_value = def.groups["physics_"..vv]
							if o_value then
								physics_o[vv] = physics_o[vv] + o_value
							end
						end
						local mat = string.match(item, "%:.+_(.+)$")
						if material.type then
							if material.type == mat then
								material.count = material.count + 1
							end
						else
							material.type = mat
						end
						elements[k] = true
					end
				end
			end
		end
	end
	if minetest.get_modpath("shields") then
		armor_level = armor_level * 0.9
	end
	if material.type and material.count == #self.elements then
		armor_level = armor_level * 1.1
	end
	if #textures > 0 then
		armor_texture = table.concat(textures, "^")
	end
	local armor_groups = {fleshy=100}
	local immortal = player:get_armor_groups().immortal
	if immortal and immortal ~= 0 then
		armor_groups.immortal = 1
	end
	if armor_level > 0 then
		armor_groups.level = math.floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end
	if player:get_meta():get("lott:immunity") ~= nil and (not immortal or immortal == 0) then
		player:set_armor_groups({fleshy = 1})
	else
		player:set_armor_groups(armor_groups)
	end
	player:set_physics_override(physics_o)
	self.textures[name].armor = armor_texture
	self.textures[name].preview = preview
	self.def[name].state = state
	self.def[name].count = items
	self.def[name].level = armor_level
	self.def[name].heal = armor_heal
	self.def[name].jump = physics_o.jump
	self.def[name].speed = physics_o.speed
	self.def[name].gravity = physics_o.gravity
	self.def[name].fire = armor_fire
	multiskin[name].armor = armor_texture
	multiskin:update_player_visuals(player)
end

local handle_armor_wear = function(player)
	local name, player_inv, armor_inv = armor.get_valid_player(player, "[handle_armor_wear]")
	if not name then
		return
	end
	local hp = player:get_hp() or 0
	if hp <= 0 or hp == armor.player_hp[name] then
		return
	end
	if armor.player_hp[name] > hp then
		local heal_max = 0
		local state = 0
		local items = 0
		for slot, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
			if stack:get_count() > 0 then
				local clothes = stack:get_definition().groups["clothes"] or 0
				local use = stack:get_definition().groups["armor_use"] or 0
				local heal = stack:get_definition().groups["armor_heal"] or 0
				local item = stack:get_name()
				stack:add_wear(use)
				armor_inv:set_stack("armor", slot, stack)
				player_inv:set_stack("armor", slot, stack)
				state = state + stack:get_wear()
				if clothes ~= 1 then
					items = items + 1
				end
				if stack:get_count() == 0 then
					local desc = minetest.registered_items[item].description
					if desc then
						minetest.chat_send_player(name, desc.." "..SL("got destroyed!"))
					end
					armor:set_player_armor(player)
					inventory.update(player)
				end
				heal_max = heal_max + heal
			end
		end
		armor.def[name].state = state
		armor.def[name].count = items
		if heal_max > math.random(100) then
			player:set_hp(armor.player_hp[name])
			return
		end
	end
	armor.player_hp[name] = hp
end

function armor.get_valid_player(player, msg)
	msg = msg or ""
	if not player then
		minetest.log("error", "lottarmor: Player reference is nil "..msg)
		return
	end
	local name = player:get_player_name()
	if not name then
		minetest.log("error", "lottarmor: Player name is nil "..msg)
		return
	end
	local pos = player:get_pos()
	local player_inv = player:get_inventory()
	local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
	if not pos then
		minetest.log("error", "lottarmor: Player position is nil "..msg)
		return
	elseif not player_inv then
		minetest.log("error", "lottarmor: Player inventory is nil "..msg)
		return
	elseif not armor_inv then
		minetest.log("error", "lottarmor: Detached armor inventory is nil "..msg)
		return
	end
	return name, player_inv, armor_inv
end

-- Register Callbacks

races.register_init_callback(function(name, race, gender, skin, texture, face)
	local joined_player = minetest.get_player_by_name(name)
	multiskin:init(joined_player, texture)

	armor.player_hp[name] = 0
	armor.def[name] = {
		state = 0,
		count = 0,
		level = 0,
		heal = 0,
		jump = 1,
		speed = 1,
		gravity = 1,
		fire = 0,
	}
	armor.textures[name] = {
		armor = "lottarmor_trans.png",
		preview = "character_preview.png"
	}

	minetest.after(ARMOR_INIT_DELAY, function(player)
		armor:set_player_armor(player)
		inventory.update(player)
	end, joined_player)
end)

local time = 0
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > ARMOR_UPDATE_TIME then
		for _,player in ipairs(minetest.get_connected_players()) do
			handle_armor_wear(player)
		end
		time = 0
	end
end)
