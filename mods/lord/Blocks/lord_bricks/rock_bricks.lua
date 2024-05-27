local S = minetest.get_translator(minetest.get_current_modname())

for node_name, registration in pairs(rocks.get_lord_nodes()) do
	local name = node_name:split(":")[2]
	local base_description = registration.original_description

	local def_brick        = table.copy(minetest.registered_nodes[node_name])
	local brick_name       = string.format("lord_bricks:%s_brick", name)
	def_brick.description  = S(string.format("%s Brick", base_description))
	def_brick.tiles        = { string.format("lord_bricks_$s_brick.png", name) }
	def_brick.groups.stone = nil
	def_brick.groups.rock  = nil
	def_brick.groups.brick = 1

	local def_block        = table.copy(minetest.registered_nodes[node_name])
	local block_name       = string.format("lord_bricks:%s_block", name)
	def_block.description  = S(string.format("%s Block", base_description))
	def_brick.tiles        = { string.format("lord_bricks_$s_block.png", name) }
	def_block.groups.stone = nil
	def_block.groups.rock  = nil

	for _, texture in ipairs(def_brick.tiles) do
		minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())
	end

	for _, texture in ipairs(def_block.tiles) do
		minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())
	end

	minetest.register_node(brick_name, def_brick)
	minetest.register_node(block_name, def_block)

	minetest.register_craft({
		type   = "shaped",
		output = brick_name .. " 4",
		recipe = {
			{ node_name, node_name, },
			{ node_name, node_name, },
		},
	})

	minetest.register_craft({
		type   = "shaped",
		output = block_name .. " 9",
		recipe = {
			{ node_name, node_name, node_name, },
			{ node_name, node_name, node_name, },
			{ node_name, node_name, node_name, },
		},
	})
end
