
--- @class base_classes.Form.Mixin.ForNode: base_classes.Form.Mixin
local ForNode = {
	--- @protected
	--- @type Position
	node_position = false,
	--- @protected
	--- @type NodeMetaRef
	node_meta     = false,
}

--- @static
--- @param class base_classes.Form.Base
function ForNode.mix_to(class)
	table.overwrite(class, ForNode)

	--- @param self base_classes.Form.Mixin.ForNode
	--- @param pos  Position
	class.on_instance(function(self, _, pos)
		self.node_position = pos
		self.node_meta     = minetest.get_meta(pos)
	end)
end


return ForNode
