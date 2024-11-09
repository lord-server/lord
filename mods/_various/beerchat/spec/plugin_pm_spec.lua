require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("private message", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local ANY = require("luassert.match")._

	local SX = Player("SX", { shout = 1 })
	local Sam = Player("Sam", { shout = 1 })
	local Doe = Player("Doe", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
		mineunit:execute_on_joinplayer(Sam)
		mineunit:execute_on_joinplayer(Doe)
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(Doe)
		mineunit:execute_on_leaveplayer(Sam)
		mineunit:execute_on_leaveplayer(SX)
	end)

	describe("delivery", function()
		-- Verifies that private messages are only delivered to selected recipients

		it("works with @Sam", function()
			local msg = "works with @Sam"
			spy.on(beerchat, "send_on_channel")
			spy.on(beerchat, "execute_callbacks")
			spy.on(minetest, "chat_send_player")
			SX:send_chat_message("@Sam "..msg)
			assert.spy(beerchat.send_on_channel).not_called()
			assert.spy(beerchat.execute_callbacks).not_called_with("before_send_pm", ANY, ANY, "Doe")
			assert.spy(beerchat.execute_callbacks).called_with("before_send_pm", "SX", msg, "Sam")
			assert.spy(minetest.chat_send_player).called(2)
			assert.spy(minetest.chat_send_player).called_with("Sam", M("PM.+works with @"))
		end)

		it("works with /pm Sam", function()
			local msg = "works with /pm Sam"
			spy.on(beerchat, "send_on_channel")
			spy.on(beerchat, "execute_callbacks")
			spy.on(minetest, "chat_send_player")
			SX:send_chat_message("/pm Sam "..msg)
			assert.spy(beerchat.send_on_channel).not_called()
			assert.spy(beerchat.execute_callbacks).not_called_with("before_send_pm", ANY, ANY, "Doe")
			assert.spy(beerchat.execute_callbacks).called_with("before_send_pm", "SX", msg, "Sam")
			assert.spy(minetest.chat_send_player).called(2)
			assert.spy(minetest.chat_send_player).called_with("Sam", M("PM.+works with /pm"))
		end)

		it("works with @ (memory)", function()
			local msg = "works with @ (memory)"
			SX:send_chat_message("@Sam Initialize recipient memory")
			spy.on(beerchat, "send_on_channel")
			spy.on(beerchat, "execute_callbacks")
			spy.on(minetest, "chat_send_player")
			SX:send_chat_message("@ "..msg)
			assert.spy(beerchat.send_on_channel).not_called()
			assert.spy(beerchat.execute_callbacks).not_called_with("before_send_pm", ANY, ANY, "Doe")
			assert.spy(beerchat.execute_callbacks).called_with("before_send_pm", "SX", msg, "Sam")
			assert.spy(minetest.chat_send_player).called(2)
			assert.spy(minetest.chat_send_player).called_with("Sam", M("PM.+works with @ %(memory%)"))
		end)

		it("fails with /pm NA", function()
			local msg = "fails with /pm NA"
			spy.on(beerchat, "send_on_channel")
			spy.on(beerchat, "execute_callbacks")
			spy.on(minetest, "chat_send_player")
			SX:send_chat_message("/pm NA "..msg)
			assert.spy(beerchat.send_on_channel).not_called()
			assert.spy(beerchat.execute_callbacks).not_called_with("before_send_pm", ANY, ANY, "Doe")
			assert.spy(beerchat.execute_callbacks).not_called_with("before_send_pm", ANY, ANY, "Sam")
			assert.spy(beerchat.execute_callbacks).not_called_with("before_send_pm", ANY, ANY, "SX")
			assert.spy(minetest.chat_send_player).called(1)
		end)

	end)

end)
