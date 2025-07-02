local Manager = require('holding_points.Manager')

local S    = minetest.get_mod_translator()
local spec = forms.Spec


--- @class holding_points.node.Form.MainTab: base_classes.Form.Element.Tab
---
local MainTab = {
	title = S('Main'),
	--- @type holding_points.node.Form parent form
	form  = nil,
	--- @type boolean
	in_event_list = nil
}
MainTab = base_classes.Form.Element.Tab:extended(MainTab)

--- @private
function MainTab:get_battles_list()
	local list = {}
	for name, battle in pairs(Manager.get_battles()) do
		list[#list + 1] = battle.name
	end

	return list
end

--- @private
--- @return string
function MainTab:get_spec()
	local form = self.form
	local meta = form.node_meta

	local name              = meta:get_string('name')
	local in_event_list     = self.in_event_list == nil and (meta:get_int('in_event_list') == 1) or self.in_event_list
	local active            = meta:get_int('active') == 1
	--local last_activated_at = meta:get_int('last_activated_at')

	return ''
		.. form:labeled_field(0, 'input_name', name, S('Name'), S('This name will be shown for players'))
		.. form:labeled_checkbox(1, 'in_event_list', in_event_list, S('Participates in future battles'), S('Description'))
		.. form:labeled_boolean_ro(2, active, S('Active now'), S('Right now the battle is going on for this point.'))
		--.. form:labeled_datetime_ro(
		--	3, last_activated_at,
		--	S('Last activate at'), S('Date of the block\'s last participation in battle')
		--)
		.. form:labeled_dropdown(
			3, 'battle', self:get_battles_list(), 1, S('Battle'), S('Name(ID) of Battle the node will be in.')
		)
		.. spec.button_exit(form.center_x - 2/2, form:get_row_start_y(4), 2, form.fields_h, 'save', S('Save'))
		.. spec.label(form.padding.x, form:get_row_start_y(5) - 0.25, S('Reward'))
		.. spec.node_inventory(form.padding.x, form:get_row_start_y(5), 8, 1, form.node_position, 'reward')
		.. spec.player_inventory(form.padding.x, form:get_row_start_y(5) + 0.2 + 1.5, 8, 1)
end

--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function MainTab:handle(fields)
	if fields.in_event_list then
		-- just remember current value of checkbox for future saving by `Save` button
		self.in_event_list = minetest.is_yes(fields.in_event_list)
	end
	if not fields.save then
		return
	end

	self.form.node_meta:set_string('name', fields.input_name)
	self.form.node_meta:set_int('in_event_list', self.in_event_list and 1 or 0)
	self.form.node_meta:set_string('battle', fields.battle)

	return true
end


return MainTab
