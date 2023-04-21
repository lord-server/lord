
local main_form = require("inventory.main_form")
require("inventory.bags_form")


inventory = {}

--- @param player Player
inventory.update = function(player)
	local name = player:get_player_name()
	local formspec = main_form.get_spec(name)
	player:set_inventory_formspec(formspec)
end
