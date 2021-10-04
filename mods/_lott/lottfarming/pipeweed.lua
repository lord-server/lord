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
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:pipeweed_cooked", {
	description = S("Cooked Pipeweed"),
	inventory_image = "lottfarming_pipeweed_cooked.png",
	groups = {flammable = 2},
})

local pipeweed = {
	{"lottfarming:pipeweed_cooked"},
}

minetest.register_tool("lottfarming:pipe", {
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
			end
			local pos = player:getpos()
			local dir = player:get_look_dir()
			minetest.add_particle({
				pos = {x=pos.x,y=pos.y+1.5,z=pos.z},
				vel = {x=dir.x*.3, y=.2, z=dir.z*.3},
				acc = {x=dir.x*.01, y=.1, z=dir.z*.01},
				expirationtime = 5,
				size = .75,
				collisiondetection = false,
				vertical = false,
				texture = "lottfarming_smoke_ring.png",
			})
			lottachievements.unlock(player:get_player_name(), "smoke_rings")
		end
	end
})
