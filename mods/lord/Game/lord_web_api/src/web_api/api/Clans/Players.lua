local RESOURCE = '/players'

--- @class web_api.api.Clans.Players: http.Resource
local Players = {}
setmetatable(Players, { __index = http.Resource })

--- @param client              http.Client
--- @param parent_resource_url string
function Players:new(client, parent_resource_url)
	return http.Resource.new(self, client, parent_resource_url .. RESOURCE)
end

--- @param player_web_id number
--- @param on_success    http.Client.callback
--- @param on_error      http.Client.callback
function Players:add(player_web_id, on_success, on_error)
	return self:update(player_web_id, nil, on_success, on_error)
end


return Players
