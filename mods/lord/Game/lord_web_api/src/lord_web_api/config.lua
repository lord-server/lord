local base_url = minetest.settings:get("lord_web_api.base_url")
local timeout  = minetest.settings:get("lord_web_api.timeout") or 5

if not base_url then
	minetest.log("warning", "Can't find setting `lord_web_api.base_url`.")
	return nil
end

--- @class lord_web_api.config
local config = {
	--- @type string
	base_url = base_url,
	--- @type number in seconds
	timeout  = timeout,
}


return config
