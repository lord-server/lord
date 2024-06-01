local RESOURCE = '/clans'

--- @class lord_web_api.api.Clans: http.Resource
local Clans = {
	__index  = http.Resource,
	resource = RESOURCE,
}


return Clans
