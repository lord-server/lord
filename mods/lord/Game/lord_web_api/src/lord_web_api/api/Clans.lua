local Resource = require("lord_web_api.api.Resource")

local RESOURCE = '/clans'

--- @class lord_web_api.api.Clans: lord_web_api.api.Resource
local Clans = {
	__index  = Resource,
	resource = RESOURCE,
}


return Clans
