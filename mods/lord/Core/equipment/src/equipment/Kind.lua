
--- @class equipment.Kind
local Kind = {
	--- @private
	--- @static
	--- @type equipment.Event
	event = nil,
	--- @private
	--- @static
	--- @type table<string,number>
	sizes = {},
	--- @private
	--- @static
	--- @type table<number,string>|string[]
	registered = {},
}

--- @static
--- @param kind string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>. \
---                    Except "event" and "sizes" - reserved.
--- @param size string quantity of slots for this `kind` of equipment.
function Kind.register(kind, size)
	Kind.event.addSubscribersKind(kind)
	Kind.sizes[kind] = size
	Kind.registered[#Kind.registered+1] = kind
end

--- @static
--- @param kind string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>.
function Kind.is_valid(kind)
	return table.has_key(Kind.sizes, kind)
end

--- @static
--- @param kind string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>.
function Kind.get_size(kind)
	if not Kind.is_valid(kind) then
		error("Invalid equipment kind", 2)
	end

	return Kind.sizes[kind]
end

--- @private
--- @static
--- @param kind          string  kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>.
--- @param player        Player  MT `Player`-object of joined player
--- @param is_new_player boolean whether the player connected first time
function Kind.load_for_player(kind, player, is_new_player)
	if not player:is_player() then
		error("something went wrong: joined player is not a Player object")
	end

	if is_new_player or not player:get_inventory():get_list(kind) then
		player:get_inventory():set_size(kind, Kind.sizes[kind])
		Kind.event.trigger(player, kind, "create")
	end

	Kind.event.trigger(player, kind, "load")
end

--- @internal
--- @static
function Kind.init()
	minetest.register_on_joinplayer(function(player, last_login)
		-- `last_login` is nil, if player is new (same as `register_on_newplayer`)
		local is_new_player = last_login == nil
		for _, kind in ipairs(Kind.registered) do
			Kind.load_for_player(kind, player, is_new_player)
		end

		Kind.event.trigger(player, "*all*", "load_all")
	end)
end

return Kind
