local esc = minetest.formspec_escape


local S = minetest.get_translator('quest_node')

---
--- @class quest_node.reward_chest.node.Form: base_classes.Form.Base
--- @field new fun(player:Player, pos:Position)
---
--- @field protected node_position Position             from `base_classes.Form.Mixin.ForNode`
--- @field protected node_meta     NodeMetaRef          from `base_classes.Form.Mixin.ForNode`
--- @field protected tabs          table<string,number> from `base_classes.Form.Mixin.WithTabs`
--- @field protected tab           number               from `base_classes.Form.Mixin.WithTabs`
local Form = base_classes.Form:personal():for_node():with_tabs({ SETTINGS = 1, VISITORS = 2 }):extended({
	--- @const
	--- @type string
	NAME = "quest_node:reward_chest",
})


--- @private
function Form:get_spec()
	local pos  = self.node_position
	local meta = self.node_meta

	local formspec        = "size[8,9]" ..
		"tabheader[0,0;tab;" .. S("Settings,Players") .. ";".. self.tab .."]"
	if self.tab == self.tabs.SETTINGS then
		local congratulations = meta:get_string("congratulations")
		local str_pos         = pos.x .. "," .. pos.y .. "," .. pos.z
		local player_inv_name = "current_player;main"
		local chest_inv_name  = "nodemeta:" .. str_pos .. ";reward"
		formspec = formspec ..
			"list[" .. player_inv_name .. ";0,4.85;8,1;]" ..
			"list[" .. player_inv_name .. ";0,6.08;8,3;8]" ..
			"label[0,0;" .. S("Reward:") .. "]" ..
			"list[" .. chest_inv_name .. ";0,0.4;8,4;]" ..
			"listring[]" ..
			"field[0.3,2;8,1;congratulations;" .. S("Congratulations text for player:") .. ";".. esc(congratulations) .."]" ..
			"style_type[label;font_size=-2;textcolor=#ccc]" ..
			"label[0,2.4;" .. S("Leave empty to display \"Congratulations! You completed the quest!\"") .. "]" ..
			"button_exit[4,3;2,1;save;" .. S("Save") .. "]" ..
			"button_exit[6,3;2,1;cancel;" .. S("Cancel") .. "]"
	elseif self.tab == self.tabs.VISITORS then
		local visitors = minetest.deserialize(meta:get_string("visitors"))
		formspec = formspec ..
			"textlist[0,0;7.75,9;visitors;" .. table.concat(visitors, ",") .. "]"
	else
		error("Unknown tab index " .. self.tab)
	end

	return formspec
end

--- @param congratulations string
function Form:saveCongratulations(congratulations)
	local meta = self.node_meta or minetest.get_meta(self.node_position)
	meta:set_string("congratulations", congratulations)
end

--- @param fields table
function Form:handle(fields)
	if fields.key_enter or fields.save then
		-- save only congrats, list of rewards saves automatically
		self:saveCongratulations(fields.congratulations)
	end
end


return Form:register()
