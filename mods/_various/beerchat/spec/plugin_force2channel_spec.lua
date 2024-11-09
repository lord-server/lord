require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("force2channel command", function()

	local SX = Player("SX", { shout = 1, ban = 1 })
	local XX = Player("XX", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
		mineunit:execute_on_joinplayer(XX)
		SX:send_chat_message("/cc notmain")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("main", beerchat.get_player_channel("XX"))
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(SX)
		mineunit:execute_on_leaveplayer(XX)
	end)

	it("forces player to channel", function()
		SX:send_chat_message("/force2channel notmain, XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("notmain", beerchat.get_player_channel("XX"))
		assert.equals("notmain", XX:get_meta():get_string("beerchat:current_channel"))
	end)

	it("handles invalid channel name", function()
		SX:send_chat_message("/force2channel doesnotexist, XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("notmain", beerchat.get_player_channel("XX"))
		assert.equals("notmain", XX:get_meta():get_string("beerchat:current_channel"))
	end)

	it("handles empty channel name", function()
		SX:send_chat_message("/force2channel , XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("notmain", beerchat.get_player_channel("XX"))
		assert.equals("notmain", XX:get_meta():get_string("beerchat:current_channel"))
	end)

	it("handles jail channel name", function()
		local oldchannel = XX:get_meta():get_string("beerchat:current_channel")
		SX:send_chat_message("/force2channel jailchannel, XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("jailchannel", beerchat.get_player_channel("XX"))
		assert.equals("jailchannel", XX:get_meta():get_string("beerchat:current_channel"))
		assert.equals(oldchannel, XX:get_meta():get_string("beerchat:jailed"))
	end)

end)
