local Inventory = require("artisan_benches.anvil.Form.Inventory")


--- @class artisan_benches.anvil.Form: base_classes.Form.Base
--- @field new fun(player:Player, pos:Position)
--- @field inventory anvil.Form.Inventory
local Form = base_classes.Form:personal():for_node():with_detached(Inventory):extended({
	--- @const
	--- @type string
	NAME = "lord_artisan_benches:anvil",
})

--- @private
function Form:get_spec()
	local inventory_id = self.inventory:get_id()

	return 'size[8,9]' ..
		'image[-0.2,-0.2;10.23,5.5;benches_anvil_form_bg.png]' ..
		'list[detached:'..inventory_id..';craft;2,1;3,3;]' ..
		'list[detached:'..inventory_id..';craft_result;5,2;1,1;]' ..
		'list[current_player;main;0,4.85;8,1;]' ..
		'list[current_player;main;0,6.08;8,3;8]' ..

		'listring[current_player;main]' ..
		'listring[detached:'..inventory_id..';craft]'
end

--- @private
--- @param fields table
function Form:handle(fields)
	if fields.quit then
		self.inventory:close()
	end
end


return Form
