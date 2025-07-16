

--- Swaps node if node is not same and return old node name.
--- @see minetest.swap_node (https://dev.minetest.net/minetest.swap_node)
---
--- @private
--- @param position  Position position of node
--- @param node_name string   technical node name (`"<mod>:<name>"`, for ex. `"default:dirt"`)
--- @return string old node name.
function minetest.swap_node_if_not_same(position, node_name)
	local node = minetest.get_node(position)
	if node.name ~= node_name then
		node.name = node_name
		minetest.swap_node(position, node)
	end

	return node.name
end
