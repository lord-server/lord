local PlayerForm = require('inventory.Form')


--- This collection of forms passed into `inventory.Form` & replaces standard `opened_for` var of `Personal` mixin.
--- @see inventory.Form:on_register()
---
--- @type inventory.Form[]|table<string,inventory.Form>
local player_forms = {}


inventory = {} -- luacheck: ignore unused global variable inventory

local function register_api()
	_G.inventory = {
		--- @param player Player
		--- @return inventory.Form
		for_player = function(player)
			local name = player:get_player_name()
			if not player_forms[name] then
				player_forms[name] = PlayerForm:new(player)
			end

			return player_forms[name]
		end
	}
end


local preview = {}
--- Previews by player name.
--- @type table<string,{skin:string,clothes:string,armor:string}>
preview.for_player = {}

--- @param player    Player
--- @param part_name string
--- @param texture   string
function preview.set_part(player, part_name, texture)
	local player_name = player:get_player_name()
	if not preview.for_player[player_name] then
		preview.for_player[player_name] = {}
	end

	preview.for_player[player_name][part_name] = texture
end

--- @param player_name string
---
--- @return string
function preview.compile_overlay(player_name)
	local previews = preview.for_player[player_name]
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
function preview.update_on_form(player)
	local name = player:get_player_name()
	inventory.for_player(player)
		:set_main_preview(preview.compile_overlay(name))
		:refresh()
end

--- @param player Player
--- @param kind   string type of equipment ("armor"|"clothing")
--- @return string
local function overlay_equip_previews(player, kind)
	local previews = {}
	for _, item in equipment.for_player(player):not_empty(kind) do
		local item_groups = item:get_definition().groups
		if not item_groups["no_preview"] then
			table.insert(previews, item:get_name():replace("%:", "_") .. "_preview.png")
		end
	end

	return table.concat(previews, "^")
end

local function register_equipment_changes()
	equipment.on_load(function(player, kind)
		preview.set_part(player, kind, overlay_equip_previews(player, kind))
	end)
	equipment.on_load_all(function(player)
		preview.set_part(player, "skin", character.of(player):get_skin_preview_name('front'))
		preview.update_on_form(player)
	end)

	-- When *any* equipment changed (armor or clothing),
	-- we need to update player inventory form to redraw player preview in it.
	equipment.on_change(function(player, kind, event, slot, item)
		local player_name = player:get_player_name()
		preview.for_player[player_name][kind] = overlay_equip_previews(player, kind)

		preview.update_on_form(player)
	end)
end

--- Bags Form (& other forms) 'main' button handler: -----------------------------------------------------
-- TODO: move/remove this (move to appropriate forms, if needed; remove here)
minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if fields.main then
		inventory.for_player(player):open()
	end
end)


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()

		-- `player_forms` passed into callback `inventory.Form:on_register(callback)` by `Base` form.
		PlayerForm:register(player_forms)

		register_equipment_changes()
	end
}
