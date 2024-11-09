require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

describe("Mod initialization", function()

	it("Wont crash", function()
		sourcefile("init")
	end)

end)

describe("Chatting", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local SX = Player("SX", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(SX)
	end)

	it("sends messages", function()
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("Everyone ignore me, this is just a test")
		assert.spy(minetest.chat_send_player).called_with("SX", M("Everyone ignore me, this is just a test"))
	end)

	it("creates channel", function()
		SX:send_chat_message("/cc foo")
		assert.not_nil(beerchat.channels["foo"])
	end)

	it("switches channels", function()
		SX:send_chat_message("#foo")
		assert.equals("foo", SX:get_meta():get_string("beerchat:current_channel"))
		SX:send_chat_message("Everyone ignore me, this is just a test")
	end)

	it("deletes channel", function()
		SX:send_chat_message("/dc foo")
		assert.is_nil(beerchat.channels["foo"])
	end)

end)
