require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("Alias behavior", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local ANY = require("luassert.match")._
	assert:register("matcher", "has_channelmessage", function(_, args)
		return function(msg)
			return type(msg) == "table" and msg.channel == args[1] and msg.message:find(args[2]) ~= nil
		end
	end)
	local CHMSG = function(...) return require("luassert.match").has_channelmessage(...) end

	local ADMIN = Player("ADMIN", { shout = 1, [beerchat.admin_priv] = 1 })
	local SX = Player("SX", { shout = 1, ban = 1 })
	local Sam = Player("Sam", { shout = 1 })
	local Doe = Player("Doe", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(ADMIN)
		mineunit:execute_on_joinplayer(SX)
		mineunit:execute_on_joinplayer(Sam)
		mineunit:execute_on_joinplayer(Doe)
		-- Aliasing main channel and chained alias
		beerchat.channels["alias-main-1"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-main-2"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Alias loop
		beerchat.channels["alias-loop-1A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-loop-1B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-loop-2"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-loop-3"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Aliasing invalid channels
		beerchat.channels["alias-invalid"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Channel switch test
		beerchat.channels["alias-switch-A1"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-switch-A2"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-switch-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Message rejection test 1
		beerchat.channels["alias-nochat-1-A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-nochat-1-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Message delivery test 1
		beerchat.channels["alias-chat-1-A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-chat-1-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Message delivery test 2
		beerchat.channels["alias-chat-2-A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-chat-2-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Message delivery test 3, join channel help text
		beerchat.channels["alias-chat-3-A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-chat-3-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Message delivery test 4
		beerchat.channels["alias-chat-4-A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-chat-4-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		-- Message delivery test 5, /me plugin test
		beerchat.channels["alias-chat-5-A"] = { owner = "ADMIN", color = beerchat.default_channel_color }
		beerchat.channels["alias-chat-5-B"] = { owner = "ADMIN", color = beerchat.default_channel_color }
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(Doe)
		mineunit:execute_on_leaveplayer(Sam)
		mineunit:execute_on_leaveplayer(SX)
		mineunit:execute_on_leaveplayer(ADMIN)
	end)

	before_each(function()
		beerchat.set_player_channel("ADMIN", "main")
		beerchat.set_player_channel("SX", "main")
		beerchat.set_player_channel("Sam", "main")
		beerchat.set_player_channel("Doe", "main")
	end)

	it("/channel-alias without arguments", function()
		ADMIN:send_chat_message("/channel-alias")
	end)

	it("create alias to main channel", function()
		assert.not_nil(beerchat.main_channel_name)
		ADMIN:send_chat_message("/channel-alias #alias-main-1 #" .. beerchat.main_channel_name)
	end)

	it("create alias invalid channel", function()
		ADMIN:send_chat_message("/channel-alias #channel-that-does-not-exist #main")
		ADMIN:send_chat_message("/channel-alias #alias-invalid #channel-that-does-not-exist")
		ADMIN:send_chat_message("#alias-invalid")
		assert.equal(beerchat.get_player_channel("ADMIN"), "alias-invalid")
	end)

	it("create alias loop", function()
		ADMIN:send_chat_message("/channel-alias #alias-loop-1A #alias-loop-2")
		ADMIN:send_chat_message("/channel-alias #alias-loop-1B #alias-loop-2")
		ADMIN:send_chat_message("/channel-alias #alias-loop-2 #alias-loop-3")
		ADMIN:send_chat_message("/channel-alias #alias-loop-3 #alias-loop-1A")
		-- Check that all channels link to last channel in chain
		ADMIN:send_chat_message("#alias-loop-1A")
		assert.equal(beerchat.get_player_channel("ADMIN"), "alias-loop-3")
		ADMIN:send_chat_message("#alias-loop-1B")
		assert.equal(beerchat.get_player_channel("ADMIN"), "alias-loop-3")
		ADMIN:send_chat_message("#alias-loop-2")
		assert.equal(beerchat.get_player_channel("ADMIN"), "alias-loop-3")
		ADMIN:send_chat_message("#alias-loop-3")
		-- Check that last channel in chain did not cause loop
		assert.equal(beerchat.get_player_channel("ADMIN"), "alias-loop-3")
	end)

	it("resolve alias", function()
		ADMIN:send_chat_message("/channel-alias #alias-main-1")
	end)

	it("resolve alias normal channel", function()
		ADMIN:send_chat_message("/channel-alias #main")
	end)

	it("resolve alias invalid channel", function()
		ADMIN:send_chat_message("/channel-alias #channel-that-does-not-exist")
	end)

	it("remove alias", function()
		ADMIN:send_chat_message("/channel-unalias #alias-main-1")
	end)

	it("remove alias invalid channel", function()
		ADMIN:send_chat_message("/channel-unalias #channel-that-does-not-exist")
	end)

	it("remove previously removed alias", function()
		ADMIN:send_chat_message("/channel-unalias #alias-main-1")
		ADMIN:send_chat_message("/channel-unalias #alias-main-1")
	end)

	it("remove alias normal channel", function()
		ADMIN:send_chat_message("/channel-unalias #main")
	end)

	it("channel switch", function()
		-- Prepare
		ADMIN:send_chat_message("/channel-alias #alias-switch-A1 #alias-switch-B")
		ADMIN:send_chat_message("/channel-alias #alias-switch-A2 #alias-switch-B")
		-- Test
		SX:send_chat_message("#alias-switch-A1")
		assert.equal(beerchat.get_player_channel("SX"), "alias-switch-B")
		SX:send_chat_message("#alias-switch-B")
		assert.equal(beerchat.get_player_channel("SX"), "alias-switch-B")
		SX:send_chat_message("#alias-switch-A2")
		assert.equal(beerchat.get_player_channel("SX"), "alias-switch-B")
	end)

	it("handles offline players who joined channel before linking", function()
		-- Prepare
		Sam:send_chat_message("#alias-nochat-1-A")
		assert.equal(beerchat.get_player_channel("Sam"), "alias-nochat-1-A")
		mineunit:execute_on_leaveplayer(Sam)
		ADMIN:send_chat_message("/channel-alias #alias-nochat-1-A #alias-nochat-1-B")
		mineunit:execute_on_joinplayer(Sam, { lastlogin = 123 })
		-- Test
		spy.on(minetest, "chat_send_player")
		Sam:send_chat_message("#alias-nochat-1-A Test message")
		assert.spy(minetest.chat_send_player).called_with("Sam", ANY)
	end)

	it("delivers messages 1, join before", function()
		-- Prepare
		Sam:send_chat_message("#alias-chat-1-A")
		Doe:send_chat_message("#alias-chat-1-B")
		ADMIN:send_chat_message("/channel-alias #alias-chat-1-A #alias-chat-1-B")
		-- Test
		assert.equal(beerchat.get_player_channel("Sam"), "alias-chat-1-B")
		assert.equal(beerchat.get_player_channel("Doe"), "alias-chat-1-B")
		spy.on(beerchat, "execute_callbacks")
		spy.on(minetest, "chat_send_player")
		Sam:send_chat_message("#alias-chat-1-A Test message to #alias-chat-1-A")
		Doe:send_chat_message("#alias-chat-1-B Test message to #alias-chat-1-B")
		assert.spy(beerchat.execute_callbacks).called_with("before_send", "Sam", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).called_with("before_send", "Doe", ANY, ANY)
		assert.spy(minetest.chat_send_player).called(2 * 2) -- 2 players, 2 messages
	end)

	it("delivers messages 2, join after", function()
		-- Prepare
		ADMIN:send_chat_message("/channel-alias #alias-chat-2-A #alias-chat-2-B")
		Sam:send_chat_message("#alias-chat-2-A")
		Doe:send_chat_message("#alias-chat-2-B")
		-- Test
		assert.equal(beerchat.get_player_channel("Sam"), "alias-chat-2-B")
		assert.equal(beerchat.get_player_channel("Doe"), "alias-chat-2-B")
		spy.on(beerchat, "execute_callbacks")
		spy.on(minetest, "chat_send_player")
		Sam:send_chat_message("#alias-chat-2-A Test message to #alias-chat-2-A")
		Doe:send_chat_message("#alias-chat-2-B Test message to #alias-chat-2-B")
		assert.spy(beerchat.execute_callbacks).called_with("before_send", "Sam", ANY, ANY)
		assert.spy(beerchat.execute_callbacks).called_with("before_send", "Doe", ANY, ANY)
		assert.spy(minetest.chat_send_player).called(2 * 2) -- 2 players, 2 messages
	end)

	it("returns join help for aliases", function()
		-- Prepare
		ADMIN:send_chat_message("/channel-alias #alias-chat-3-A #alias-chat-3-B")
		assert.equal(beerchat.get_player_channel("SX"), "main")
		-- Test alias
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("#alias-chat-3-A Test message")
		assert.spy(minetest.chat_send_player).called_with("SX", M("join"))
		-- Test target channel
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("#alias-chat-3-B Test message")
		assert.spy(minetest.chat_send_player).called_with("SX", M("join"))
	end)

	it("delivers messages when only on target channel", function()
		-- Prepare
		beerchat.set_player_channel("SX", "alias-chat-4-B")
		ADMIN:send_chat_message("/channel-alias #alias-chat-4-A #alias-chat-4-B")
		assert.equal(beerchat.get_player_channel("SX"), "alias-chat-4-B")
		-- Test alias
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("#alias-chat-4-A Test message")
		assert.spy(minetest.chat_send_player).called_with("SX", M("Test message"))
		-- Test target channel
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("#alias-chat-4-B Test message")
		assert.spy(minetest.chat_send_player).called_with("SX", M("Test message"))
	end)

	it("delivers /me plugin messages", function()
		-- Prepare
		Sam:send_chat_message("#alias-chat-5-A")
		Doe:send_chat_message("#alias-chat-5-B")
		ADMIN:send_chat_message("/channel-alias #alias-chat-5-A #alias-chat-5-B")
		-- Test
		spy.on(beerchat, "on_send_on_channel")
		spy.on(minetest, "chat_send_player")
		Sam:send_chat_message("/me Me to #alias-chat-5-A")
		Doe:send_chat_message("/me Me to #alias-chat-5-B")
		assert.spy(beerchat.execute_callbacks).called_with("on_send_on_channel", "Sam", CHMSG("alias-chat-5-B", "Me to #alias%-chat%-5%-A"), "Sam")
		assert.spy(beerchat.execute_callbacks).called_with("on_send_on_channel", "Sam", CHMSG("alias-chat-5-B", "Me to #alias%-chat%-5%-A"), "Doe")
		assert.spy(beerchat.execute_callbacks).called_with("on_send_on_channel", "Doe", CHMSG("alias-chat-5-B", "Me to #alias%-chat%-5%-B"), "Sam")
		assert.spy(beerchat.execute_callbacks).called_with("on_send_on_channel", "Doe", CHMSG("alias-chat-5-B", "Me to #alias%-chat%-5%-B"), "Doe")
		assert.spy(minetest.chat_send_player).called_with("Sam", M("Me to #alias%-chat%-5%-A"))
		assert.spy(minetest.chat_send_player).called_with("Sam", M("Me to #alias%-chat%-5%-B"))
		assert.spy(minetest.chat_send_player).called_with("Doe", M("Me to #alias%-chat%-5%-A"))
		assert.spy(minetest.chat_send_player).called_with("Doe", M("Me to #alias%-chat%-5%-B"))
	end)

end)

describe("Alias internal protection", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local SX = Player("SX", { shout = 1, ban = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
		-- Channel removal behavior
		beerchat.channels["alias-delete-A1"] = { owner = "SX", color = beerchat.default_channel_color }
		beerchat.channels["alias-delete-A2"] = { owner = "SX", color = beerchat.default_channel_color }
		beerchat.channels["alias-delete-B1"] = { owner = "SX", color = beerchat.default_channel_color }
		beerchat.channels["alias-delete-B2"] = { owner = "SX", color = beerchat.default_channel_color }
		SX:send_chat_message("/jc #alias-delete-A1")
		SX:send_chat_message("/jc #alias-delete-A2")
		SX:send_chat_message("/jc #alias-delete-B1")
		SX:send_chat_message("/jc #alias-delete-B2")
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(SX)
	end)

	before_each(function()
		beerchat.set_player_channel("SX", "main")
	end)

	it("prevents removal of aliased channels", function()
		-- Prepare
		SX:send_chat_message("/channel-alias #alias-delete-A1 #alias-delete-A2")
		assert.equal(beerchat.get_player_channel("SX"), "main")
		-- Test
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("/dc alias-delete-A1")
		assert.not_nil(beerchat.channels["alias-delete-A1"])
		assert.spy(minetest.chat_send_player).called_with("SX", M("alias%-delete%-A1.+alias%-delete%-A2"))
	end)

	it("allows removal after unlinking", function()
		-- Prepare
		SX:send_chat_message("/channel-alias #alias-delete-B1 #alias-delete-B2")
		assert.equal(beerchat.get_player_channel("SX"), "main")
		SX:send_chat_message("/channel-unalias #alias-delete-B1")
		-- Test
		spy.on(minetest, "chat_send_player")
		SX:send_chat_message("/dc alias-delete-B1")
		assert.is_nil(beerchat.channels["alias-delete-B1"])
		assert.spy(minetest.chat_send_player).called_with("SX", M("alias%-delete%-B1.+deleted"))
	end)

end)

describe("Alias permissions", function()

	local ANY = require("luassert.match")._

	local SX = Player("SX", { shout = 1, ban = 1 })
	local Sam = Player("Sam", { shout = 1 })

	setup(function()
		mineunit:execute_on_joinplayer(SX)
		mineunit:execute_on_joinplayer(Sam)
	end)

	teardown(function()
		mineunit:execute_on_leaveplayer(Sam)
		mineunit:execute_on_leaveplayer(SX)
	end)

	it("moderator cannot link channels without any access", function()
		local source, target = "alias-noaccess-A", "alias-noaccess-B"
		beerchat.channels[source] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "Beerholder", color = beerchat.default_channel_color }
		SX:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, source)
	end)

	it("moderator cannot link channels without target access", function()
		local source, target = "alias-partial-1-A", "alias-partial-1-B"
		beerchat.channels[source] = { owner = "SX", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.add_player_channel("SX", source)
		SX:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, source)
	end)

	it("moderator cannot link channels without source access", function()
		local source, target = "alias-partial-2-A", "alias-partial-2-B"
		beerchat.channels[source] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "SX", color = beerchat.default_channel_color }
		beerchat.add_player_channel("SX", target)
		SX:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, source)
	end)

	it("moderator can link channels they can access", function()
		local source, target = "alias-access-A", "alias-access-B"
		beerchat.channels[source] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.add_player_channel("SX", source)
		beerchat.add_player_channel("SX", target)
		SX:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, target)
	end)

	it("player cannot link without any access", function()
		local source, target = "alias-sam-noaccess-A", "alias-sam-noaccess-B"
		beerchat.channels[source] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "Beerholder", color = beerchat.default_channel_color }
		Sam:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, source)
	end)

	it("player cannot link with access but no full ownership", function()
		local source, target = "alias-sam-access-A", "alias-sam-access-B"
		beerchat.channels[source] = { owner = "Sam", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "Beerholder", color = beerchat.default_channel_color }
		beerchat.add_player_channel("Sam", source)
		beerchat.add_player_channel("Sam", target)
		Sam:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, source)
	end)

	it("player can link with full ownership", function()
		local source, target = "alias-sam-own-A", "alias-sam-own-B"
		beerchat.channels[source] = { owner = "Sam", color = beerchat.default_channel_color }
		beerchat.channels[target] = { owner = "Sam", color = beerchat.default_channel_color }
		Sam:send_chat_message(("/channel-alias #%s #%s"):format(source, target))
		-- Check results
		local switch = { from = "main", to = source }
		beerchat.execute_callbacks("before_switch_chan", "Beerholder", switch)
		assert.equals(switch.to, target)
	end)

end)
