local SL = minetest.get_mod_translator()


lottpotion = {}

dofile(minetest.get_modpath("lottpotion").."/cauldron.lua")
dofile(minetest.get_modpath("lottpotion").."/potions/aka_api.lua")
dofile(minetest.get_modpath("lottpotion").."/arrows.lua")
dofile(minetest.get_modpath("lottpotion").."/potions/potions.lua")


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
