local S     = minetest.get_mod_translator()
local spec  = forms.Spec
local e     = spec.escape


local SMALL = { font_size = '-1' } -- Style for formspec

--- @class holding_points.node.Form: base_classes.Form.Base
--- @field node_position Position
--- @field node_meta NodeMetaRef
local Form = base_classes.Form:personal():for_node():extended({
	--- @type string
	NAME     = 'holding_points:node',
	--- @type {x:number, y:number}
	padding  = { x = 0.5, y = 0.5 },
	--- @type {x:number, y:number} size without paddings
	size     = { x = 10 - 0.25, y = 11.25 }, -- `0.25` - spacing between slots of `list`, it present after last slot too.
	--- @type number
	fields_h = 0.65,
	--- @type number
	row_h    = 0.9,
	--- @type number
	center_x = nil,
	--- @type boolean
	in_event_list = nil
})

--- just pre-calculate center_x of the form
function Form:instantiate()
	self.center_x = self.padding.x + self.size.x / 2
end

--- @param row number form row number
--- @return string
function Form:get_row_center_y(row)
	return self.padding.y + row * self.row_h + self.row_h / 2
end

--- @param row number form row number
--- @return string
function Form:get_row_start_y(row)
	return self.padding.y + row * self.row_h
end

--- @private
--- @param row         number form row number
--- @param label       string
--- @param description string
--- @return string
function Form:described_label(row, label, description)
	local row_center_y = self:get_row_center_y(row)

	return ''
		.. spec.label(self.padding.x, row_center_y - 0.14, label)
		.. spec.muted(self.padding.x, row_center_y + 0.14, description, SMALL)
end

--- @private
--- @return string
function Form:labeled_field(row, name, value, label, description)
	return ''
		.. self:described_label(row, label, description)
		.. spec.field(
			self.center_x, self.padding.y + row * self.row_h + (self.row_h - self.fields_h) / 2,
			self.size.x / 2, self.fields_h,
			name, '', value
		)
end

--- @private
--- @param row         number form row number
--- @param name        string
--- @param selected    boolean
--- @param label       string
--- @param description string
--- @return string
function Form:labeled_checkbox(row, name, selected, label, description)
	local row_center_y = self:get_row_center_y(row)

	return ''
		.. self:described_label(row, label, description)
		.. spec.checkbox(self.center_x, row_center_y, name, '', selected)
end

--- @private
--- @param row         number
--- @param is_yes      boolean
--- @param label       string
--- @param description string
--- @return string
function Form:labeled_boolean_ro(row, is_yes, label, description)
	return ''
		.. self:described_label(row, label, description)
		.. spec.bold(self.center_x, self:get_row_center_y(row), is_yes and S('Yes') or S('No'))
end

--- @private
--- @param row           number
--- @param datetime    number timestamp
--- @param label       string
--- @param description string
--- @return string
function Form:labeled_datetime_ro(row, datetime, label, description)
	local row_center = {
		x = self.center_x,
		y = self:get_row_center_y(row)
	}

	return ''
		.. self:described_label(row, label, description)
		.. spec.bold(row_center.x, row_center.y, datetime and '-' or e(os.date('%d.%m.%Y %H:%M:%S', datetime)))
end

--- @private
--- @return string
function Form:get_spec()
	local name             = self.node_meta:get_string('name')
	local in_event_list    = self.in_event_list == nil
		and (self.node_meta:get_int('in_event_list') == 1)
		or  self.in_event_list
	local active            = self.node_meta:get_int('active') == 1
	local last_activated_at = self.node_meta:get_int('last_activated_at')

	return ''
		.. spec.formspec_version(4)
		.. spec.size(self.size.x + 2 * self.padding.x, self.size.y + 2 * self.padding.y)
		.. self:labeled_field(0, 'input_name', name, S('Name'), S('This name will be shown for players'))
		.. self:labeled_checkbox(1, 'in_event_list', in_event_list, S('Participates in future battles'), S('Description'))
		.. self:labeled_boolean_ro(2, active, S('Active now'), S('Right now the battle is going on for this point.'))
		.. self:labeled_datetime_ro(
			3, last_activated_at,
			S('Last activate at'), S('Date of the block\'s last participation in battle')
		)
		.. spec.button_exit(self.center_x - 2/2, self:get_row_start_y(4), 2, self.fields_h, 'save', S('Save'))
		.. spec.label(self.padding.x, self:get_row_start_y(5) - 0.25, S('Reward'))
		.. spec.node_inventory(self.padding.x, self:get_row_start_y(5), 8, 1, self.node_position, 'reward')
		.. spec.player_inventory(self.padding.x, self:get_row_start_y(5) + 0.2 + 1.5, 8, 1)
end

--- @param fields table
function Form:handle(fields)
	if fields.in_event_list then
		-- just remember current value of checkbox for future saving by `Save` button
		self.in_event_list = minetest.is_yes(fields.in_event_list)
	end
	if not fields.save then
		return
	end

	self.node_meta:set_string('name', fields.input_name)
	self.node_meta:set_int('in_event_list', self.in_event_list and 1 or 0)
end


return Form:register()
