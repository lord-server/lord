local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:pipeweed_seed", {
	description     = SL("Pipeweed Seeds"),
	inventory_image = "lottfarming_pipeweed_seed.png",
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:pipeweed_1")
	end,
})

minetest.register_node("lottfarming:pipeweed_1", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_pipeweed_1.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 5 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_2", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	waving        = 1,
	tiles         = { "lottfarming_pipeweed_2.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 8 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_3", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	waving        = 1,
	tiles         = { "lottfarming_pipeweed_3.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 13 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_4", {
	paramtype = "light",
	walkable  = false,
	drawtype  = "plantlike",
	waving    = 1,
	tiles     = { "lottfarming_pipeweed_4.png" },
	drop      = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:pipeweed_seed' } },
			{ items = { 'lottfarming:pipeweed_seed' }, rarity = 2 },
			{ items = { 'lottfarming:pipeweed_seed' }, rarity = 5 },
			{ items = { 'lottfarming:pipeweed' } },
			{ items = { 'lottfarming:pipeweed' }, rarity = 2 },
			{ items = { 'lottfarming:pipeweed' }, rarity = 5 }
		}
	},
	groups    = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds    = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:pipeweed", {
	description     = SL("Pipeweed"),
	inventory_image = "lottfarming_pipeweed.png",
})

farming:add_plant(
	"lottfarming:pipeweed_4",
	{ "lottfarming:pipeweed_1", "lottfarming:pipeweed_2", "lottfarming:pipeweed_3" },
	50,
	20
)

minetest.register_craftitem("lottfarming:pipeweed_cooked", {
	description     = SL("Cooked Pipeweed"),
	inventory_image = "lottfarming_pipeweed_cooked.png",
})

minetest.register_craft({
	output = 'lottfarming:pipe',
	recipe = {
		{ '', '', 'group:stick' },
		{ 'group:wood', 'group:stick', '' },
		{ 'group:stick', '', '' },
	}
})

pipeweed = {
	{ "lottfarming:pipeweed_cooked" },
}

minetest.register_tool("lottfarming:pipe", {
	description     = SL("Pipe"),
	inventory_image = "lottfarming_pipe.png",
	on_use          = function(itemstack, player)
		for _, arrow in ipairs(pipeweed) do
			if player:get_inventory():get_stack("main", player:get_wield_index() + 1):get_name() == arrow[1] then
				player:set_hp(player:get_hp() + 2)
				if not minetest.is_creative_enabled(player) then
					player:get_inventory():remove_item("main", arrow[1])
				end
				local pos = player:get_pos()
				local dir = player:get_look_dir()
				minetest.add_particle({
					pos                = { x = pos.x, y = pos.y + 1.5, z = pos.z },
					vel                = { x = dir.x * .3, y = .2, z = dir.z * .3 },
					acc                = { x = dir.x * .01, y = .1, z = dir.z * .01 },
					expirationtime     = 5,
					size               = .75,
					collisiondetection = false,
					vertical           = false,
					texture            = "lottfarming_smoke_ring.png",
				})
				-- временно отложено здесь будет вызов функции для триггера со счетчиком
				--lottachievements.unlock(player:get_player_name(), "smoke_rings")
			end
		end
	end
})
