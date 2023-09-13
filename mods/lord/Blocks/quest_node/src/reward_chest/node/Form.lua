local esc = minetest.formspec_escape


--- @type fun(str: string, ...)
local S = minetest.get_translator('quest_node')

---
--- @class quest_node.reward_chest.node.Form
---
local Form = {
	--- @const
	--- @type string
	NAME = "quest_node:reward_chest",
	--- @static
	--- @type table<string,quest_node.reward_chest.node.Form>
	opened_for = {},
	--- @static
	--- @type table<number,string>
	tabs = {SETTINGS = 1, VISITORS = 2},

	--- @private
	--- @type Position
	node_position = nil,
	--- @private
	--- @type NodeMetaRef
	node_meta     = nil,
	--- @type number
	tab           = nil,
	--- @type string
	player_name   = nil,
}

--- Constructor
--- @public
--- @param pos Position
--- @param player Player
--- @return quest_node.reward_chest.node.Form
function Form:new(pos, player)
	local new_object = {}

	new_object.node_position = pos
	new_object.node_meta     = minetest.get_meta(pos)
	new_object.player_name   = player:get_player_name()
	new_object.tab           = 1

	setmetatable(new_object, {__index = self})

	return new_object
end

--- @public
--- @static
--- @param player Player
function Form.get_opened_for(player)
	return Form.opened_for[player:get_player_name()]
end

--- @public
function Form:open()
	local player_name = self.player_name
	self.opened_for[player_name] = self;
	minetest.show_formspec(player_name, self.NAME, self:get_spec())
end

--- @public
--- @param tab_number number
function Form:switch_tab(tab_number)
	self.tab = tab_number
	self:open()
end

--- @public
function Form:close()
	self.opened_for[self.player_name] = nil
end

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

--- @static
--- @param player Player
--- @param form_name string
--- @param fields table
function Form.handler(player, form_name, fields)
	if form_name ~= Form.NAME then
		return
	end

	local form = Form.get_opened_for(player)
	if not form then return end

	if fields.key_enter or fields.save then
		-- only congrats, list of rewards saves automatically
		form:saveCongratulations(fields.congratulations)
	end
	if fields.tab then
		form:switch_tab(tonumber(fields.tab))
	end
	if fields.quit then
		form:close()
	end
end

minetest.register_on_leaveplayer(function(player, timed_out)
	local form = Form.get_opened_for(player);
	if form then
		form:close()
	end
end)


return Form
