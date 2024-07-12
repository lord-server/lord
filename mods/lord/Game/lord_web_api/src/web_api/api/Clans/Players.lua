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
	return self:update(player_web_id, {
		-- TODO: #1542
		_mt_workaround = "fixme: https://github.com/minetest/minetest/issues/14846"
	}, on_success, on_error)
end

-- TODO: #1542 (remove the entire method)
function Players:delete(player_web_id, on_success, on_error)
	return self.client
		:on_success(on_success)
		:on_error(on_error or function(_)  end)
		:delete(self.resource .. "/" .. player_web_id, {
			_mt_workaround = "fixme: https://github.com/minetest/minetest/issues/14846"
		})
	;
end


return Players
