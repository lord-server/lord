local Event = require('damage.Event')


--- @param player    Player
--- @param hp_change number
--- @param reason    PlayerHPChangeReason
minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if hp_change < 0 then
		Event:trigger(Event.Type.on_damage, player, -hp_change, reason)
	end
end)


return {
	--- @type fun(callback:damage.callbacks.OnDamage)
	on_damage = Event:on(Event.Type.on_damage)
}
