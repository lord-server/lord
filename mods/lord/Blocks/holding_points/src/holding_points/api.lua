local Event     = require('holding_points.Event')


return {
	on_battle_upcoming = Event:on(Event.Type.on_battle_upcoming),
	on_battle_started  = Event:on(Event.Type.on_battle_started),
	on_battle_stopped  = Event:on(Event.Type.on_battle_stopped),
	on_point_captured  = Event:on(Event.Type.on_point_captured),
}
