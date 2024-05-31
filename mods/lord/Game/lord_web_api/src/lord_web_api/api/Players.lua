
--- @class lord_web_api.api.Players
local Players = {
	--- @type http_client.Client
	client = nil,
}

--- @param client http_client.Client
function Players:new(client)
	local class = self
	self = {}

	self.client = client

	return setmetatable(self, {__index = class})
end

function Players:list()
	-- TODO
end

function Players:get()
	-- TODO
end

function Players:create()
	-- TODO
end

function Players:update()
	-- TODO
end

function Players:delete()
	-- TODO
end


return Players
