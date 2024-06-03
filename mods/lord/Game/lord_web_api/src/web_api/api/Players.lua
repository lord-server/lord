local RESOURCE = '/players'

--- @class web_api.api.Players: http.Resource
local Players = {
	resource = RESOURCE,
}

setmetatable(Players, { __index = http.Resource })


return Players
