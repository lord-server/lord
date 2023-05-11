
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
	if kind == "event" or kind == "sizes" then
		error("Names \"event\", \"sizes\" and \"*any*\" are reserved. You are can't use them for `kind` name.", 2)
	end
	Kind.event.addSubscribersKind(kind)
	Kind.sizes[kind] = size
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
