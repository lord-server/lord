local v
    = vector.new

local OrcishDungeon = require('orcish.Dungeon')


return {
	--- @param mod minetest.Mod
	init = function(mod)

		-- TODO: Регистрация генерации на карте


		-- debug tool (spawn dungeon):
		core.register_craftitem('buildings:dungeon_orcish', {
			description     = 'Orcish Dungeon Generator (debug tool)',
			inventory_image = 'buildings_dungeon_orcish.png',
			on_place        = function(itemstack, placer, pointed_thing)
				if not placer or not core.check_player_privs(placer, 'server') then
					return ItemStack('')
				end

				local rooms_count = math.random(3, 5)
				local is_inside_mapgen = false
				OrcishDungeon:new(v(pointed_thing.above), rooms_count)
					:generate(mod.debug, is_inside_mapgen)
			end
		})

	end
}
