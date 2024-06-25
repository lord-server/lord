local ClanPlayers = require("web_api.api.Clans.Players")

local RESOURCE = '/clans'

--- @class web_api.api.Clans: http.Resource
local Clans = {
	resource = RESOURCE,
}

setmetatable(Clans, { __index = http.Resource })

--- @param clan_web_id number
function Clans:players(clan_web_id)
	return ClanPlayers:new(self.client, self.resource .. "/" .. clan_web_id)
end


return Clans
