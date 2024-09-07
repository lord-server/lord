local TypeEvent = require('damage.Type.Event')


--- @static
--- @class damage.Type
local Type = {
	--- @private
	--- @static
	--- @type string[]
	registered = {
		-- [1] = 'fleshy'
	}
}

--- @param name string
function Type.register(name)
	Type.registered[#Type.registered + 1] = name

	TypeEvent.Type[name]        = name
	TypeEvent.subscribers[name] = {}
end

--- @return string[]
function Type.get_registered()
	return Type.registered
end

setmetatable(Type, {
	--- @return fun(registered:string[]): (number, string)
	__pairs = function()
		return pairs(Type.registered)
	end
})


return Type
