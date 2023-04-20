clothing = {}

clothing.set_player_clothing = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	if not name or not player_inv then
		return
	end
	local clothing_texture = "lottarmor_trans.png"
	local textures = {}
	local preview = multiskin:get_skin_name(name) or "clothing_preview"
	preview = preview..".png"
	for i=1, 5 do
		local stack = player_inv:get_stack("clothing", i)
		local item = stack:get_name()
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			if def.groups["clothes"] == 1 then
				local texture = item:gsub("%:", "_")
				table.insert(textures, texture..".png")
				if not def.groups["no_preview"] then
					preview = preview.."^"..texture.."_preview.png"
				end
			end
		end
	end
	if #textures > 0 then
		clothing_texture = table.concat(textures, "^")
	end
	multiskin[name].clothing = clothing_texture
	multiskin:update_player_visuals(player)
end

clothing.update_inventory = function(self, player)
	local name = player:get_player_name()
	local formspec = armor.get_armor_formspec(name)
	player:set_inventory_formspec(formspec)
end


local modpath = minetest.get_modpath(minetest.get_current_modname())
local detached_inv_clothes_slots = dofile(modpath.."/inventory_clothing_slots.lua")
races.register_init_callback(function(name, race, gender, skin, texture, face)
	local joined_player = minetest.get_player_by_name(name)
    multiskin:init(joined_player, texture)
	local player_inv = joined_player:get_inventory()
	local clothing_inv = minetest.create_detached_inventory(name.."_clothing", detached_inv_clothes_slots, name)
	clothing_inv:set_size("clothing", 5)
	player_inv:set_size("clothing", 5)
	for i=1, 5 do
		local stack = player_inv:get_stack("clothing", i)
		clothing_inv:set_stack("clothing", i, stack)
	end
	minetest.after(ARMOR_INIT_DELAY, function(player)
		clothing:set_player_clothing(player)
		clothing:update_inventory(player)
	end, joined_player)
end)
