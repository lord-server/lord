
--- @class http_client.Client
local Client = {
	--- @type string
	base_url = nil,
	--- @type table|HTTPRequest https://api.minetest.net/definition-tables/#httprequest-definition
	base_options = {}
}

function Client:new(base_url, base_options)
	local class = self
	self = {}

	self.base_url     = base_url
	self.base_options = base_options
	-- TODO: init MT request_http_api

	return setmetatable(self, {__index = class})
end

--- @param request HTTPRequest
--- @return HTTPRequestResult
function Client:rawRequest(request)
	-- TODO
end

--- @param method  string
--- @param url     string
--- @param options table|HTTPRequest
--- @return table?
function Client:request(method, url, options)
	-- TODO
end

--- @param url     string
--- @param options table|HTTPRequest
--- @return table?
function Client:get(url, options)
	-- TODO
end

--- @param url     string
--- @param options table|HTTPRequest
--- @return table?
function Client:post(url, data, options)
	-- TODO
end

--- @param url     string
--- @param options table|HTTPRequest
--- @return table?
function Client:put(url, data, options)
	-- TODO
end

--- @param url     string
--- @param options table|HTTPRequest
--- @return table?
function Client:delete(url, options)
	-- TODO
end


return Client
