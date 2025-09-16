--- @class SimpleSoundSpec
local SimpleSoundSpec = {
	--- Scales the gain specified in `SimpleSoundSpec`.
	--- @type number?
	gain              = 1.0,

	--- Overwrites the pitch specified in `SimpleSoundSpec`.
	--- @type number?
	pitch             = 1.0,

	--- Overwrites the fade specified in `SimpleSoundSpec`.
	--- @type number?
	fade              = 0.0,

	--- Start with a time-offset into the sound.
	--- The behavior is as if the sound was already playing for this many seconds.
	--- Negative values are relative to the sound's length, so the sound reaches
	--- its end in `-start_time` seconds.
	--- It is unspecified what happens if `loop` is false and `start_time` is
	--- smaller than minus the sound's length.
	---
	--- Available since feature `sound_params_start_time`.
	---
	--- @type number?
	start_time        = 0.0,

	--- If true, sound is played in a loop.
	--- @type boolean?
	loop              = false,

	--- Play sound at a position.
	--- Can't be used together with `object`.
	--- @type Position?
	pos               = { x = 1, y = 2, z = 3 },

	--- Attach the sound to an object.
	--- Can't be used together with `pos`.
	---
	--- For backward compatibility, sounds continue playing at the last location
	--- of the object if an object is removed (for example if an entity dies).
	--- It is not recommended to rely on this.
	--- For death sounds, prefer playing a positional sound instead.
	---
	--- If you want to stop a sound when an entity dies or is deactivated,
	--- store the handle and call `minetest.sound_stop` in `on_die` / `on_deactivate`.
	---
	--- Ephemeral sounds are entirely unaffected by the object being removed
	--- or leaving the active object range.
	---
	--- Non-ephemeral sounds stop playing on clients if objects leave
	--- the active object range; they should start playing again if objects
	--- come back into range (but due to a known bug, they don't yet).
	---
	--- @type ObjectRef?
	object            = nil,

	--- Only play for this player.
	--- Can't be used together with `exclude_player`.
	---
	--- @type string?
	to_player         = '',

	--- Don't play sound for this player.
	--- Can't be used together with `to_player`.
	---
	--- @type string?
	exclude_player    = '',

	--- Only play for players that are at most this far away when the sound
	--- starts playing.
	--- Needs `pos` or `object` to be set.
	--- `32` is the default.
	---
	--- @type number?
	max_hear_distance = 32,
}
