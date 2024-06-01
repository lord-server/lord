local RESOURCE = '/players'

--- @class lord_web_api.api.Players: http.Resource
local Players = {
	__index  = http.Resource,
	resource = RESOURCE,
}


return Players
