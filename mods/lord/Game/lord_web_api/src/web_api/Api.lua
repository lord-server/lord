local Players = require("web_api.api.Players")
local Clans   = require("web_api.api.Clans")
local Shops   = require("web_api.api.Shops")


--- @class web_api
local Api = {
	--- @type web_api.api.Players
	players = nil,
	--- @type web_api.api.Clans
	clans   = nil,
}

--- @param client http.Client
function Api:new(client)
	local class = self
	self = {}

	self.players = Players:new(client)
	self.clans   = Clans:new(client)
	self.shops   = Shops:new(client)

	return setmetatable(self, {__index = class})
end


return Api
