local SL = lord.require_intllib()

minetest.register_node("castle:ropes",{
	description = SL("Rope"),
	drawtype = "nodebox",
	sunlight_propagates = true,
	tiles = {"castle_ropes.png"},
	use_texture_alpha = "clip",
	groups = {choppy=3,snappy=3,oddly_breakable_by_hand=3,flammable=1},
	paramtype = "light",
	climbable = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
		},
	},
})

minetest.register_craft({
	output = "castle:ropes",
	recipe = {
		{"farming:string"},
		{"farming:string"},
		{"farming:string"},
	}
})

minetest.register_node("castle:box_rope", {
    drawtype = "nodebox",
    paramtype = "light",
    sunlight_propagates = true,
    tiles = {"castle_ropes.png"},
    use_texture_alpha = "clip",
    groups = {not_in_creative_inventory=1},
    climbable = true,
    walkable = false,
    diggable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
		},
	},
    after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
        if node.name == "castle:box_rope" then
            minetest.remove_node({x=pos.x,y=pos.y-1,z=pos.z})
        end
    end,
})

minetest.register_node("castle:ropebox", {
    description = SL("Ropebox"),
    drawtype = "nodebox",
    sunlight_propagates = true,
    tiles = {"castle_ropebox_top.png",
             "castle_ropebox_top.png",
             "castle_ropebox_side_1.png",
             "castle_ropebox_side_1.png",
             "castle_ropebox_side_2.png",
             "castle_ropebox_side_2.png"},
    use_texture_alpha = "clip",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-2/16, -2/16, -4/16, 2/16, 2/16, 4/16},
			{-2/16, -4/16, -2/16, 2/16, 4/16, 2/16},
			{-2/16, -3/16, -3/16, 2/16, 3/16, 3/16},
			{-3/16, -2/16, -2/16, -2/16, 8/16, 2/16},
			{2/16, -2/16, -2/16, 3/16, 8/16, 2/16},
			{-1/16, -8/16, -1/16, 1/16, -4/16, 1/16},
		},
	},
    after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
        if node.name == "castle:box_rope" then
            minetest.remove_node({x=pos.x,y=pos.y-1,z=pos.z})
        end
    end,
})

minetest.register_abm({
	nodenames = {"castle:ropebox"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
	if minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name ~= 'air'  then return end
	        minetest.add_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="castle:box_rope"})
	end
})

minetest.register_abm({
	nodenames = {"castle:box_rope"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
	if minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name ~= 'air'  then return end
	        minetest.add_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="castle:box_rope"})
	end
})

minetest.register_craft({
	output = "castle:ropebox",
	recipe = {
		{"default:wood"},
		{"castle:ropes"},
	}
})
