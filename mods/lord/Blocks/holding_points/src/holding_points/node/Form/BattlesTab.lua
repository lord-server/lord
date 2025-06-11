local S = minetest.get_mod_translator()


--- @class holding_points.node.Form.BattlesTab: base_classes.Form.Element.Tab
local BattlesTab = {
	title = S('Battle'),
	--- @type holding_points.node.Form parent form
	form  = nil,
}
BattlesTab = base_classes.Form.Element.Tab:extended(BattlesTab)



function BattlesTab:get_spec()
	return ''
end

--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function BattlesTab:handle(fields)
	return
end


return BattlesTab
