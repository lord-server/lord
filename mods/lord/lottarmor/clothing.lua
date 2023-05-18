local clothing = {}

equipment.on_change(equipment.Kind.CLOTHING, function(player, kind, event, slot, item)
	clothing:set_player_clothing(player)
end)

clothing.set_player_clothing = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	if not name or not player_inv then
		return
	end
	local preview = multiskin:get_skin_name(name) or "clothing_preview"
	preview = preview..".png"
	for _, stack in equipment.for_player(player):items(equipment.Kind.CLOTHING) do
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			if def.groups["clothes"] == 1 then
				local texture = stack:get_name():gsub("%:", "_")
				if not def.groups["no_preview"] then
					preview = preview.."^"..texture.."_preview.png"
				end
			end
		end
	end
end



races.register_init_callback(function(name, race, gender, skin, texture, face)
	local joined_player = minetest.get_player_by_name(name)

	minetest.after(ARMOR_INIT_DELAY, function(player)
		clothing:set_player_clothing(player)
		inventory.update(player)
	end, joined_player)
end)
