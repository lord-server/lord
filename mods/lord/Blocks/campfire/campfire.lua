--[[ This make from Minetest mod "New Campfire"
======================

# License of source code:
- Copyright (C) 2017 Pavel Litvinoff <googolgl@gmail.com>

- Authors of media (contained_campfire.obj) and (campfire.png) files:
- Nathan Salapat

- License of media (models): CC BY-SA

# Notice:
- This mod is only useable with Minetest 0.4.16 or above!

# Description:
- You can craft and use better campfire.
]]--

local S = minetest.get_translator("campfire")

-- VARIABLES
local campfire_cooking    = 1;                -- nil - not cooked, 1 - cooked
local campfire_limit      = 1;                -- nil - unlimited campfire, 1 - limited
local campfire_ttl        = 90;               -- Time in sec
local campfire_stick_time = campfire_ttl / 2; -- How long does the stick increase. In sec.

-- FUNCTIONS
local function fire_particles_on(pos)
	local meta = minetest.get_meta(pos)

	-- 3 layers of fire
	local id

	id = minetest.add_particlespawner({ -- 1 layer big particles fire
		amount             = 12,
		time               = 1.3,
		minpos             = { x = pos.x - 0.2, y = pos.y - 0.4, z = pos.z - 0.2 },
		maxpos             = { x = pos.x + 0.2, y = pos.y - 0.1, z = pos.z + 0.2 },
		minvel             = { x = 0, y = 0, z = 0 },
		maxvel             = { x = 0, y = 0.1, z = 0 },
		minacc             = { x = 0, y = 0, z = 0 },
		maxacc             = { x = 0, y = 0.7, z = 0 },
		minexptime         = 0.5,
		maxexptime         = 0.7,
		minsize            = 3,
		maxsize            = 5,
		collisiondetection = false,
		vertical           = true,
		texture            = "campfire_anim_fire.png^[opacity:170",
		animation          = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8, },
	})
	meta:set_int("layer_1", id)

	id = minetest.add_particlespawner({ -- 2 layer smol particles fire
		amount             = 4,
		time               = 1.3,
		minpos             = { x = pos.x - 0.1, y = pos.y - 0.1, z = pos.z - 0.1 },
		maxpos             = { x = pos.x + 0.1, y = pos.y + 0.4, z = pos.z + 0.1 },
		minvel             = { x = 0, y = 0.30, z = 0 },
		maxvel             = { x = 0, y = 0.35, z = 0 },
		minacc             = { x = 0, y = 0.9, z = 0 },
		maxacc             = { x = 0, y = 1.5, z = 0 },
		minexptime         = 1,
		maxexptime         = 1,
		minsize            = 0.5,
		maxsize            = 0.7,
		collisiondetection = false,
		vertical           = true,
		texture            = "campfire_anim_fire.png",
		animation          = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.1, },
	})
	meta:set_int("layer_2", id)

	id = minetest.add_particlespawner({ --3 layer smoke
		amount             = 10,
		time               = 1,
		minpos             = { x = pos.x - 0.1, y = pos.y - 0.0, z = pos.z - 0.1 },
		maxpos             = { x = pos.x + 0.2, y = pos.y + 0.4, z = pos.z + 0.2 },
		minvel             = { x = 0, y = 0.5, z = 0 },
		maxvel             = { x = 0, y = 0.5, z = 0 },
		minacc             = { x = 0, y = 0.5, z = 0 },
		maxacc             = { x = 0, y = 0.9, z = 0 },
		minexptime         = 5,
		maxexptime         = 5,
		minsize            = 4,
		maxsize            = 6,
		collisiondetection = true,
		vertical           = true,
		texture            = "campfire_anim_smoke.png^[opacity:160",
		animation          = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.1, },
	})
	meta:set_int("layer_3", id)
end

local function fire_particles_off(pos)
	local meta = minetest.get_meta(pos)
	local id_1 = meta:get_int("layer_1");
	local id_2 = meta:get_int("layer_2");
	local id_3 = meta:get_int("layer_3");
	minetest.delete_particlespawner(id_1)
	minetest.delete_particlespawner(id_2)
	minetest.delete_particlespawner(id_3)
end

local function indicator(maxVal, curVal)
	local percent_val = math.floor(curVal / maxVal * 100)
	local progress    = ""
	local v           = percent_val / 10
	for k = 1, 10 do
		if v > 0 then
			progress = progress .. "▓"
		else
			progress = progress .. "▒"
		end
		v = v - 1
	end
	return "\n" .. progress .. " " .. percent_val .. "%"
end

local function effect(pos, texture, vlc, acc, time, size)
	minetest.add_particle({
		pos                = pos,
		velocity           = vlc,
		acceleration       = acc,
		expirationtime     = time,
		size               = size,
		collisiondetection = true,
		vertical           = true,
		texture            = texture,
	})
end

local function infotext_edit(meta)
	local infotext = S("Active campfire")

	if campfire_limit and campfire_ttl > 0 then
		local it_val = meta:get_int("it_val");
		infotext     = infotext .. indicator(campfire_ttl, it_val)
	end

	local cooked_time = meta:get_int('cooked_time');
	if campfire_cooking and cooked_time ~= 0 then
		local cooked_cur_time = meta:get_int('cooked_cur_time');
		infotext              = infotext .. "\n" .. S("Cooking") .. indicator(cooked_time, cooked_cur_time)
	end

	meta:set_string('infotext', infotext)
end

local function cooking(pos, itemstack, player)
	local meta      = minetest.get_meta(pos)
	local cooked, _ = minetest.get_craft_result({ method = "cooking", width = 1, items = { itemstack } })
	local cookable  = cooked.time ~= 0

	if cookable and campfire_cooking then
		local eat_y = ItemStack(cooked.item:to_table().name):get_definition().on_use
		if string.find(minetest.serialize(eat_y), "do_item_eat") and meta:get_int("cooked_time") == 0 then
			meta:set_int('cooked_time', cooked.time);
			meta:set_int('cooked_cur_time', 0);
			local name    = itemstack:to_table().name
			local texture = itemstack:get_definition().inventory_image

			infotext_edit(meta)

			effect(
				{ x = pos.x, y = pos.y + 0.4, z = pos.z },
				texture,
				{ x = 0, y = -1 / cooked.time, z = 0 },
				{ x = 0, y = 0, z = 0 },
				cooked.time / 2,
				4
			)

			minetest.after(cooked.time / 2, function()
				if meta:get_int("it_val") > 0 then
					effect(
						{ x = pos.x, y = pos.y - 0.1, z = pos.z },
						texture,
						{ x = 0, y = 1 / cooked.time, z = 0 },
						{ x = 0, y = 0, z = 0 },
						cooked.time / 2,
						4
					)

					local item = cooked.item:to_table().name

					minetest.after(cooked.time / 2, function(item) -- luacheck: ignore item
						if meta:get_int("it_val") > 0 then
							minetest.add_item({ x = pos.x, y = pos.y + 0.5, z = pos.z }, item)
							meta:set_int('cooked_time', 0);
							meta:set_int('cooked_cur_time', 0);
						else
							minetest.add_item({ x = pos.x, y = pos.y + 0.5, z = pos.z }, name)
						end
					end, item)
				else
					minetest.add_item({ x = pos.x, y = pos.y + 0.5, z = pos.z }, name)
				end
			end)

			if not minetest.is_creative_enabled(player) then
				itemstack:take_item()
				return itemstack
			end
		end
	end
end

-- NODES
minetest.register_node('campfire:fireplace', {
	description         = S("Fireplace"),
	drawtype            = 'mesh',
	mesh                = 'contained_campfire_empty.obj',
	tiles               = { name = '[combine:16x16:0,0=campfire_cobble.png' },
	walkable            = false,
	buildable_to        = false,
	sunlight_propagates = false,
	paramtype           = 'light',
	groups              = { dig_immediate = 3, flammable = 0, not_in_creative_inventory = 1 },
	selection_box       = {
		type  = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, -0.4, 0.48 },
	},
	sounds              = default.node_sound_stone_defaults(),
	drop                = { max_items = 3, items = { { items = { "stairs:slab_cobble 3" } } } },

	on_construct        = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', S("Fireplace"));
	end,
})

minetest.register_node('campfire:campfire', {
	description         = S("Campfire"),
	drawtype            = 'mesh',
	mesh                = 'contained_campfire.obj',
	--	mesh = 'contained_campfire_empty.obj',
	tiles               = { name = '[combine:16x16:0,0=default_cobble.png:0,8=default_wood.png' },
	inventory_image     = "campfire.png",
	wield_image         = "[combine:16x16:0,0=fire_basic_flame.png:0,12=default_cobble.png",
	walkable            = false,
	buildable_to        = false,
	sunlight_propagates = true,
	groups              = { dig_immediate = 3, flammable = 0 },
	paramtype           = 'light',
	selection_box       = {
		type  = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, -0.4, 0.48 },
	},
	--	sounds = default.node_sound_stone_defaults(),

	on_construct        = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', S("Campfire"));
	end,

	on_rightclick       = function(pos, node, player, itemstack, pointed_thing)
		if itemstack:get_name() == "default:torch" then
			minetest.sound_play("fire_flint_and_steel", { pos = pos, gain = 0.5, max_hear_distance = 8 })
			minetest.set_node(pos, { name = 'campfire:campfire_active' })
			minetest.add_particle({
				pos                = { x = pos.x, y = pos.y, z = pos.z },
				velocity           = { x = 0, y = 0.1, z = 0 },
				acceleration       = { x = 0, y = 0, z = 0 },
				expirationtime     = 2,
				size               = 4,
				collisiondetection = true,
				vertical           = true,
				texture            = "campfire_anim_smoke.png",
				animation          = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.5, },
			})
		end
	end,
})

minetest.register_node('campfire:campfire_active', {
	description         = S("Active campfire"),
	drawtype            = 'mesh',
	mesh                = 'contained_campfire.obj',
	tiles               = { name = '[combine:16x16:0,0=campfire_cobble.png:0,8=campfire_wood.png' },
	inventory_image     = "campfire.png",
	wield_image         = "[combine:16x16:0,0=fire_basic_flame.png:0,12=default_cobble.png",
	walkable            = false,
	buildable_to        = false,
	sunlight_propagates = true,
	groups              = { oddly_breakable_by_hand = 3, flammable = 0, not_in_creative_inventory = 1, igniter = 1 },
	--	paramtype = 'light',
	paramtype           = 'none',
	light_source        = 13,
	damage_per_second   = 3,
	drop                = "campfire:campfire",
	--    sounds = default.node_sound_stone_defaults(),
	selection_box       = {
		type  = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, -0.4, 0.48 },
	},

	on_rightclick       = function(pos, node, player, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		cooking(pos, itemstack, player)
		if itemstack:get_definition().groups.stick == 1 then
			local it_val = meta:get_int("it_val") + (campfire_stick_time);
			meta:set_int('it_val', it_val);
			effect(
				{ x = pos.x, y = pos.y + 0.4, z = pos.z },
				"default_stick.png",
				{ x = 0, y = -1, z = 0 },
				{ x = 0, y = 0, z = 0 },
				1,
				6
			)

			if not minetest.is_creative_enabled(player) then
				itemstack:take_item()
				return itemstack
			end
		end
	end,

	on_construct        = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int('it_val', campfire_ttl);
		infotext_edit(meta)
		minetest.get_node_timer(pos):start(2)
	end,

	on_destruct         = function(pos, oldnode, oldmetadata, digger)
		fire_particles_off(pos)
		local meta   = minetest.get_meta(pos)
		local handle = meta:get_int("handle")
		minetest.sound_stop(handle)
	end,

	on_timer            = function(pos)
		-- Every 6 seconds play sound fire_small
		local meta   = minetest.get_meta(pos)
		local handle = minetest.sound_play("fire_small", { pos = pos, max_hear_distance = 18, loop = false, gain = 0.1 })
		meta:set_int("handle", handle)
		minetest.get_node_timer(pos):start(6)
	end,
})

-- ABM
minetest.register_abm({
	nodenames = { "campfire:campfire_active" },
	--  neighbors = {"group:puts_out_fire"},
	interval  = 1.0, -- Run every 1 seconds
	chance    = 1, -- Select every 1 in 1 nodes
	catch_up  = false,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local fpos = minetest.find_nodes_in_area(
			{ x = pos.x - 1, y = pos.y, z = pos.z - 1 },
			{ x = pos.x + 1, y = pos.y + 1, z = pos.z + 1 },
			{ "group:water" }
		)
		if #fpos > 0 then
			minetest.set_node(pos, { name = 'campfire:campfire' })
			minetest.sound_play("fire_extinguish_flame", { pos = pos, max_hear_distance = 16, gain = 0.15 })
		else
			local meta   = minetest.get_meta(pos)
			local it_val = meta:get_int("it_val") - 1;

			if campfire_limit and campfire_ttl > 0 then
				if it_val <= 0 then
					minetest.remove_node(pos)
					minetest.set_node(pos, { name = 'campfire:fireplace' })
					minetest.add_item(pos, "campfire:ash")
					return
				end
				meta:set_int('it_val', it_val);
			end

			if campfire_cooking then
				if meta:get_int('cooked_cur_time') <= meta:get_int('cooked_time') then
					meta:set_int('cooked_cur_time', meta:get_int('cooked_cur_time') + 1);
				else
					meta:set_int('cooked_time', 0);
					meta:set_int('cooked_cur_time', 0);
				end
			end
			infotext_edit(meta)
			fire_particles_on(pos)
		end
	end
})

-- CRAFTS
minetest.register_craft({
	output = "campfire:campfire",
	recipe = {
		{ 'stairs:slab_cobble', 'lord_homedecor:sticks', 'stairs:slab_cobble' },
		{ '', 'stairs:slab_cobble', '' },
	}
})

-- ITEMS
minetest.register_craftitem("campfire:ash", {
	description     = S("Ash"),
	inventory_image = "campfire_ash.png"
})
