local MainTab    = require('holding_points.node.Form.MainTab')
local MetaTab    = require('holding_points.node.Form.MetaTab')
local BattlesTab = require('holding_points.node.Form.BattlesTab')

local S    = minetest.get_mod_translator()
local spec = forms.Spec
local e    = spec.escape


local SMALL = { font_size = '-1' } -- Style for formspec

--- @class holding_points.node.Form: base_classes.Form.Base
--- @field node_position Position
--- @field node_meta NodeMetaRef
local Form = base_classes.Form:personal():for_node():with_tabs({ MAIN = 1, META = 2, BATTLE = 3 }):extended({
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
})

--- just pre-calculate center_x of the form
function Form:instantiate()
	self.center_x = self.padding.x + self.size.x / 2

	self
		:add_tab(MainTab:new(self))
		:add_tab(MetaTab:new(self))
		:add_tab(BattlesTab:new(self))
end

--- @protected
--- @return string
function Form:get_spec_head()
	return ''
		.. spec.formspec_version(4)
		.. spec.size(self.size.x + 2 * self.padding.x, self.size.y + 2 * self.padding.y)
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
	local field_padding = (self.row_h - self.fields_h) / 2

	return ''
		.. self:described_label(row, label, description)
		.. spec.field(
			self.center_x, self:get_row_start_y(row) + field_padding,
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
--- @param row         number
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

--- @param row         number
--- @param name        table
--- @param list        table
--- @param selected    number
--- @param label       string
--- @param description string
function Form:labeled_dropdown(row, name, list, selected, label, description)
	local row_start_y   = self:get_row_start_y(row)
	local field_padding = (self.row_h - self.fields_h) / 2

	return ''
		.. self:described_label(row, label, description)
		.. spec.dropdown_WH(
			self.center_x, row_start_y + field_padding, self.size.x / 2,  self.fields_h, name, list, selected
		)
end


return Form:register()
