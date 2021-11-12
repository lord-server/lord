<<<<<<< HEAD
local S = lottfarming.get_translator

farming.register_plant("lottfarming:pipeweed", {
	harvest_name = "lottfarming:pipeweed",
	description = S("Pipeweed Seed"),
	harvest_description = S("Pipeweed"),
	seed_inv_img = "lottfarming_seed_pipeweed.png",
	groups = {},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:pipeweed_cooked", {
	description = S("Cooked Pipeweed"),
=======
minetest.register_craftitem("lottfarming:pipeweed_seed", {
	description = "Pipeweed Seeds",
	inventory_image = "lottfarming_pipeweed_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:pipeweed_1", 34)
	end,
})

minetest.register_node("lottfarming:pipeweed_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_pipeweed_1.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_pipeweed_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_pipeweed_3.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_4", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_pipeweed_4.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:pipeweed_seed'} },
			{ items = {'lottfarming:pipeweed_seed'}, rarity = 2},
			{ items = {'lottfarming:pipeweed_seed'}, rarity = 5},
			{ items = {'lottfarming:pipeweed'} },
			{ items = {'lottfarming:pipeweed'}, rarity = 2 },
			{ items = {'lottfarming:pipeweed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:pipeweed", {
	description = "Pipeweed",
	inventory_image = "lottfarming_pipeweed.png",
})

farming:add_plant("lottfarming:pipeweed_4", {"lottfarming:pipeweed_1", "lottfarming:pipeweed_2", "lottfarming:pipeweed_3"}, 50, 20, 34)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:pipeweed_cooked",
	recipe = "lottfarming:pipeweed"
})

minetest.register_craftitem("lottfarming:pipeweed_cooked", {
	description = "Cooked Pipeweed",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	inventory_image = "lottfarming_pipeweed_cooked.png",
	groups = {flammable = 2},
})

<<<<<<< HEAD
local pipeweed = {
=======
minetest.register_craft({
	output = 'lottfarming:pipe',
	recipe = {
		{'', '', 'group:stick'},
		{'group:wood', 'group:stick', ''},
		{'group:stick', '', ''},
	}
})

pipeweed = {
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	{"lottfarming:pipeweed_cooked"},
}

minetest.register_tool("lottfarming:pipe", {
<<<<<<< HEAD
	description = S("Pipe"),
	inventory_image = "lottfarming_pipe.png",
    on_use = function(itemstack, player)
		for _, arrow in ipairs(pipeweed) do
			if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() ==  arrow[1] then
				player:set_hp(player:get_hp()+2)
				if not minetest.setting_getbool("creative_mode") then
					player:get_inventory():remove_item("main", arrow[1])
				end
				local pos = player:getpos()
				local dir = player:get_look_dir()
				minetest.add_particle({
					pos = {x = pos.x,y = pos.y + 1.5,z = pos.z},
					vel = {x = dir.x * .3, y = .2, z = dir.z * .3},
					acc = {x = dir.x * .01, y = .1, z = dir.z * .01},
					expirationtime = 5,
					size = .75,
					collisiondetection = false,
					vertical = false,
					texture = "lottfarming_smoke_ring.png",
				})
				-- временно отложено здесь будет вызов функции для триггера со счетчиком
				--lottachievements.unlock(player:get_player_name(), "smoke_rings")
=======
	description = "Pipe",
	inventory_image = "lottfarming_pipe.png",
     on_use = function(itemstack, player)
     for _,arrow in ipairs(pipeweed) do
          if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == arrow[1] then
               player:set_hp(player:get_hp()+2)
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", arrow[1])
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
			end
			local pos = player:getpos()
			local dir = player:get_look_dir()
			minetest.add_particle({
<<<<<<< HEAD
				pos = {x=pos.x,y=pos.y+1.5,z=pos.z},
				vel = {x=dir.x*.3, y=.2, z=dir.z*.3},
				acc = {x=dir.x*.01, y=.1, z=dir.z*.01},
				expirationtime = 5,
				size = .75,
				collisiondetection = false,
				vertical = false,
				texture = "lottfarming_smoke_ring.png",
=======
   				pos = {x=pos.x,y=pos.y+1.5,z=pos.z},
    			vel = {x=dir.x*.3, y=.2, z=dir.z*.3},
  	 			acc = {x=dir.x*.01, y=.1, z=dir.z*.01},
  		  		expirationtime = 5,
    			size = .75,
    			collisiondetection = false,
    			vertical = false,
    			texture = "lottfarming_smoke_ring.png",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
			})
			lottachievements.unlock(player:get_player_name(), "smoke_rings")
		end
	end
end})
