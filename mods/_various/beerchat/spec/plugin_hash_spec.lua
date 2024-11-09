require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("Hash", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local ANY = require("luassert.match")._
	assert:register("matcher", "has_channel", function(_, args)
		return function(msg)
			return type(msg) == "table" and msg.channel == args[1]
		end
	end)
	local CHANNEL = require("luassert.match").has_channel

	local SX = Player("SX", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
		-- Test channels
		beerchat.channels["hash-test1"] = { owner = "beerholder", color = beerchat.default_channel_color }
		beerchat.channels["hash-test2"] = { owner = "beerholder", color = beerchat.default_channel_color }
	end)

	before_each(function()
		beerchat.set_player_channel("SX", "main")
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(SX)
	end)

	it("handles current channel", function()
		assert.equal(beerchat.get_player_channel("SX"), "main")
		SX:send_chat_message("#main")
		assert.equal(beerchat.get_player_channel("SX"), "main")
	end)

	it("handles missing channel", function()
		assert.equal(beerchat.get_player_channel("SX"), "main")
		SX:send_chat_message("#channel-does-not-exist")
		assert.equal(beerchat.get_player_channel("SX"), "main")
	end)

	it("joins and switches channel", function()
		local expected_switch = { from = "main", to = "hash-test1" }
		assert.equal(beerchat.get_player_channel("SX"), "main")
		spy.on(beerchat, "execute_callbacks")
		SX:send_chat_message("#hash-test1")
		assert.spy(beerchat.execute_callbacks).not_called_with("on_send_on_channel", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).called_with("before_switch_chan", "SX", expected_switch)
		assert.equal(beerchat.get_player_channel("SX"), "hash-test1")
	end)

	it("sends message without switching channel", function()
		assert.equal(beerchat.get_player_channel("SX"), "main")
		spy.on(beerchat, "execute_callbacks")
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("#hash-test1 Test message")
		assert.spy(beerchat.execute_callbacks).not_called_with("before_switch_chan", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).called_with("on_send_on_channel", "SX", CHANNEL("hash-test1"), "SX")
		assert.equal(beerchat.get_player_channel("SX"), "main")
		assert.spy(minetest.chat_send_player).called_with("SX", M("hash%-test1.+Test message"))
	end)

	it("requires joining before sending messages", function()
		assert.equal(beerchat.get_player_channel("SX"), "main")
		spy.on(beerchat, "execute_callbacks")
		SX:send_chat_message("#hash-test2 Test message")
		assert.spy(beerchat.execute_callbacks).not_called_with("before_switch_chan", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).not_called_with("before_join", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).not_called_with("before_send_on_channel", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).not_called_with("on_send_on_channel", ANY, ANY, ANY)
		assert.equal(beerchat.get_player_channel("SX"), "main")
	end)

end)
