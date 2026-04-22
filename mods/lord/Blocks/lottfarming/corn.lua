local core_get_node, core_set_node
    = core.get_node, core.set_node

local S = core.get_mod_translator()

core.register_craftitem('lottfarming:corn_seed', {
	description     = S('Corn Seeds'),
	inventory_image = 'lottfarming_corn_seed.png',
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = core_get_node(ptu)
		if core.registered_nodes[nu.name].on_rightclick then
			return core.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, 'lottfarming:corn_1', 3)
	end,
})
core.register_craftitem('lottfarming:ear_of_corn', {
	description     = S('Ear of corn'),
	inventory_image = 'lottfarming_ear_of_corn.png',
	groups          = { salad = 1 },
	on_use          = core.item_eat(2),
	_tt_food_hp     = 2,
})
core.register_node('lottfarming:corn_1', {
	paramtype     = 'light',
	paramtype2    = 'meshoptions',
	walkable      = false,
	drawtype      = 'plantlike',
	drop          = '',
	tiles         = { 'lottfarming_corn_1.png' },
	waving        = 1,
	selection_box = {
		type  = 'fixed',
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 3 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_2', {
	paramtype     = 'light',
	paramtype2    = 'meshoptions',
	walkable      = false,
	drawtype      = 'plantlike',
	drop          = '',
	tiles         = { 'lottfarming_corn_2.png' },
	waving        = 1,
	selection_box = {
		type  = 'fixed',
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 3 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_3', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	drop       = '',
	tiles      = { 'lottfarming_corn_3.png' },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_4', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	drop       = '',
	tiles      = { 'lottfarming_corn_4.png' },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_21', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	drop       = '',
	tiles      = { 'lottfarming_corn_21.png' },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_22', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	drop       = '',
	tiles      = { 'lottfarming_corn_22.png' },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_23', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	tiles      = { 'lottfarming_corn_23.png' },
	waving     = 1,
	drop       = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:ear_of_corn' } },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 2 },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 5 },
		}
	},
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_31', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	drop       = '',
	tiles      = { 'lottfarming_corn_31.png' },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
core.register_node('lottfarming:corn_32', {
	paramtype  = 'light',
	paramtype2 = 'meshoptions',
	walkable   = false,
	drawtype   = 'plantlike',
	tiles      = { 'lottfarming_corn_32.png' },
	waving     = 1,
	drop       = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:ear_of_corn' } },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 2 },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 5 },
		}
	},
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})

core.register_craftitem('lottfarming:corn_baked', {
	description     = S('Baked Corn'),
	inventory_image = 'lottfarming_corn_baked.png',
	on_use          = core.item_eat(6),
	_tt_food_hp     = 6,
})
core.register_craft({
	type = 'cooking',
	cooktime = 10,
	output = 'lottfarming:corn_baked',
	recipe = 'lottfarming:ear_of_corn'
})


local chance   = 10
local interval = 45

--- TODO: remove after merged into `dev`
if not vector.above then
	--- Returns position above this one by `n` nodes.
	--- @param n? integer default is `1`
	--- @return self
	function vector:above(n) -- luacheck: ignore
		return self:offset(0, n or 1, 0)
	end
	--- Returns position below this one by `n` nodes.
	--- @param n? integer default is `1`
	--- @return self
	function vector:under(n) -- luacheck: ignore
		return self:offset(0, -(n or 1), 0)
	end
end
--- end of TODO

--- @param pos vector
--- @return boolean
local function is_enough_light(pos)
	local light = core.get_node_light(pos)

	return light ~= nil and light >= 8
end

--- @param pos vector
--- @param height? integer default is `1`
--- @return boolean
local function is_enough_space(pos, height)
	height = height or 1

	for i = 1, height do
		local node_name = core_get_node(pos:above(i)).name
		if node_name == 'air' or node_name:starts_with('lottfarming:corn_') then
			return true
		end
	end

	return false
end

--- @param pos vector
--- @param stage string
local function set_corn(stage, pos)
	core_set_node(pos, { name = 'lottfarming:corn_' .. stage, param2 = 3 })
end

core.register_abm({
	nodenames = 'lottfarming:corn_1',
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		if
			core_get_node(pos:under()).name ~= 'farming:soil_wet' or
			not is_enough_light(pos) or
			not is_enough_space(pos) or
			core_get_node(pos:above()).name ~= 'air' -- not necessary, but just in case
		then
			return
		end

		set_corn('2', pos)
	end
})
core.register_abm({
	nodenames = 'lottfarming:corn_2',
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		if
			core_get_node(pos:under()).name ~= 'farming:soil_wet' or
			not is_enough_light(pos) or
			not is_enough_space(pos)
		then
			return
		end
		set_corn('3', pos)
		set_corn('21', pos:above())
	end
})
core.register_abm({
	nodenames = 'lottfarming:corn_3',
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		if
			core_get_node(pos:under()).name ~= 'farming:soil_wet' or
			not is_enough_light(pos:above()) or
			not is_enough_light(pos:above(2)) or
			not is_enough_space(pos, 2)
		then
			return
		end

		set_corn('4', pos)
		set_corn('22', pos:above())
		set_corn('31', pos:above(2))
	end
})
core.register_abm({
	nodenames = 'lottfarming:corn_22', -- not corn_4, for infinite growth prevention
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		pos = pos:under() -- get the position of the corn_4 node
		if
			core_get_node(pos:under()).name ~= 'farming:soil_wet' or
			not is_enough_light(pos:above()) or
			not is_enough_light(pos:above(2)) or
			not is_enough_space(pos, 2)
		then
			return
		end

		set_corn('23', pos:above())
		set_corn('32', pos:above(2))
	end
})
