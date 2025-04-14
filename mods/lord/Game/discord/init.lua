lp_api = {}
lp_api.enabled = minetest.settings:get_bool("lp_api.enabled", false)
if not lp_api.enabled then return end
lp_api.http = minetest.request_http_api()
lp_api.url = minetest.settings:get("lp_api.url") or "http://localhost:8003"
lp_api.channel_id = minetest.settings:get("lp_api.channel_id") or "minetest"
lp_api.timeout = minetest.settings:get("lp_api.timeout") or 30
-- For secure connect set header value (Authorization: Basic bG9naW46cGFzc3dvcmQ=)
-- where bG9naW46cGFzc3dvcmQ= is the base64(login:password) "Content-Type: application/json; charset=utf8"
lp_api.header = minetest.settings:get("lp_api.header") or  nil

function lp_api.request_http(ext_url,pd,response_handler,pmethod)
    local req = {
        url = lp_api.url..ext_url,
        method = pmethod,
        post_data = pd,
        extra_headers = {lp_api.header},
        timeout = lp_api.timeout
    }

    lp_api.http.fetch(req, function(result)
        pcall(response_handler, result)
    end)
end

if lp_api.http then
    local default_path = minetest.get_modpath("lp_api")
    dofile(default_path.."/router.lua")
    dofile(default_path.."/publisher.lua")
    dofile(default_path.."/subscriber.lua")
    minetest.log("[lp_api] Loading... [OK]")
else
    minetest.log("[lp_api] Please setup (secure.http_mod = lp_api) in minetest.conf... [ERROR]")
end
