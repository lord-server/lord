local SL = minetest.get_mod_translator()


lottpotion = {}

dofile(minetest.get_modpath("lottpotion").."/cauldron.lua")
dofile(minetest.get_modpath("lottpotion").."/potions/aka_api.lua")
dofile(minetest.get_modpath("lottpotion").."/arrows.lua")

minetest.foreach_player_every(1, function(player)
	local name = player:get_player_name()
	local hp_change = lottpotion.players[name].hp or 0
	if hp_change ~= 0 then
		local hp = player:get_hp()
		hp = hp + hp_change
		hp = math.min(20, hp)
		hp = math.max(0, hp)
		player:set_hp(hp)
	end
	local br_change = lottpotion.players[name].air or 0
	if br_change ~= 0 then
		local br = player:get_breath()
		br = br + br_change
		br = math.min(20, br)
		br = math.max(0, br)
		player:set_breath(br)
	end
	if lottpotion.players[name].alive ~= 1 then
		lottpotion.players[name].alive = 1
	end
end)

minetest.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	lottpotion.players[name] = {
		speed = 1,
		jump = 1,
		gravity = 1,
		air = 0,
		hp = 0,
		alive = 0,
	}
	lottpotion.refresh(name)
	if lottpotion.deaths[name] == nil then
		lottpotion.deaths[name] = 1
	end
	lottpotion.deaths[name] = lottpotion.deaths[name] + 1
end)

dofile(minetest.get_modpath("lottpotion").."/potions/potions.lua")

minetest.register_on_joinplayer(function(player)
	lottpotion.players[player:get_player_name()] = {
		speed = 1,
		jump = 1,
		gravity = 1,
		air = 0,
		hp = 0,
		alive = 1,
	}
end)

minetest.register_on_leaveplayer(function(player)
	lottpotion.players[player:get_player_name()] = nil
	lottpotion.deaths[player:get_player_name()] = nil
end)


function lottpotion.can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if not inv:is_empty("src") or not inv:is_empty("dst") or not inv:is_empty("fuel") or
	   not inv:is_empty("upgrade1") or not inv:is_empty("upgrade2") then
		minetest.chat_send_player(player:get_player_name(),
			SL("Brewer cannot be removed because it is not empty"))
		return false
	else
		return true
	end
end

function lottpotion.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name ~= name then
		node.name = name
		minetest.swap_node(pos, node)
	end
	return node.name
end

dofile(minetest.get_modpath("lottpotion").."/lottpotion_recipe_system.lua")


dofile(minetest.get_modpath("lottpotion").."/potionbrewing.lua")
dofile(minetest.get_modpath("lottpotion").."/brewing.lua")
