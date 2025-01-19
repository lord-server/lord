local FieldType = require('mountgen.config.FieldType')

local spec     = minetest.formspec
local colorize = minetest.colorize


--- @class mountgen.config.Form.Builder
local Builder = {
	field_width = 4,
}

--- @protected
--- @param pos_y     number                          y position at Form.
--- @param field_def mountgen.config.FieldDefinition definition of field.
--- @param value     string|number                   current field value.
--- @return string
function Builder.render_input(pos_y, field_def, value)
	return ''
		.. spec.label(0.3, pos_y - 0.3, field_def.label)
		.. spec.field(3, pos_y, Builder.field_width, 0.5, field_def.name, '', value)
end

--- @protected
--- @param pos_y     number                          y position at Form.
--- @param field_def mountgen.config.FieldDefinition definition of field.
--- @param value     string|number                   current field value.
--- @return string
function Builder.render_dropdown(pos_y, field_def, value)
	local items    = field_def.list
	local selected = table.key_value_swap(items)[value]

	return ''
		.. spec.label(0.3, pos_y - 0.3, field_def.label)
		.. spec.dropdown_W(3 - 0.295, pos_y - 0.45, Builder.field_width + 0.190, field_def.name, items, selected)
end

--- @param pos_y     number                          y position at Form.
--- @param field_def mountgen.config.FieldDefinition definition of field.
--- @param value     string|number                   current field value.
--- @return string string with formspec of field to concatenate to formspec of form.
function Builder.render_field(pos_y, field_def, value)
	if field_def.type:is_one_of({ FieldType.NUMBER, FieldType.STRING }) then
		return Builder.render_input(pos_y, field_def, value)
	end
	if field_def.type == FieldType.ONE_OF then
		return Builder.render_dropdown(pos_y, field_def, value)
	end

	return ''
		.. spec.label(0.3, pos_y - 0.3, colorize('#f88', 'Render error:'))
		.. spec.label(2.7, pos_y - 0.3, colorize('#f88', 'Unknown field type "' .. field_def.type .. '"'))
end


return Builder
