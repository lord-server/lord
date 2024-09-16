
--- Local storage of registered effects.
--- @type table<string,effects.Effect>
local registered_effects = {}

--- @class effects.Collection
local Registered = {}

--- @param effect effects.Effect
function Registered.add(effect)
	registered_effects[effect.name] = effect

	return Registered
end

--- @return table<string,effects.Effect>
function Registered.all()
	return registered_effects
end

--- @param name string
function Registered.get(name)
	return registered_effects[name]
end


return Registered
