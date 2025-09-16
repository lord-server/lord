--- @diagnostic disable: missing-return


--- Used by `core.register_entity`.
--- The entity definition table becomes a metatable of a newly created per-entity luaentity table,  
---   meaning its fields (e.g. initial_properties) will be shared between all instances of an entity.
--- @class EntityDefinition
local EntityDefinition = {
	--- A table of object properties, see the `Object properties` section.
	--- The properties in this table are applied to the object
	---	once when it is spawned.
	--- @type ObjectProperties?
	initial_properties = nil,


	--- Called when the object is instantiated.
	--- @param static_data string passes from `get_staticdata()`
	--- @param dtime_s number time passed since the object was unloaded, which can be used for updating the entity state.
	on_activate = function(self, static_data, dtime_s) end,
	--- * Called when the object is about to get removed or unloaded.
	--- * `removal`: boolean indicating whether the object is about to get removed.
	---   Calling `object:remove()` on an active object will call this with `removal=true`.
	---   The mapblock the entity resides in being unloaded will call this with `removal=false`.
	---	* Note that this won't be called if the object hasn't been activated in the first place.
	---   In particular, `minetest.clear_objects({mode = "full"})` won't call this,
	---   whereas `minetest.clear_objects({mode = "quick"})` might call this.
	--- @param removal boolean
	on_deactivate = function(self, removal) end,
	--- * Called on every server tick, after movement and collision processing.
	--- * `dtime`: elapsed time since last call
	--- * `moveresult`: table with collision info (only available if physical=true)
	on_step = function(self, dtime, move_result) end,

	--- * Called when somebody punches the object.
	--- * Note that you probably want to handle most punches using the automatic armor group system.
	--- * `puncher`: an `ObjectRef` (can be `nil`)
	--- * `time_from_last_punch`: Meant for disallowing spamming of clicks (can be `nil`).
	--- * `tool_capabilities`: capability table of used item (can be `nil`)
	--- * `dir`: unit vector of direction of punch. Always defined. Points from the puncher to the punched.
	--- * `damage`: damage that will be done to entity.
	--- * Can return `true` to prevent the default damage mechanism.
	--- @param puncher ObjectRef|Player|nil
	--- @param time_from_last_punch number|nil
	--- @param tool_capabilities table|nil
	--- @param dir vector
	--- @param damage number
	--- @return boolean
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage) end,
	--- * Called when the object dies.
	--- * `killer`: an `ObjectRef` (can be `nil`)
	--- @param killer ObjectRef|Player
	on_death = function(self, killer) end,
	--- * Called when `clicker` pressed the 'place/use' key while pointing
	---   to the object (not necessarily an actual rightclick)
	--- * `clicker`: an `ObjectRef` (may or may not be a player)
	--- @param clicker ObjectRef|Player
	on_rightclick = function(self, clicker) end,
	--- * `child`: an `ObjectRef` of the child that attaches
	on_attach_child = function(self, child) end,
	--- * `child`: an `ObjectRef` of the child that detaches
	on_detach_child = function(self, child) end,
	--- * `parent`: an `ObjectRef` (can be `nil`) from where it got detached
	--- * This happens before the parent object is removed from the world
	--- @param parent ObjectRef
	on_detach = function(self, parent) end,
	--- * Should return a string that will be passed to `on_activate` when the object is instantiated the next time.
	--- @return string
	get_staticdata = function(self) end,

	--- You can define arbitrary member variables here (see Item definition for more info) by using a '_' prefix
	--- @type any
	_custom_field = "whatever",
}
