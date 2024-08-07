local ClanPlayers = require("web_api.api.Clans.Players")

local RESOURCE = '/clans'

--- @class web_api.api.Clans: http.Resource
local Clans = {
	resource = RESOURCE,
}

setmetatable(Clans, { __index = http.Resource })

--- @param clan_web_id number
--- @return web_api.api.Clans.Players
function Clans:players(clan_web_id)
	return ClanPlayers:new(self.client, self.resource .. "/" .. clan_web_id)
end

--- @param clan_web_id number
--- @param is_online   boolean              ensure that you don't pass nil!
--- @param on_success  http.Client.callback
--- @param on_error    http.Client.callback
function Clans:is_online(clan_web_id, is_online, on_success, on_error)
	assert(is_online ~= nil)
	return self:update(clan_web_id, { is_online = (is_online and 1 or 0) }, on_success, on_error)
end

--- @param clan_web_id number
--- @param is_blocked  boolean              ensure that you don't pass nil!
--- @param on_success  http.Client.callback
--- @param on_error    http.Client.callback
function Clans:is_blocked(clan_web_id, is_blocked, on_success, on_error)
	assert(is_blocked ~= nil)
	return self:update(clan_web_id, { is_blocked = (is_blocked and 1 or 0) }, on_success, on_error)
end


return Clans
