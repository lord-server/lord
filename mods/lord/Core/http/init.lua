
local http_api = minetest.request_http_api()
if not http_api then
	minetest.log(
		"error",
		"[http] You should add mod `http` into `secure.http_mods` setting in your `minetest.conf`.")
	return
end

minetest.mod(function(mod)
	require("http").init(http_api)
end)
