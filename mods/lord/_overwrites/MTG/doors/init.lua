local S = minetest.get_translator("lord_overwrites_mtg_doors")

local function doors_register_old_doors_replace_abm(name)
	local overwrites_name = "lord_overwrites_mtg_doors:" .. string.gsub(name, "%S+:", "")

	-- copied from MTG/doors/init.lua in doors.register function and modified:
	-- replace old doors of this type automatically
	minetest.register_lbm({
		name = ":doors:replace_" .. name:gsub(":", "_"),
		nodenames = {name.."_b_1", name.."_b_2"},
		action = function(pos, node)
			local l = tonumber(node.name:sub(-1))
			local meta = minetest.get_meta(pos)
			local h = meta:get_int("right") + 1
			local p2 = node.param2
			local replace = {
				{{type = "a", state = 0}, {type = "a", state = 3}},
				{{type = "b", state = 1}, {type = "b", state = 2}}
			}
			local new = replace[l][h]
			-- retain infotext and doors_owner fields
			minetest.swap_node(pos, {name = overwrites_name .. "_" .. new.type, param2 = p2})
			meta:set_int("state", new.state)
			-- properly place doors:hidden at the right spot
			local p3 = p2
			if new.state >= 2 then
				p3 = (p3 + 3) % 4
			end
			if new.state % 2 == 1 then
				if new.state >= 2 then
					p3 = (p3 + 1) % 4
				else
					p3 = (p3 + 3) % 4
				end
			end
			-- wipe meta on top node as it's unused
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},
				{name = "doors:hidden", param2 = p3})
		end
	})
end

local function doors_unregister(name)
	minetest.unregister_item(name)
	minetest.unregister_item(name .. "_a")
	minetest.unregister_item(name .. "_b")
	minetest.unregister_item(name .. "_c")
	minetest.unregister_item(name .. "_d")

	doors.registered_doors[name .. "_a"] = nil
	doors.registered_doors[name .. "_b"] = nil
	doors.registered_doors[name .. "_c"] = nil
	doors.registered_doors[name .. "_d"] = nil
end

-- registering doors:door_wood_lock
doors.register("lord_overwrites_mtg_doors:door_wood_lock", {
		tiles = {{ name = "doors_door_wood.png", backface_culling = true }},
		description = S("Wooden Door"),
		inventory_image = "doors_item_wood.png",
		protected = true,
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
		}
})
minetest.register_alias("doors:door_wood_lock", "lord_overwrites_mtg_doors:door_wood_lock")
doors_register_old_doors_replace_abm("doors:door_wood_lock")
minetest.register_craft({
	type = "shapeless",
	output = "doors:door_wood_lock",
	recipe = {"doors:door_wood", "default:steel_ingot"}
})

-- replacing doors:door_steel
doors_unregister("doors:door_steel")
doors.register("lord_overwrites_mtg_doors:door_steel", { -- removed locker
		tiles = {{name = "doors_door_steel.png", backface_culling = true}},
		description = S("Steel Door"),
		inventory_image = "doors_item_steel.png",
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
		recipe = {
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
		}
})
minetest.register_alias("doors:door_steel", "lord_overwrites_mtg_doors:door_steel")
doors_register_old_doors_replace_abm("doors:door_steel")

-- registering doors:door_steel_lock
doors.register("lord_overwrites_mtg_doors:door_steel_lock", {
		tiles = {{name = "doors_door_steel.png", backface_culling = true}},
		description = S("Steel Door With Lock"),
		inventory_image = "doors_item_steel.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
})
minetest.register_alias("doors:door_steel_lock", "lord_overwrites_mtg_doors:door_steel_lock")
doors_register_old_doors_replace_abm("doors:door_steel_lock")
minetest.register_craft({
	type = "shapeless",
	output = "doors:door_steel_lock",
	recipe = {"doors:door_steel", "default:steel_ingot"}
})

-- registering doors:door_glass_lock
doors.register("lord_overwrites_mtg_doors:door_glass_lock", {
		tiles = {"doors_door_glass.png"},
		description = S("Glass Door With Lock"),
		inventory_image = "doors_item_glass.png",
		protected = true,
		groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		gain_open = 0.3,
		gain_close = 0.25,
})
minetest.register_alias("doors:door_glass_lock", "lord_overwrites_mtg_doors:door_glass_lock")
doors_register_old_doors_replace_abm("doors:door_glass_lock")
minetest.register_craft({
	type = "shapeless",
	output = "doors:door_glass_lock",
	recipe = {"doors:door_glass", "default:steel_ingot"}
})

-- registering doors:door_obsidian_glass_lock
doors.register("lord_overwrites_mtg_doors:door_obsidian_glass_lock", {
		tiles = {"doors_door_obsidian_glass.png"},
		description = S("Obsidian Glass Door With Lock"),
		inventory_image = "doors_item_obsidian_glass.png",
		protected = true,
		groups = {node = 1, cracky=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		gain_open = 0.3,
		gain_close = 0.25,
})
minetest.register_alias("doors:door_obsidian_glass_lock", "lord_overwrites_mtg_doors:door_obsidian_glass_lock")
doors_register_old_doors_replace_abm("doors:door_obsidian_glass_lock")
minetest.register_craft({
	type = "shapeless",
	output = "doors:door_obsidian_glass_lock",
	recipe = {"doors:door_obsidian_glass", "default:steel_ingot"}
})

local function doors_unregister_trapdoor(name)
	minetest.unregister_item(name)
	minetest.unregister_item(name .. "_open")

	doors.registered_trapdoors[name] = nil
	doors.registered_trapdoors[name .. "_open"] = nil
end

-- replacing doors:trapdoor_steel
doors_unregister_trapdoor("doors:trapdoor_steel")
doors.register_trapdoor("lord_overwrites_mtg_doors:trapdoor_steel", { -- removed locker
	description = S("Steel Trapdoor"),
	inventory_image = "doors_trapdoor_steel.png",
	wield_image = "doors_trapdoor_steel.png",
	tile_front = "doors_trapdoor_steel.png",
	tile_side = "doors_trapdoor_steel_side.png",
	sounds = default.node_sound_metal_defaults(),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	gain_open = 0.2,
	gain_close = 0.2,
	groups = {cracky = 1, level = 2, door = 1},
})
minetest.register_alias("doors:trapdoor_steel", "lord_overwrites_mtg_doors:trapdoor_steel")
