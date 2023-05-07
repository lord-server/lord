
local main_form = require("inventory.main_form")
require("inventory.bags_form")


inventory = {}

--- @param player Player
inventory.update = function(player)
	local name = player:get_player_name()
	local formspec = main_form.get_spec(name)
	player:set_inventory_formspec(formspec)
end

-- When *any* equipment changed (armor or clothing),
-- we need to update player inventory form to redraw player preview in it.
equipment.on_change(function(player, kind, event, slot, item)
	inventory.update(player)
end)
