local S = require("lord_wooden_stuff.config").translator

---@param above Position
---@param under Position
---@return number|nil
local function choose_param2(above, under)
	if above.x < under.x then
		return 1
	elseif above.x > under.x then
		return 3
	elseif above.z < under.z then
		return 0
	elseif above.z > under.z then
		return 2
	end
end

--- @param wood string
--- @param def LordWoodenStuffDefinition
--- @param stick string technical name of stick item (ex.: `"default:stick"`) for craft.
local function register_ladder(wood, def, _, stick)
	local name = "lord_wooden_stuff:ladder_" .. wood
	minetest.register_node(name, {
		description               = S(def.desc .. " Ladder"),
		drawtype                  = "nodebox",
		tiles                     = { def.texture },
		particle_image            = { def.texture },
		paramtype                 = "light",
		paramtype2                = "facedir",
		walkable                  = true,
		climbable                 = true,
		is_ground_content         = false,
		node_box                  = {
			type  = "fixed",
			fixed = {
				{ -0.5, -0.5, 0.5 - 1 / 7, -0.5 + 1 / 7, 0.5, 0.5 },
				{ 0.5 - 1 / 7, -0.5, 0.5 - 1 / 7, 0.5, 0.5, 0.5 },
				{ -0.5 + 1 / 7, 0.5 - 1 / 6 - 1 / 12, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12, 0.5 },
				{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 3, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 2, 0.5 },
				{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 5, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 4, 0.5 },
			},
		},
		selection_box             = {
			type  = "fixed",
			fixed = {
				{ -0.5, -0.5, 0.5 - 1 / 7, -0.5 + 1 / 7, 0.5, 0.5 },
				{ 0.5 - 1 / 7, -0.5, 0.5 - 1 / 7, 0.5, 0.5, 0.5 },
				{ -0.5 + 1 / 7, 0.5 - 1 / 6 - 1 / 12, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12, 0.5 },
				{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 3, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 2, 0.5 },
				{ -0.5 + 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 5, 0.5 - 1 / 16, 0.5 - 1 / 7, 0.5 - 1 / 12 - 1 / 6 * 4, 0.5 },
			},
		},
		on_place                  = function(itemstack, placer, pointed_thing)
			local above           = pointed_thing.above
			local node_above_name = minetest.get_node(above).name
			if pointed_thing.type ~= "node" and	not minetest.registered_nodes[node_above_name].buildable_to then
				return
			end

			local under      = pointed_thing.under
			local node_under = minetest.get_node(under)

			if minetest.registered_nodes[node_under.name].on_rightclick then
				return minetest.registered_nodes[node_under.name].on_rightclick(under, node_under, placer, itemstack)
			end

			local above_2 = above:offset(0, 1, 0)
			if minetest.is_protected(above, placer:get_player_name()) or
					minetest.is_protected(above_2, placer:get_player_name()) then
				minetest.record_protection_violation(above, placer:get_player_name())
				return itemstack
			end

			local param2 = choose_param2(above, under)

			if param2 then
				minetest.set_node(above, { name = name, param2 = param2 })
				if not minetest.is_creative_enabled(placer) then
					itemstack:take_item()
				end
			end
			return itemstack
		end,
		node_placement_prediction = "",
		groups                    = { choppy = 2, oddly_breakable_by_hand = 3, flammable = 2, wooden = 1 },
		legacy_wallmounted        = true,
		sounds                    = default.node_sound_wood_defaults(),
	})
	minetest.register_craft({
		output = name .. " 7",
		recipe = {
			{ stick, "",    stick },
			{ stick, stick, stick },
			{ stick, "",    stick },
		}
	})
end

return register_ladder
