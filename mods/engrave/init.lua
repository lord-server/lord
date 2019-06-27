SL = lord.require_intllib()

minetest.register_node("engrave:table", {
	description = SL("Engraving Table"),
	drawtype = "nodebox",
	tiles = {"lottblocks_birch_planks.png","engrave.png"},
	node_box = { type = "fixed", fixed = {
		{-6/16, -8/16, -6/16, 6/16, -7/16, 6/16}, -- bottom plate
		{-4/16, -7/16, -4/16, 4/16, -6/16, 4/16}, -- bottom plate (upper)
		{-0.2, -6/16, -0.2, 0.2, 7/16, 0.2}, -- pillar
		{-7/16, 7/16, -7/16, 7/16, 8/16, 7/16}, -- top plate
	}},
	groups = {choppy=2,flammable=3, oddly_breakable_by_hand=2},
	sounds = default and default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, player)
		local pname=player:get_player_name()
		local stack=player:get_wielded_item()
		if stack:get_count()==0 then
			minetest.chat_send_player(pname, SL("Please wield the item you want to name, and then click the engraving table again."))
			return
		end
		local idef=minetest.registered_items[stack:get_name()]
		if not idef then
			minetest.chat_send_player(pname, SL("You can't name an unknown item!"))
			return
		end
		local name=idef.description or stack:get_name()

		local meta=stack:get_meta()
		if meta then
			local metaname=meta:get_string("description")
			if metaname~="" then
				name=metaname
			end
		end
		local fieldtype = "field"
		minetest.show_formspec(
			pname,
			"engrave",
			"size[5.5,2.5]"..
			fieldtype..
			"[0.5,0.5;5,1;name;Введите новое имя:;"..name.."]"..
			"button_exit[1,1.5;3,1;ok;Готово]"..
			"background[-0.5,-0.65;9,10.35;gui_formbg.png;true]")
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname=="engrave" and fields.name and fields.ok then
		local pname=player:get_player_name()
		if #fields.name>60 then
			minetest.chat_send_player(pname, SL("Name is too long."))
			return
		end

		local stack=player:get_wielded_item()
		if stack:get_count()==0 then
			minetest.chat_send_player(pname, SL("Please wield the item you want to name, and then click the engraving table again."))
			return
		end
		local idef=minetest.registered_items[stack:get_name()]
		if not idef then
			minetest.chat_send_player(pname, SL("You can't name an unknown item!"))
			return
		end
		local name=idef.description or stack:get_name()

		local meta=stack:get_meta()
		if not meta then
			minetest.chat_send_player(pname, SL("For some reason, the stack metadata couldn't be acquired. Try again!"))
			return
		end

		if fields.name==name then
			meta:set_string("description", "")
		else
			meta:set_string("description", fields.name)
		end
		--write back
		player:set_wielded_item(stack)
	end
end)

minetest.register_craft({
	output = "engrave:table",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:steel_ingot", "group:stick", "default:steel_ingot"},
		{"group:wood", "group:stick", "group:wood"},
	},
})
