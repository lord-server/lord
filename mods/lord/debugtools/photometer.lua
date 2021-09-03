local S = minetest.get_translator("debugtools")

minetest.register_tool("debugtools:photometer", {
	description = S("Photometer"),
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, user, pointed_thing)
		local user_name = user:get_player_name()
		if pointed_thing.type ~= "node" then
			return
		end

		local pos = minetest.get_pointed_thing_position(pointed_thing, true)
		local light = minetest.get_node_light(pos)
		minetest.chat_send_player(user_name, S("Light at").." "..pos.x.." "..pos.y.." "..pos.z.." = "..light)
		return itemstack
	end,
	group = {},
})

