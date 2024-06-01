local Resource = require("lord_web_api.api.Resource")

local RESOURCE = '/players'

--- @class lord_web_api.api.Players: lord_web_api.api.Resource
local Players = {
	__index  = Resource,
	resource = RESOURCE,
}


return Players
