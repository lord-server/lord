local Manager  = require('holding_points.Manager')
local Schedule = require('holding_points.Battle.Schedule')

local S        = minetest.get_mod_translator()
local spec     = forms.Spec
local colorize = minetest.colorize


--- @class holding_points.node.Form.BattlesTab.BattleForm: base_classes.Form.Base
--- @field new fun(self:self, player:Player, battle:holding_points.Battle, parent_form:holding_points.node.Form)
local BattleForm = {
	--- @type string
	NAME            = 'holding_points:battle',
	--- @type Position2d initialized in `self:instantiate()`
	size            = {},
	--- @type holding_points.Battle
	battle          = nil,
	--- @type holding_points.node.Form "parent" form. The form from which was opened this form.
	form            = nil,
	--- @type number
	schedules_row_h = nil,
	--- @type string temporary saved entered by user `name` of Battle
	typed_name      = nil,
	--- @type string temporary saved entered by user `title` of Battle
	typed_title     = nil,
	--- @type string temporary saved entered by user `duration` of Battle
	typed_duration  = nil,
}
BattleForm = base_classes.Form:personal():extended(BattleForm)

--- @param player      Player
--- @param battle      holding_points.Battle
--- @param parent_form holding_points.node.Form
function BattleForm:instantiate(player, battle, parent_form)
	self.battle          = battle
	self.form            = parent_form
	self.schedules_row_h = self.form.row_h - 0.1
	self:refresh_size()
end

--- @return holding_points.node.Form.BattlesTab.BattleForm
function BattleForm:refresh_size()
	local battle = self.battle

	self.size.x = self.form.size.x
	self.size.y = self.form.size.y - 3 + (#battle.schedules > 2
		and (#battle.schedules - 2) * self.schedules_row_h
		or  0
	)

	return self
end

--- @param x      number
--- @param y      number
--- @param height number
function BattleForm:schedules_header(x, y, width, height)
	local center_y  = y + height / 2
	local columns_y = center_y + height / 4

	return ''
		.. spec.bold(x, center_y - height / 4, S('Schedules'))
		.. spec.label(x + 0.1, columns_y, S('days'))
		.. spec.label(x + 2.3, columns_y, S('time'))
		.. spec.label(x + 4.1, columns_y, S('week'))
		.. spec.button(x + width - 2.4, y, 2.4, self.form.fields_h - 0.1, 'add_schedule', 'add schedule')
end

--- @param x         number
--- @param y         number
--- @param schedules holding_points.Battle.Schedule[]
--- @param edit_i    number index of currently being edited schedule.
function BattleForm:schedules_rows(x, y, schedules, edit_i)
	local size     = self.size
	local padding  = self.form.padding
	local fields_h = self.form.fields_h - 0.1
	local row_h    = self.schedules_row_h

	local field_margin_y = (row_h - fields_h) / 2

	local schedules_rows = ''
	for i = 1, #schedules do
		local schedule = schedules[i]
		-- `form:get_row_center_y()` also adds padding, so we have to subtract it,
		--     since its already contained in the passed `y`
		local row_center_dy = self.form:get_row_center_y(i - 1, row_h) - padding.y
		local fields_dy     = self.form:get_row_start_y (i - 1, row_h) - padding.y + field_margin_y

		if i == edit_i then
			schedules_rows = schedules_rows
				.. spec.field(x + 0.1, y + fields_dy, 1.8, fields_h, 'sch_days', '', table.concat(schedule.days, ','))
				.. spec.field(x + 2.3, y + fields_dy, 1.0, fields_h, 'sch_time', '', schedule.time)
				.. spec.field(x + 4.1, y + fields_dy, 3.1, fields_h, 'sch_week', '', minetest.write_json(schedule.week))
				.. spec.button(x + size.x - 1, y + fields_dy, 1, fields_h, 'sch_save_' .. i, S('save'))
		else
			schedules_rows = schedules_rows
				.. spec.label(x + 0.1, y + row_center_dy, schedule:get_days_string())
				.. spec.label(x + 2.3, y + row_center_dy, schedule.time)
				.. spec.label(x + 4.1, y + row_center_dy, schedule:get_week_string())
				.. spec.button(x + size.x - 2.1, y + fields_dy, 1, fields_h, 'sch_edit_' .. i, S('edit'))
				.. spec.button(x + size.x - 1.0, y + fields_dy, 1, fields_h, 'sch_del_' .. i, S('del'))
		end
	end

	return schedules_rows
end

--- @param row       number
--- @param schedules holding_points.Battle.Schedule[]
--- @param edit_i number index of currently being edited schedule.
--- @return string
function BattleForm:schedules_list(row, schedules, edit_i)
	local size    = self.size
	local padding = self.form.padding
	local y_shift = 0.3

	local start_y = self.form:get_row_start_y(row) + y_shift
	local row_h   = self.form.row_h
	local s_row_h = self.schedules_row_h

	return ''
		.. self:schedules_header(padding.x, start_y, size.x, row_h)
		.. spec.box(padding.x - 0.1, start_y + row_h, size.x + 0.1 * 2, s_row_h * #schedules, '#0004')
		.. self:schedules_rows(padding.x, start_y + row_h, schedules, edit_i)
end

--- @param edit_i number index of currently being edited schedule.
--- @return string
function BattleForm:get_spec(edit_i)
	local battle   = self.battle
	local size     = self.size
	local form     = self.form
	local padding  = self.form.padding
	local row_h    = self.form.row_h
	local fields_h = self.form.fields_h

	local battle_name     = self.typed_name or battle.name
	local battle_title    = self.typed_name or battle.title
	local battle_duration = self.typed_name or battle.duration

	return ''
		.. spec.formspec_version(4)
		.. spec.size(size.x + 2 * padding.x, size.y + 2 * padding.y)
		.. spec.box(padding.x - 0.1, padding.y - 0.1, size.x + 0.1 * 2, row_h, '#0006')
		.. spec.header3(padding.x, padding.y - 0.1 + row_h / 2, S('Edit Battle [@1]', colorize('#cccc', battle.name)))
		.. form:labeled_field(1, 'name', battle_name, 'name', 'unique technical name (ID).')
		.. form:labeled_field(2, 'title', battle_title, 'Title', 'Human-readable title for battle.')
		.. form:labeled_field(3, 'duration', battle_duration, 'Duration', 'Human-readable title for battle.')
		.. form:labeled_value_ro(4, #battle.points, 'Points', 'To add point to battle use Main Tab.')
		.. self:schedules_list(5, battle.schedules, edit_i)
		.. spec.button_exit(padding.x + size.x / 2 - 2 / 2, padding.y + size.y - fields_h, 2, fields_h, 'save', S('Save'))
end

--- @param fields table
--- @param prefix string
--- @return number|boolean returns `i` or `false`
function BattleForm:schedule_btn_pressed(fields, prefix)
	for field_name, _ in pairs(fields) do
		if field_name:starts_with(prefix) then
			return tonumber(field_name:replace(prefix, ''))
		end
	end

	return false
end

--- @param fields table
function BattleForm:presave_typed(fields)
	if fields.name then
		self.typed_name = fields.name
	end
	if fields.title then
		self.typed_title = fields.title
	end
	if fields.duration then
		self.typed_duration = fields.duration
	end
end

--- @param fields table
function BattleForm:handle(fields)
	self:presave_typed(fields)

	if fields.add_schedule then
		self.battle:add_schedule(Schedule:new())
		local new_i = #self.battle.schedules

		return self:refresh_size():open(new_i)
	end

	local edit_i_schedule = self:schedule_btn_pressed(fields, 'sch_edit_')
	if edit_i_schedule then
		return self:open(edit_i_schedule)
	end

	local delete_i_schedule = self:schedule_btn_pressed(fields, 'sch_del_')
	if delete_i_schedule then
		table.remove(self.battle.schedules, delete_i_schedule)
		Manager.save_battles()

		return self:refresh_size():open()
	end

	local save_i_schedule = self:schedule_btn_pressed(fields, 'sch_save_')
	if save_i_schedule then
		local schedule = self.battle.schedules[save_i_schedule]
		schedule.days = string.vxr_split(fields.sch_days, ',', tonumber)
		schedule.time = fields.sch_time
		schedule.week = minetest.parse_json(fields.sch_week)

		Manager.save_battles()

		return self:open()
	end

	if fields.save then
		self.battle.name     = self.typed_name or self.battle.name
		self.battle.title    = self.typed_title or self.battle.title
		self.battle.duration = self.typed_duration or self.battle.duration

		Manager.save_battles()
	end
end

--- @param self holding_points.node.Form.BattlesTab.BattleForm
BattleForm.on_close(function(self)
	self.form:open()
end)


return BattleForm:register()
