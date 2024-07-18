

minetest.mod(function(mod)
	local http_api = minetest.request_http_api()
	if not http_api then
		minetest.log("error", "You should add mod `http` into `secure.http_mods` setting in your `minetest.conf`.")
		return
	end
	require("http").init(http_api)
end)
