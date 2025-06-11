local S    = minetest.get_mod_translator()
local spec = forms.Spec


--- @class holding_points.node.Form.MetaTab: base_classes.Form.Element.Tab
local MetaTab = {
	title = S('Meta'),
	--- @type holding_points.node.Form parent form
	form  = nil,
}
MetaTab = base_classes.Form.Element.Tab:extended(MetaTab)


--- @return string
function MetaTab:get_spec()
	local fields = self.form.node_meta:to_table().fields

	return ''
		.. spec.box(.75, 1, 9, 9, '#000')
		.. spec.area_ro(.75, 1, 9, 9, minetest.write_json(fields, true))
end

--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function MetaTab:handle(fields)
	return
end


return MetaTab
