local RESOURCE = '/clans'

--- @class web_api.api.Clans: http.Resource
local Clans = {
	resource = RESOURCE,
}

setmetatable(Clans, { __index = http.Resource })


return Clans
