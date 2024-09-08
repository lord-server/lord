local Event     = require('damage.Event')
local Type      = require('damage.Type')
local TypeEvent = require('damage.Type.Event')


--- @param player    Player
--- @param hp_change number
--- @param reason    PlayerHPChangeReason
minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if hp_change < 0 then
		Event:trigger(Event.Type.on_damage, player, -hp_change, reason)
		TypeEvent:trigger(Type.detect(reason), player, -hp_change, reason)
	end
end)


return {
	Type          = Type,

	register_type = Type.register,

	--- @type fun(callback:damage.callbacks.OnDamage)
	on_damage     = Event:on(Event.Type.on_damage),

	--- @param type     string|damage.Type name of damage type (for ex.: `"fleshy"`, `"fire"`, ...)
	--- @param callback damage.callbacks.OnDamageOf
	on_damage_of  = function(type, callback)
		TypeEvent:subscribe(type, callback)
	end
}
