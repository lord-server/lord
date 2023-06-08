
local main_form = require("inventory.main_form")
require("inventory.bags_form")


local inventory = {}

--- Previews by player name.
--- Has fields {skin="<string>", clothes="<string>", armor="<string>"}
--- @type table<string,table>
inventory.preview = {}

--- @param player       Player
--- @param preview_name string
--- @param texture      string
function inventory.set_preview(player, preview_name, texture)
	local player_name = player:get_player_name()
	if not inventory.preview[player_name] then
		inventory.preview[player_name] = {}
	end

	inventory.preview[player_name][preview_name] = texture
end

--- @param player_name string
---
--- @return string
function inventory.overlay_previews(player_name)
	local previews = inventory.preview[player_name]
	local overlaid_previews = "" .. previews.skin
	if previews.clothing and previews.clothing ~= "" then
		overlaid_previews = overlaid_previews .. "^" .. previews.clothing
	end
	if previews.armor and previews.armor ~= "" then
		overlaid_previews = overlaid_previews .. "^" .. previews.armor
	end

	return overlaid_previews
end

--- @param player Player
inventory.update = function(player)
	local name = player:get_player_name()
	local formspec = main_form.get_spec(name, inventory.overlay_previews(name))
	player:set_inventory_formspec(formspec)
end

--- @param player Player
--- @param kind   string type of equipment ("armor"|"clothing")
--- @return string
local function overlay_equip_previews(player, kind)
	local previews = {}
	for _, item in equipment.for_player(player):items(kind) do
		if not item:is_empty() then
			local item_groups = item:get_definition().groups
			if not item_groups["no_preview"] then
				table.insert(previews, item:get_name():gsub("%:", "_") .. "_preview.png")
			end
		end
	end

	return table.concat(previews, "^")
end

equipment.on_load(function(player, kind)
	inventory.set_preview(player, kind, overlay_equip_previews(player, kind))
end)
equipment.on_load_all(function(player)
	inventory.set_preview(player, "skin", multiskin:get_preview(player:get_player_name()))
	inventory.update(player)
end)

-- When *any* equipment changed (armor or clothing),
-- we need to update player inventory form to redraw player preview in it.
equipment.on_change(function(player, kind, event, slot, item)
	local player_name = player:get_player_name()
	inventory.preview[player_name][kind] = overlay_equip_previews(player, kind)

	inventory.update(player)
end)

minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if fields.main then
		name  = player:get_player_name()
		minetest.show_formspec(name, "main", main_form.get_spec(name, inventory.overlay_previews(name)))
	end
end)
