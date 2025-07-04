local Manager    = require('holding_points.Manager')
local Battle     = require('holding_points.Battle')
local BattleForm = require('holding_points.node.Form.BattleTab.BattleForm')

local S    = minetest.get_mod_translator()
local spec = forms.Spec


local SMALL = { font_size = '-1' } -- Style for formspec

--- @class holding_points.node.Form.BattlesTab: base_classes.Form.Element.Tab
local BattlesTab = {
	title   = S('Battle'),
	--- @type holding_points.node.Form parent form
	form    = nil,
	--- @type number height of row in battle list
	row_h   = 1.3,
	--- @type string error string to display on form
	error   = nil,
	--- @type number height of error box area
	error_h = 1.2,
}
BattlesTab = base_classes.Form.Element.Tab:extended(BattlesTab)

--- @param battle holding_points.Battle
function BattlesTab:battle_row(x, y, row, battle)
	local padding      = self.form.padding
	local size         = self.form.size
	local row_center_y = self.form:get_row_center_y(row, self.row_h)
	local center_x     = self.form.center_x
	local fields_h     = self.form.fields_h

	local schedule = battle.schedules[1]

	return ''
		.. spec.bold (x, y + row_center_y - 0.14, battle.title)
		.. spec.muted(x, y + row_center_y + 0.14, battle.name, SMALL)
		.. (schedule
			and spec.label(x + center_x - 1.7, y + row_center_y, ('%s; %s (%s minutes)'):format(
				table.concat(schedule.days, ','), schedule.time, battle.duration
			))
			or ''
		)
		.. spec.bold (size.x - 1.7, y + row_center_y, #battle.points .. ' point(s)')
		.. spec.button(
			size.x - 1 + padding.x,
			y + row_center_y - self.row_h / 2,
			1,
			fields_h,
			'edit_' .. battle.name,
			'edit'
		)
end

--- @param battles holding_points.Battle[]
function BattlesTab:battles_list(x, y, battles)
	local formspec = ''
	local row = 0

	for _, battle in pairs(battles) do
		formspec = formspec .. self:battle_row(x, y, row, battle)
		row = row + 1
	end

	return formspec
end

function BattlesTab:show_error(x, y, width, height, message)
	if not message then
		return ''
	end

	return ''
		.. spec.style('box', { bordercolors = '#f00' })
		.. spec.box(x, y, width, height, '#2008')
		.. spec.text(x + 0.2, y + 0.3, message, { textcolor = '#f88' })
end

function BattlesTab:get_spec()
	local padding = self.form.padding
	local size    = self.form.size
	local message = self.error
	self.error = nil

	return ''
		.. spec.box(padding.x - 0.2, padding.y, size.x + 0.2 * 2, 1, '#0006')
		.. spec.header3(padding.x, padding.y + 0.5, 'List of Server Battles')
		.. spec.button(size.x - 2 + padding.x, padding.y + 0.15, 2, self.form.fields_h, 'add', 'Add Battle')
		.. self:battles_list(padding.x, padding.y + 1.2, Manager.get_battles())
		.. self:show_error(padding.x, padding.y + size.y - self.error_h, size.x, self.error_h, message)
end

--- @param fields table<string,any>
--- @return nil|boolean return `true` for stop propagation of handling
function BattlesTab:handle(fields)
	if fields.add then
		local tmp_name = 'battle-1'
		if Manager.get_battle(tmp_name) then
			self.error =
				('You have an unsaved temporary Battle.\nPlease rename & configure `%s` and save changes.')
					:format(tmp_name)
			self.form:open()

			return true
		end

		Manager.add_battle(Battle:new(tmp_name))
		BattleForm
			:new(self.form:player(), Manager.get_battle(tmp_name), self.form)
			:open()

		return true
	end

	for field_name, _ in pairs(fields) do
		if field_name:starts_with('edit_') then
			BattleForm
				:new(self.form:player(), Manager.get_battle(field_name:remove('edit_')), self.form)
				:open()

			return true
		end
	end

	return
end


return BattlesTab
