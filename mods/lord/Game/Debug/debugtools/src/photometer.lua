local S = core.get_mod_translator()

core.register_tool("debugtools:photometer", {
	description = S("Photometer"),
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, user, pointed_thing)
		local user_name = user:get_player_name()
		if pointed_thing.type ~= "node" then
			return
		end

		local pos = core.get_pointed_thing_position(pointed_thing, true)
		local light = core.get_node_light(pos)
		core.chat_send_player(user_name, S("Light at").." "..pos.x.." "..pos.y.." "..pos.z.." = "..light)
		return itemstack
	end,
	group = {},
})

