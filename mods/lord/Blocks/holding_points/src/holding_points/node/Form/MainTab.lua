local Meta    = require('holding_points.HoldingPoint.Meta')
local Manager = require('holding_points.Manager')

local S    = minetest.get_mod_translator()
local spec = forms.Spec


--- @class holding_points.node.Form.MainTab: base_classes.Form.Element.Tab
---
local MainTab = {
	title = S('Main'),
	--- @type holding_points.node.Form parent form
	form  = nil,
	--- @type boolean temporary saving checkbox value
	in_event_list = nil,
	--- @type holding_points.HoldingPoint.Meta
	meta = nil,
}
MainTab = base_classes.Form.Element.Tab:extended(MainTab)

function MainTab:instantiate()
	self.meta = Meta:new(self.form.node_meta)
	-- remember for future saving by `Save` button
	self.in_event_list = self.meta.in_event_list or false
end

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

	local name          = self.meta.name or ''
	local in_event_list = self.in_event_list ~= nil and self.in_event_list or self.meta.in_event_list
	local active        = self.meta.active
	local battle        = self.meta.battle

	local battles_list    = self:get_battles_list()
	local battle_selected = (battle and battle ~= '')
		and (table.key_value_swap(battles_list)[battle] or 0)
		or  0

	return ''
		.. form:labeled_field(0, 'input_name', name, S('Name'), S('This name will be shown for players'))
		.. form:labeled_checkbox(1, 'in_event_list', in_event_list, S('Participates in future battles'), S('Description'))
		.. form:labeled_boolean_ro(2, active, S('Active now'), S('Right now the battle is going on for this point.'))
		.. form:labeled_dropdown(
			3, 'battle', battles_list, battle_selected, S('Battle'), S('Name(ID) of Battle the node will be in.')
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

	local previous_battle = self.meta.battle

	self.meta.name          = fields.input_name
	self.meta.in_event_list = self.in_event_list
	self.meta.battle        = fields.battle

	if previous_battle ~= fields.battle then
		Manager.move_point(self.form.node_position, previous_battle, fields.battle)
	end

	return true
end


return MainTab
