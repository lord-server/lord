
--- @class equipment.Kind
local Kind = {
	--- @static
	--- @private
	--- @type equipment.Event
	event = nil,
	--- @private
	--- @type table<string,number>
	sizes = {},
}

--- @static
--- @param kind string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>. \
---                    Except "event" and "sizes" - reserved.
--- @param size string quantity of slots for this `kind` of equipment.
function Kind.register(kind, size)
	if kind == "event" or kind == "sizes" or kind == "*any*" then
		error("Names \"event\", \"sizes\" and \"*any*\" are reserved. You are can't use them for `kind` name.", 2)
	end

	Kind.event.addSubscribersKind(kind)
	Kind.sizes[kind] = size

	minetest.register_on_joinplayer(function(player, last_login)
		if not player:is_player() then
			error("something went wrong: joined player is not a Player object")
		end

		-- `last_login` is nil, if player is new (same as `register_on_newplayer`)
		if last_login == nil then
			player:get_inventory():set_size(kind, size)
			Kind.event.trigger(player, kind, "create")
		end

		Kind.event.trigger(player, kind, "load")
	end)
end

--- @param kind string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>.
function Kind.is_valid(kind)
	table.has_key(Kind.sizes, kind)
end

--- @param kind string kind(type) of equipment. For ex. "armor"|"clothing"|<your_one>.
function Kind.get_size(kind)
	if not Kind.is_valid(kind) then
		error("Invalid equipment kind", 2)
	end

	return Kind.sizes[kind]
end


return Kind
