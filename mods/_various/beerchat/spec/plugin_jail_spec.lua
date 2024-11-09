require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

-- Players, initialized in test environment setup functions
local SX, XX

local function do_setup()
	SX = Player("SX", { shout = 1, ban = 1 })
	mineunit:execute_on_joinplayer(SX)
	assert.equals("main", beerchat.get_player_channel("SX"))
end

local function do_teardown()
	mineunit:execute_on_leaveplayer(SX)
end

local function do_before_each()
	XX = Player("XX", { shout = 1 })
	mineunit:execute_on_joinplayer(XX)
	assert.equals("main", beerchat.get_player_channel("XX"))
end

local function do_after_each()
	mineunit:execute_on_leaveplayer(XX)
	XX = nil
end

describe("chat_jail command", function()

	setup(do_setup)
	teardown(do_teardown)
	before_each(do_before_each)
	after_each(do_after_each)

	it("forces player to channel", function()
		local oldchannel = beerchat.get_player_channel("XX")
		SX:send_chat_message("/chat_jail XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("jailchannel", beerchat.get_player_channel("XX"))
		assert.equals("jailchannel", XX:get_meta():get_string("beerchat:current_channel"))
		assert.equals(oldchannel, XX:get_meta():get_string("beerchat:jailed"))
	end)

	it("handles players that are already jailed", function()
		local oldchannel = beerchat.get_player_channel("XX")
		SX:send_chat_message("/chat_jail XX")
		SX:send_chat_message("/chat_jail XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("jailchannel", beerchat.get_player_channel("XX"))
		assert.equals("jailchannel", XX:get_meta():get_string("beerchat:current_channel"))
		assert.equals(oldchannel, XX:get_meta():get_string("beerchat:jailed"))
	end)

	it("handles invalid player name", function()
		SX:send_chat_message("/chat_jail ***")
	end)

	it("handles empty player name", function()
		SX:send_chat_message("/chat_jail")
		assert.equals("main", beerchat.get_player_channel("SX"))
	end)

end)

describe("chat_unjail command", function()

	setup(do_setup)
	teardown(do_teardown)
	before_each(do_before_each)
	after_each(do_after_each)

	it("handles invalid player name", function()
		SX:send_chat_message("/chat_unjail ***")
	end)

	it("handles empty player name", function()
		SX:send_chat_message("/chat_unjail")
	end)

	it("handles players that are not jailed", function()
		local oldchannel = XX:get_meta():get_string("beerchat:current_channel")
		SX:send_chat_message("/chat_unjail XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("main", beerchat.get_player_channel("XX"))
		assert.is_nil(XX:get_meta():get("beerchat:jailed"))
	end)

	it("restores previous channel of jailed player", function()
		SX:send_chat_message("/cc notmain")
		XX:send_chat_message("/jc notmain")
		XX:send_chat_message("#notmain")
		local oldchannel = beerchat.get_player_channel("XX")
		SX:send_chat_message("/chat_jail XX")
		SX:send_chat_message("/chat_unjail XX")
		assert.equals("main", beerchat.get_player_channel("SX"))
		assert.equals("notmain", beerchat.get_player_channel("XX"))
		assert.equals("notmain", XX:get_meta():get_string("beerchat:current_channel"))
		assert.is_nil(XX:get_meta():get("beerchat:jailed"))
	end)

end)

describe("jail behavior", function()

	setup(do_setup)
	teardown(do_teardown)
	before_each(do_before_each)
	after_each(do_after_each)

	it("allows non jailed chatting", function()
		SX:send_chat_message("#jailchannel")
		XX:send_chat_message("#jailchannel")
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("Not jailed, jail channel test message 1")
		SX:send_chat_message("#jailchannel Not jailed, jail channel test message 2")
		-- check that 4 message were delivered, 2 for each player
		assert.spy(minetest.chat_send_player).was.called(4)
	end)

	it("allows jailed chatting", function()
		SX:send_chat_message("/chat_jail XX")
		SX:send_chat_message("#jailchannel")
		spy.on(minetest, "chat_send_player")
		XX:send_chat_message("Jailed, jail channel test message 1")
		XX:send_chat_message("#jailchannel Jailed, jail channel test message 2")
		-- check that 4 message were delivered, 2 for each player
		assert.spy(minetest.chat_send_player).was.called(4)
	end)

end)
