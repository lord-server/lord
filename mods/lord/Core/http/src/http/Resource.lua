
--- **Usage:**
--- ```lua
---		Users = {
---			__index  = http.Resource,
---			resource = "/users",
---		}
--- ```
--- @class http.Resource
local Resource = {
	--- @type http.Client
	client   = nil,
	--- @type string url postfix, which appends to `base_url`
	resource = "",
}

--- @param client http.Client
function Resource:new(client)
	local class = self
	self = {}

	self.client   = client

	return setmetatable(self, { __index = class })
end

--- @param client     http.Client
--- @param on_success http.Client.callback
--- @param on_error   http.Client.callback
--- @return http.Client
local function send(client, on_success, on_error)
	return client
		:on_success(on_success)
		:on_error(on_error or function(_) end)
end

--- @overload fun(on_success:http.Client.callback)
--- @param on_success http.Client.callback
--- @param on_error   http.Client.callback
function Resource:list(on_success, on_error)
	send(self.client, on_success, on_error):get(self.resource)
end

--- @overload fun(id:number|string, on_success:http.Client.callback)
--- @param id         number|string
--- @param on_success http.Client.callback
--- @param on_error   http.Client.callback
function Resource:get(id, on_success, on_error)
	send(self.client, on_success, on_error):get(self.resource .. '/' .. id)
end

--- @overload fun(data:table)
--- @overload fun(data:table, on_success:http.Client.callback)
--- @param data       table
--- @param on_success http.Client.callback
--- @param on_error   http.Client.callback
function Resource:create(data, on_success, on_error)
	send(self.client, on_success, on_error):post(self.resource, data)
end

--- @overload fun(id:number|string, data:table)
--- @overload fun(id:number|string, data:table, on_success:http.Client.callback)
--- @param id         number|string
--- @param data       table
--- @param on_success http.Client.callback
--- @param on_error   http.Client.callback
function Resource:update(id, data, on_success, on_error)
	send(self.client, on_success, on_error):put(self.resource .. '/' .. id, data)
end

--- @overload fun(id:number|string)
--- @overload fun(id:number|string, on_success:http.Client.callback)
--- @param id         number|string
--- @param on_success http.Client.callback
--- @param on_error   http.Client.callback
function Resource:delete(id, on_success, on_error)
	send(self.client, on_success, on_error):delete(self.resource .. '/' .. id)
end


return Resource
