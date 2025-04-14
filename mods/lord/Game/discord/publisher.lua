--
-- publisher
--
lp_api.publisher = {}

function lp_api.publisher.resp_handler(result)
    if not result.succeeded and result.code ~= 200 then
        minetest.log("[lp_api] Pub request... [ERROR]")
    end
end

function lp_api.publisher.pub_msg(name, type, title, message)
	if name == "minetest" and minetest.get_player_privs(name).shout or message:sub(1, 1) ~= "/" then
        local json_msg = minetest.write_json({player = name, type = type, title =  title, message = message})
        if json_msg then
            lp_api.request_http("/pub?category="..lp_api.channel_id, json_msg, lp_api.publisher.resp_handler,"PUT")
        end
    end
end
