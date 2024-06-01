local Players = require("lord_web_api.api.Players")
local Clans   = require("lord_web_api.api.Clans")


--- @class web_api
local Api = {
	--- @type lord_web_api.api.Players
	players = nil,
	--- @type lord_web_api.api.Clans
	clans   = nil,
}

--- @param client http.Client
function Api:new(client)
	local class = self
	self = {}

	self.players = Players:new(client)
	self.clans   = Clans:new(client)

	return setmetatable(self, {__index = class})
end


return Api
