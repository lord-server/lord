local S = minetest.get_mod_translator()


--- @class holding_points.node.Form.MetaTab: base_classes.Form.Element.Tab
local MetaTab = {
	title = S('Meta'),
	--- @type holding_points.node.Form parent form
	form  = nil,
}
MetaTab = base_classes.Form.Element.Tab:extended(MetaTab)



function MetaTab:get_spec()
	return ''
end

--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function MetaTab:handle(fields)
	return
end


return MetaTab
