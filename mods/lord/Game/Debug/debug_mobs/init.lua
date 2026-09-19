
core.mod(function(mod)
	local environment = core.settings:get('environment') or 'production'
	if environment == 'production' then
		return
	end

	-- `debug_mobs.no_damage = true` - player takes no damage from anything (mobs, projectiles, fire, falling).
	if mod.settings:get_bool('no_damage', false) then
		core.register_on_player_hpchange(function(player, hp_change)
			if hp_change < 0 then
				return 0
			end

			return hp_change
		end, true)
	end
end)
