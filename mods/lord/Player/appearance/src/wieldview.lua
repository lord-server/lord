local time = 0
local update_time = tonumber(minetest.settings:get("lottarmor_update_time"))
if not update_time then
	update_time = 2
	minetest.settings:set("lottarmor_update_time", tostring(update_time))
end
local node_tiles = minetest.settings:get_bool("lottarmor_node_tiles")
if not node_tiles then
	node_tiles = false
	minetest.settings:set("lottarmor_node_tiles", "true")
end

local player_appearance = {
	wielded_item = {},
	transform = require("transform"),
}


player_appearance.get_item_texture = function(self, item)
	local texture = "lottarmor_trans.png"
	if item ~= "" then
		if minetest.registered_items[item] then
			if minetest.registered_items[item].inventory_image ~= "" then
				texture = minetest.registered_items[item].inventory_image
			elseif node_tiles == true and minetest.registered_items[item].tiles
					and type(minetest.registered_items[item].tiles[1]) == "string"
					and minetest.registered_items[item].tiles[1] ~= "" then
				texture = minetest.inventorycube(minetest.registered_items[item].tiles[1])
			end
		end
		if player_appearance.transform[item] then
			texture = texture.."^[transform".. player_appearance.transform[item]
		end
	end

	return texture
end

player_appearance.update_wielded_item = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local stack = player:get_wielded_item()
	local item = stack:get_name()
	if not item then
		return
	end
	if self.wielded_item[name] then
		if self.wielded_item[name] == item then
			return
		end
		multiskin[name].wielditem = self:get_item_texture(item)
		multiskin:update_player_visuals(player)
	end
	self.wielded_item[name] = item
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	player_appearance.wielded_item[name] = ""
end)

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > update_time then
		for _,player in ipairs(minetest.get_connected_players()) do
			player_appearance:update_wielded_item(player)
		end
		time = 0
	end
end)

