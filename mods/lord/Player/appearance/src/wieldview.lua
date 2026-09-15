local update_time = tonumber(core.settings:get("lottarmor_update_time"))
if not update_time then
	update_time = 2
	core.settings:set("lottarmor_update_time", tostring(update_time))
end
local node_tiles = core.settings:get_bool("lottarmor_node_tiles")
if not node_tiles then
	node_tiles = false
	core.settings:set("lottarmor_node_tiles", "true")
end


local player_appearance = {
	wielded_item = {},
	transform = require("transform"),
}

player_appearance.get_item_texture = function(self, item)
	local texture = "lottarmor_trans.png"
	if item ~= "" then
		if core.registered_items[item] then
			if core.registered_items[item].inventory_image ~= "" then
				texture = core.registered_items[item].inventory_image
			elseif node_tiles == true and core.registered_items[item].tiles
					and type(core.registered_items[item].tiles[1]) == "string"
					and core.registered_items[item].tiles[1] ~= "" then
				texture = core.inventorycube(core.registered_items[item].tiles[1])
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

core.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	player_appearance.wielded_item[name] = ""
end)

core.foreach_player_every(update_time, function(player)
	player_appearance:update_wielded_item(player)
end)

