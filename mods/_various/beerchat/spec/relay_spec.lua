require("mineunit")

mineunit("core")
mineunit("player")
mineunit("common/after")
mineunit("server")
mineunit("http")
mineunit("auth")

-- mineunit doesn't have a stub for register_on_auth_fail, so add one
minetest.register_on_auth_fail = function(...) end

sourcefile("init")

describe("Relay", function()

	local M = function(s) return require("luassert.match").matches(s) end
	mineunit:mods_loaded()

	-- At least one player must be in game or some message delivery loops will be skipped
	local SX = Player("SX", { shout = 1 })
	setup(function() mineunit:execute_on_joinplayer(SX) end)
	teardown(function() mineunit:execute_on_leaveplayer(SX) end)

	it("lists available commands", function()
		local fn = beerchat.get_relaycommand("help")
		local out = fn()

		assert.has.match("Available commands:.*help", out)
	end)

	it("delivers messages to chat", function()
		mineunit.http_server:set_response({
			code = 200,
			data = [[ [{
				"username": "REMOTEUSER",
				"text": "REMOTE MESSAGE FROM BRIDGE",
				"gateway": "main",
				"protocol": ""
			}] ]]
		})
		spy.on(minetest, "chat_send_player")
		mineunit:execute_globalstep(60)
		mineunit:execute_globalstep()
		assert.spy(minetest.chat_send_player).called_with("SX", M("main.+REMOTEUSER.+REMOTE MESSAGE FROM BRIDGE"))
	end)

end)
