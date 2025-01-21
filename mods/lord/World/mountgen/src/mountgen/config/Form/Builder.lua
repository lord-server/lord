local FieldType = require('mountgen.config.FieldType')

local spec     = minetest.formspec
local colorize = minetest.colorize


--- @class mountgen.config.Form.Builder
local Builder = {
	form_width  = 7,
	field_width = 4,
}

--- @param pos_y number
--- @return string
function Builder.size(pos_y)
	return spec.size(Builder.form_width, pos_y)
end

--- @static
--- @param x         number
--- @param y         number
--- @param text      string
--- @param font_size string
--- @return string
function Builder.title(x, y, text, font_size)
	return ''
		.. spec.style_type('label', { font = 'bold', font_size = font_size })
		.. spec.label(x, y, text)
		.. spec.style_type('label', { font = 'normal', font_size = '+0' })
end

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
	local tooltip = field_def.description
		and spec.tooltip(field_def.name, field_def.description)
		or ''

	if field_def.type:is_one_of({ FieldType.NUMBER, FieldType.STRING }) then
		return Builder.render_input(pos_y, field_def, value) .. tooltip
	end
	if field_def.type == FieldType.ONE_OF then
		return Builder.render_dropdown(pos_y, field_def, value) .. tooltip
	end

	return ''
		.. spec.label(0.3, pos_y - 0.3, colorize('#f88', 'Render error:'))
		.. spec.label(2.7, pos_y - 0.3, colorize('#f88', 'Unknown field type "' .. field_def.type .. '"'))
end

--- @protected
--- @param pos_y       number
--- @param description string
--- @return string, number
function Builder.render_group_description(pos_y, description)
	local size_y = 0.8

	local formspec = ''
		.. spec.style_type('textarea', { font_size = '-1', textcolor = '#bbb', })
		.. spec.textarea(0.4, pos_y - 0.15, Builder.form_width - 0.2, size_y + 0.25, spec.read_only, '', description)
		.. spec.style_type('textarea', { font_size = '+0', textcolor = '#fff', })

	return formspec, size_y
end

--- @param group mountgen.config.GroupDefinition
function Builder.render_group(group, pos_y, values)
	local start_pos = pos_y
	local formspec = ''
		.. spec.style_type('label', { font = 'bold', font_size = '-1', textcolor = '#ddd', })
		.. spec.label(0.05, pos_y - 0.6, group.label)
		.. spec.style_type('label', { font = 'normal', font_size = '+0', textcolor = '#ddd', })

	if group.description then
		local desc_spec, desc_height = Builder.render_group_description(pos_y, group.description)
		formspec = formspec .. desc_spec
		pos_y    = pos_y + desc_height
	end

	local fields_spec = ''
	pos_y = pos_y + 0.4
	for name, definition in pairs(group.definitions) do
		fields_spec = fields_spec .. Builder.render_field(pos_y, definition, values[name])
		pos_y       = pos_y + 0.8
	end
	pos_y = pos_y + 0.2

	formspec = formspec
		.. spec.box(0, start_pos - 0.2, Builder.form_width - 0.2, pos_y - start_pos - 0.4, '#0000003b')
		.. fields_spec
		.. spec.style_type('label', { textcolor = '#fff' })

	return pos_y, formspec
end


return Builder
