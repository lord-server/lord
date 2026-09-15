local base_url = core.settings:get("lord_web_api.base_url")
local timeout  = core.settings:get("lord_web_api.timeout") or 5

if not base_url then
	core.log("warning", "Can't find setting `lord_web_api.base_url`.")
	return false
end

--- @class web_api.config
local config = {
	--- @type string
	base_url = base_url,
	--- @type number in seconds
	timeout  = timeout,
}


return config
