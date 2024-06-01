
--- @class lord_web_api.api.Resource
local Resource = {
	--- @type http_client.Client
	client   = nil,
	--- @type string url postfix, which appends to `base_url`
	resource = "",
}

--- @param client   http_client.Client
function Resource:new(client)
	local class = self
	self = {}

	self.client   = client

	return setmetatable(self, { __index = class })
end

--- @param client     http_client.Client
--- @param on_success http_client.Client.callback
--- @param on_error   http_client.Client.callback
--- @return http_client.Client
local function send(client, on_success, on_error)
	return client
		:on_success(on_success)
		:on_error(on_error or function(_) end)
end

function Resource:list(on_success, on_error)
	send(self.client, on_success, on_error):get(self.resource)
end

function Resource:get(web_id, on_success, on_error)
	send(self.client, on_success, on_error):get(self.resource .. '/' .. web_id)
end

function Resource:create(data, on_success, on_error)
	send(self.client, on_success, on_error):post(self.resource, data)
end

function Resource:update(web_id, data, on_success, on_error)
	send(self.client, on_success, on_error):put(self.resource .. '/' .. web_id, data)
end

function Resource:delete(web_id, on_success, on_error)
	send(self.client, on_success, on_error):delete(self.resource .. '/' .. web_id)
end


return Resource
