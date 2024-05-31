
--- @class lord_web_api.api.Clans
local Clans = {
	--- @type http_client.Client
	client = nil,
}

--- @param client http_client.Client
function Clans:new(client)
	local class = self
	self = {}

	self.client = client

	return setmetatable(self, {__index = class})
end

function Clans:list()
	-- TODO
end

function Clans:get()
	-- TODO
end

function Clans:create()
	-- TODO
end

function Clans:update()
	-- TODO
end

function Clans:delete()
	-- TODO
end


return Clans
