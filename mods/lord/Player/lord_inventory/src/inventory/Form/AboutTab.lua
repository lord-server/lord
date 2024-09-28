local S = minetest.get_translator('lord_inventory')


--- @class inventory.Form.AboutTab: base_classes.Form.Element.Tab
local AboutTab = base_classes.Form.Element.Tab:extended({
	title = S('About'),
})


function AboutTab:get_spec()
	return ''
end


return AboutTab
