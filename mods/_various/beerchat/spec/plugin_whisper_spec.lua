require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("Whisper", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local SX = Player("SX", { shout = 1 })
	local Sam = Player("Sam", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
		mineunit:execute_on_joinplayer(Sam)
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(Sam)
		mineunit:execute_on_leaveplayer(SX)
	end)

	it("whispers", function()
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "send_message")
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("$ This is a whisper test")
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.send_message).was.called(2)
		assert.spy(minetest.chat_send_player).called_with("Sam", M("This is a whisper test"))
	end)

	it("whispers with radius", function()
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "send_message")
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("$200 This is a whisper test with radius")
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.send_message).was.called(2)
		assert.spy(minetest.chat_send_player).called_with("Sam", M("This is a whisper test with radius"))
	end)

	it("whisper mode toggle", function()
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "send_message")

		-- Enter whisper mode, send message, cancel whisper mode
		SX:send_chat_message("$")
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("Message after activating whisper mode")
		assert.spy(minetest.chat_send_player).not_called_with("Sam", M("main.+Message after activating whisper mode"))
		assert.spy(minetest.chat_send_player).called_with("Sam", M("Message after activating whisper mode"))
		SX:send_chat_message("$")

		-- Verify that message was sent but not as channel message
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.send_message).was.called()

		-- Verify that message will be sent as channel message after canceling whisper mode
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("Message after canceling whisper mode")
		assert.spy(beerchat.send_on_channel).was.called()
		assert.spy(minetest.chat_send_player).called_with("Sam", M("main.+Message after canceling whisper mode"))
	end)

	it("whisper mode toggle with radius", function()
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "send_message")

		-- Enter whisper mode, send message, cancel whisper mode
		SX:send_chat_message("$200")
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("Message after activating whisper mode with radius")
		assert.spy(minetest.chat_send_player).called_with("Sam", M("Message after activating whisper mode with radius"))
		SX:send_chat_message("$")

		-- Verify that message was sent but not as channel message
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.send_message).was.called()

		-- Verify that message will be sent as channel message after canceling whisper mode
		SX:send_chat_message("Message after canceling whisper mode with radius")
		assert.spy(beerchat.send_on_channel).was.called()
	end)

	it("whisper mode not disabled by whisper messages", function()
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "send_message")

		-- Enter whisper mode, send 3 whisper messages
		SX:send_chat_message("$")
		SX:send_chat_message("$ Whisper after activating whisper mode")
		SX:send_chat_message("$200 Whisper with radius after activating whisper mode")
		SX:send_chat_message("Message in whisper mode after using whisper commands")

		-- Verify that messages were sent but not as channel message
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.send_message).was.called()
	end)

	it("hash whisper mode", function()
		local m = require("luassert.match")
		-- Setup for tests, enter whisper mode and join #jailchannel
		SX:send_chat_message("/jc #jailchannel")
		SX:send_chat_message("$")

		-- Try to switch channels and record callbacks to find out execution path
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "execute_callbacks")
		SX:send_chat_message("#jailchannel")

		-- Verify that message was handled correctly
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.execute_callbacks).was.called_with("before_switch_chan", "SX", m._)
	end)

	it("pm in whisper mode", function()
		local m = require("luassert.match")
		-- Enter whisper mode
		SX:send_chat_message("$")

		-- Send private message and record callbacks to find out execution path
		spy.on(beerchat, "send_on_channel")
		spy.on(beerchat, "execute_callbacks")
		SX:send_chat_message("@Sam Private message in whisper mode")
		SX:send_chat_message("SX message in whisper mode")

		-- Verify that message was handled correctly
		assert.spy(beerchat.send_on_channel).was_not.called()
		assert.spy(beerchat.execute_callbacks).was.called_with("before_send_pm", "SX", m._, "Sam")
	end)

end)
