local RESOURCE = '/players'

--- @class web_api.api.Players: http.Resource
local Players = {
	resource = RESOURCE,
}

setmetatable(Players, { __index = http.Resource })

--- Links player to the site user account by one-time code, which user gets on the site.
--- @param player_web_id number
--- @param code          string
--- @param on_success    http.Client.callback
--- @param on_error      http.Client.callback
function Players:link(player_web_id, code, on_success, on_error)
	return self.client
		:on_success(on_success)
		:on_error(on_error or function(_) end)
		:post(self.resource .. '/' .. player_web_id .. '/link', { code = code })
	;
end


return Players
