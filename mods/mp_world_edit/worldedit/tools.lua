-- Admin tools

minetest.register_tool("worldedit:admin_stick", {
	description = "Admins Magic Stick",
	inventory_image = "tool_magic_stick.png",
	range = 7,
   on_use = function(itemstack, user, pointed_thing)
	    -- Must be pointing to facedir applicable node
	    if pointed_thing.type~="node" then return end
	    local user_name = user:get_player_name()
	    local can_access = minetest.get_player_privs(user_name).worldedit
	    if not can_access then return end 
	    local pos=minetest.get_pointed_thing_position(pointed_thing,false)
	    local node=minetest.env:get_node(pos)
	    local node_name=node.name
		local pressed = user:get_player_control()
	    
		if pointed_thing.type == "node" then
			if pressed.aux1 then  -- если нажата клавиша использовать

				--local max_nodes = 200
				--for i = 2, max_nodes do
					--pos.y = pos.y - 1
					--local node_below = minetest.get_node(pos)
					--if node_below ~= nil then
						--if node_below.name == "air" then
							--minetest.set_node(pos, {name = "default:stone"})
						--else
							--break
						--end
					--end
				--end
		
			else
				minetest.env:remove_node(pointed_thing.under)
			end
		elseif pointed_thing.type == "object" then
			obj = pointed_thing.ref
			if obj ~= nil then
				if (obj:get_player_name() ~= nil) and (obj:get_player_name() ~= "") then
					-- Player
					obj:set_hp(-1)
				else
					-- Mob or other entity
					obj:remove()
				end
			end
		end
	    --minetest.set_node(pos,{name="air"})
    end,
	on_place = function(itemstack, placer, pointed_thing)
	    local user_name = placer:get_player_name()
	    local can_access = minetest.get_player_privs(user_name).worldedit
	    if (not can_access) or (pointed_thing.type ~= "node") then 
			return itemstack
		end 
	    local pos=minetest.get_pointed_thing_position(pointed_thing,true)
		local max_nodes = 200
		local item = placer:get_inventory():get_stack("main", placer:get_wield_index()+1)
		local item_name = item:get_name()
		local item_type = item:get_definition().type
		
		if item_type ~= "node" then
			return itemstack
		end	
		
		minetest.set_node(pointed_thing.above, {name=item_name})
		for i = 2, max_nodes do
			pos.y = pos.y - 1
			local node_below = minetest.get_node(pos)
			if node_below ~= nil then
				if node_below.name == "air" then
					minetest.set_node(pos, {name = item_name})
				else
					break
				end
			end
		end
		return itemstack
	end,
	stack_max = 1,
	liquids_pointable = true,
	    
})

minetest.register_tool("worldedit:pick_admin", {
	description = "Admins Pickaxe",
	privs = {worldedit=true},
	inventory_image = "tool_admin_pick.png",
	range = 10,
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3},
			crumbly = {times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3},
			choppy={times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3},
			snappy={times={[1]=0.05, [2]=0.02, [3]=0.01}, uses=0, maxlevel=3},
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=100, maxlevel=3},
			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	on_use = function(itemstack, user, pointed_thing)
	    local user_name = user:get_player_name()
	    local can_access = minetest.get_player_privs(user_name).worldedit
	    if not can_access then return end 
	    local pos=minetest.get_pointed_thing_position(pointed_thing,false)
	    if pos == nil then return end
	    local node=minetest.env:get_node(pos)
		if pointed_thing.type == "node" and pos ~= nil then
			minetest.node_dig(pos, node, user)
		elseif pointed_thing.type == "object" then
			obj = pointed_thing.ref
			if obj ~= nil then
				if (obj:get_player_name() ~= nil) and (obj:get_player_name() ~= "") then
					-- Player
					obj:set_hp(-1)
				else
					-- Mob or other entity
					obj:remove()
				end
			end
		end

		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

