local S = minetest.get_translator("lord_doors")


local function register_replace_mtg_doors_legacy_lbm(name)
	local overwrites_name = "lord_doors:" .. string.gsub(name, "%S+:", "")

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


-- doors:door_wood already registered in MTG/doors

-- doors:door_wood_lock registration
doors.register("lord_doors:door_wood_lock", {
		tiles = {{ name = "doors_door_wood.png", backface_culling = true }},
		description = S("Wooden Door With Lock"),
		inventory_image = "doors_item_wood.png^lord_doors_lock.png",
		protected = true,
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		gain_open = 0.06,
		gain_close = 0.13,
})
minetest.register_craft({
	type = "shapeless",
	output = "lord_doors:door_wood_lock",
	recipe = {"doors:door_wood", "default:steel_ingot"}
})
-- MTG/doors legacy:
minetest.register_alias("doors:door_wood_lock", "lord_doors:door_wood_lock")
register_replace_mtg_doors_legacy_lbm("doors:door_wood_lock")

-- doors:door_steel registration
doors.register("lord_doors:door_steel", { -- removed locker
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
-- MTG/doors legacy:
minetest.register_alias("doors:door_steel", "lord_doors:door_steel")
register_replace_mtg_doors_legacy_lbm("doors:door_steel")

-- doors:door_steel_lock registration
doors.register("lord_doors:door_steel_lock", {
		tiles = {{name = "doors_door_steel.png", backface_culling = true}},
		description = S("Steel Door With Lock"),
		inventory_image = "doors_item_steel.png^lord_doors_lock.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		gain_open = 0.2,
		gain_close = 0.2,
})
minetest.register_craft({
	type = "shapeless",
	output = "lord_doors:door_steel_lock",
	recipe = {"doors:door_steel", "default:steel_ingot"}
})
-- MTG/doors legacy:
minetest.register_alias("doors:door_steel_lock", "lord_doors:door_steel_lock")
register_replace_mtg_doors_legacy_lbm("doors:door_steel_lock")

-- doors:door_glass already registered in MTG/doors

-- registering doors:door_glass_lock
doors.register("lord_doors:door_glass_lock", {
		tiles = {"doors_door_glass.png"},
		description = S("Glass Door With Lock"),
		inventory_image = "doors_item_glass.png^lord_doors_lock.png",
		protected = true,
		groups = {node = 1, cracky=3, oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		gain_open = 0.3,
		gain_close = 0.25,
})
minetest.register_craft({
	type = "shapeless",
	output = "lord_doors:door_glass_lock",
	recipe = {"doors:door_glass", "default:steel_ingot"}
})
-- MTG/doors legacy:
minetest.register_alias("doors:door_glass_lock", "lord_doors:door_glass_lock")
register_replace_mtg_doors_legacy_lbm("doors:door_glass_lock")

-- doors:door_obsidian already registered in MTG/doors

-- registering doors:door_obsidian_glass_lock
doors.register("lord_doors:door_obsidian_glass_lock", {
		tiles = {"doors_door_obsidian_glass.png"},
		description = S("Obsidian Glass Door With Lock"),
		inventory_image = "doors_item_obsidian_glass.png^lord_doors_lock.png",
		protected = true,
		groups = {node = 1, cracky=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		gain_open = 0.3,
		gain_close = 0.25,
})
minetest.register_craft({
	type = "shapeless",
	output = "lord_doors:door_obsidian_glass_lock",
	recipe = {"doors:door_obsidian_glass", "default:steel_ingot"}
})
-- MTG/doors legacy:
minetest.register_alias("doors:door_obsidian_glass_lock", "lord_doors:door_obsidian_glass_lock")
register_replace_mtg_doors_legacy_lbm("doors:door_obsidian_glass_lock")
