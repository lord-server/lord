
--- @class base_classes.Form.Mixin.ForNode: base_classes.Form.Mixin
local ForNode = {
	--- @protected
	--- @type Position
	node_position = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type NodeMetaRef
	node_meta     = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- @static
--- @param class base_classes.Form.Base
function ForNode.mix_to(class)
	--- @param self base_classes.Form.Mixin.ForNode
	--- @param _    Player
	--- @param pos  Position
	class.on_instance(function(self, _, pos)
		self.node_position = pos
		self.node_meta     = minetest.get_meta(pos)
	end)
end


return ForNode
