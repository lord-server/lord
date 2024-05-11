local pairs, math_random
	= pairs, math.random

local RACE_ORC = "orc"

--- For biome grasses spreading we use existing MTG ABM function:
--- mods/_minetest_game/default/functions.lua:~586 (label = "Grass spread")

--- @param api    ground.API
--- @param config ground.Config
local function deferred_register_mordor_lands_spreading_abm(api, config)
	minetest.register_on_mods_loaded(function()
		local exclude_dirts    = config.mordor_lands.exclude_dirts
		local covers_with      = config.mordor_lands.covers_with
		local dirts_to_replace = table.keys(table.except(api.dirt.get_biome_nodes(), exclude_dirts))

		local x_from = config.mordor_lands.from.x
		local x_to   = config.mordor_lands.to.x
		local z_from = config.mordor_lands.from.z
		local z_to   = config.mordor_lands.to.z

		minetest.register_abm({
			label = "Mordor lands spread",
			nodenames = dirts_to_replace,
			interval = 6,
			chance = 40,
			--- our biomes generates in this interval:
			min_y = -32,
			max_y = 250,
			catch_up = false,
			action = function(pos, node, active_object_count, active_object_count_wider)
				if not (pos.x > x_from and pos.x < x_to and pos.z > z_from and pos.z < z_to) then
					return
				end

				--- @type Player[]
				local nearest_objects = minetest.get_objects_inside_radius(pos, 15)
				for i, object in pairs(nearest_objects) do
					if object:is_player() and races.get_race(object:get_player_name()) == RACE_ORC then
						local replace_with = covers_with[math_random(#covers_with)]
						minetest.set_node(pos, { name = replace_with })
						break;
					end
				end
			end
		})
	end)
end


return {
	deferred_register_mordor_lands_abm = deferred_register_mordor_lands_spreading_abm,
}
