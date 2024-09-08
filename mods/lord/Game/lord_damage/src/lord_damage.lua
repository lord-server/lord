damage.Type.FLESHY = 'fleshy'
damage.Type.FIRE   = 'fire'
damage.Type.SOUL   = 'soul'
damage.Type.POISON = 'poison'

--- Registers our (LORD) damage Types.
local function register_damage_types()
	damage.Type.register(damage.Type.FLESHY)
	damage.Type.register(damage.Type.FIRE)
	damage.Type.register(damage.Type.SOUL)
	damage.Type.register(damage.Type.POISON)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_damage_types()
	end,
}
