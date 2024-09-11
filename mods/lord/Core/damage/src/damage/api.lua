local Event      = require('damage.Event')
local Type       = require('damage.Type')
local TypeEvent  = require('damage.Type.Event')
local Periodical = require('damage.Periodical')


--- @param player    Player
--- @param hp_change number
--- @param reason    PlayerHPChangeReason
minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if hp_change < 0 then
		local damage_type = Type.detect(reason)
		hp_change = Type:of(damage_type):modify_hp(player, hp_change, reason)
		Event:trigger(Event.Type.on_damage, player, -hp_change, reason, damage_type)
		TypeEvent:trigger(damage_type, player, -hp_change, reason)
	end

	return hp_change
end, true)


return {
	Type         = Type,

	Periodical   = Periodical,

	--- @type fun(callback:damage.callbacks.OnDamage)
	on_damage    = Event:on(Event.Type.on_damage),

	--- @param type     string|damage.Type name of damage type (for ex.: `"fleshy"`, `"fire"`, ...)
	--- @param callback damage.callbacks.OnDamageOf
	on_damage_of = function(type, callback)
		TypeEvent:subscribe(type, callback)
	end
}
