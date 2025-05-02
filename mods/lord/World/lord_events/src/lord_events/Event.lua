local S       = minetest.get_mod_translator()
local storage = minetest.get_mod_storage()


--- @class lord_events.Event
local Event = {
	--- @private
	--- @static
	--- @type string
	CONF_VAR = 'event_position'
}

--- @static
--- @private
--- @param position Position
function Event.register_command(position)
	assert(table.is_position(position))
	lord_spawns.halls.register('event', {
		position    = position,
		description = S('Event Place'),
	}, true)
end

--- @static
function Event.restore_from_storage_config()
	local position = minetest.string_to_pos(storage:get(Event.CONF_VAR))
	if position then
		Event.register_command(position)
	end
end

--- @static
--- @param position Position
function Event.register(position)
	storage:set_string(Event.CONF_VAR, position:to_string())
	Event.register_command(position)
end

--- @static
function Event.unregister()
	storage:set_string(Event.CONF_VAR, '')
	minetest.unregister_chatcommand('event')
end


return Event
