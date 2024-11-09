require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("mute plugin", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local Sam = nil
	local Doe = nil
	local Dummy = nil

	local function create_and_join_players()
		Sam = Player("Sam", { shout = 1 })
		mineunit:execute_on_joinplayer(Sam)
		Doe = Player("Doe", { shout = 1 })
		mineunit:execute_on_joinplayer(Doe)
		Dummy = Player("Dummy", { shout = 1 })
		mineunit:execute_on_joinplayer(Dummy)
	end

	local function part_and_remove_players()
		mineunit:execute_on_leaveplayer(Dummy)
		Dummy = nil
		mineunit:execute_on_leaveplayer(Doe)
		Doe = nil
		mineunit:execute_on_leaveplayer(Sam)
		Sam = nil
	end

	local function assert_defaults_has_player_muted_player(name1, name2)
		assert.is_string(name1)
		assert.is_string(name2)
		assert.is_false(beerchat.has_player_muted_player(name1, name2), name2.." is muted but shouldn't be")
		assert.is_false(beerchat.has_player_muted_player(name2, name1), name1.." is muted but shouldn't be")
	end

	local function assert_defaults_allow_private_message(name1, name2)
		assert.is_string(name1)
		assert.is_string(name2)
		assert.is_true(beerchat.allow_private_message(name1, name2), name2.." blocking pm without mute")
		assert.is_true(beerchat.allow_private_message(name2, name1), name1.." blocking pm without mute")
	end

	describe("default behavior", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		it("does not mute other players", function()
			assert.is_false(beerchat.has_player_muted_player("Sam", "Doe"), "Doe is muted by default")
		end)

		it("allows pm from other players", function()
			assert.is_true(beerchat.allow_private_message("Sam", "Doe"), "Doe blocking pm by default")
		end)

		it("does not mute self", function()
			assert.is_false(beerchat.has_player_muted_player("Sam", "Sam"), "Sam is muted by default")
		end)

		it("allows pm from self", function()
			assert.is_true(beerchat.allow_private_message("Sam", "Sam"), "Sam blocking pm by default")
		end)

		it("not muted from local to remote", function()
			assert.is_false(beerchat.has_player_muted_player("[user]", "Sam"), "Sam is muted by default")
		end)

		it("not muted from remote to local", function()
			assert.is_false(beerchat.has_player_muted_player("Sam", "[user]"), "[user] is muted by default")
		end)

		it("allows private message from local to remote", function()
			assert.is_true(beerchat.allow_private_message("Sam", "[user]"), "[user] blocking pm by default")
		end)

		it("allows private message from remote to local", function()
			assert.is_true(beerchat.allow_private_message("[user]", "Sam"), "Sam blocking pm by default")
		end)

		it("does not mute remote self", function()
			assert.is_false(beerchat.has_player_muted_player("[user]", "[user]"), "[user] is muted by default")
		end)

		it("allows pm from remote self", function()
			assert.is_true(beerchat.allow_private_message("[user]", "[user]"), "[user] blocking pm by default")
		end)

	end)

	describe("beerchat.has_player_muted_player", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		it("/mute & /unmute player", function()
			-- Sam mutes Doe, Doe is muted for Sam but Sam is not muted for Doe
			Sam:send_chat_message("/mute Doe")
			assert.is_true(beerchat.has_player_muted_player("Sam", "Doe"), "Doe isn't muted but should be")
			assert.is_false(beerchat.has_player_muted_player("Doe", "Sam"), "Sam is muted but shouldn't be")

			-- Sam unmutes Doe, Doe is not muted for Sam anymore and defaults apply
			Sam:send_chat_message("/unmute Doe")
			assert_defaults_has_player_muted_player("Doe", "Sam")
		end)

		it("/mute & /unmute remote user", function()
			-- Sam mutes [user], [user] is muted for Sam
			Sam:send_chat_message("/mute [user]")
			assert.is_true(beerchat.has_player_muted_player("Sam", "[user]"), "[user] isn't muted but should be")
			assert.is_false(beerchat.has_player_muted_player("[user]", "Sam"), "Sam is muted but shouldn't be")

			-- Sam unmutes [user], defaults apply
			Sam:send_chat_message("/unmute [user]")
			assert_defaults_has_player_muted_player("Doe", "Sam")
		end)

		it("/mute & /unmute both players", function()
			-- Sam and Doe mutes each other, both are muted
			Sam:send_chat_message("/mute Doe")
			Doe:send_chat_message("/mute Sam")
			assert.is_true(beerchat.has_player_muted_player("Sam", "Doe"), "Doe isn't muted but should be")
			assert.is_true(beerchat.has_player_muted_player("Doe", "Sam"), "Sam isn't muted but should be")

			-- Sam and Doe unmutes each other, both are unmuted and defaults apply
			Sam:send_chat_message("/unmute Doe")
			Doe:send_chat_message("/unmute Sam")
			assert_defaults_has_player_muted_player("Doe", "Sam")
		end)

	end)

	describe("beerchat.allow_private_message", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		it("/mute & /unmute player", function()
			-- Sam mutes Doe, Doe is muted for Sam but Sam is not muted for Doe
			Sam:send_chat_message("/mute Doe")
			assert.is_true(beerchat.allow_private_message("Sam", "Doe"), "Doe blocking pm without mute")
			assert.is_false(beerchat.allow_private_message("Doe", "Sam"), "Sam allows pm after mute")

			-- Sam unmutes Doe, Doe is not muted for Sam anymore and defaults apply
			Sam:send_chat_message("/unmute Doe")
			assert_defaults_allow_private_message("Doe", "Sam")
		end)

		it("/mute & /unmute remote user", function()
			-- Sam mutes [user], [user] is muted for Sam
			Sam:send_chat_message("/mute [user]")
			assert.is_true(beerchat.allow_private_message("Sam", "[user]"), "[user] blocking pm without mute")
			assert.is_false(beerchat.allow_private_message("[user]", "Sam"), "Sam allows pm after mute")

			-- Sam unmutes [user], defaults apply
			Sam:send_chat_message("/unmute [user]")
			assert_defaults_allow_private_message("Doe", "Sam")
		end)

		it("/mute & /unmute both players", function()
			-- Sam and Doe mutes each other, both are muted
			Sam:send_chat_message("/mute Doe")
			Doe:send_chat_message("/mute Sam")
			assert.is_false(beerchat.allow_private_message("Sam", "Doe"), "Mute not blocking pm from Sam")
			assert.is_false(beerchat.allow_private_message("Doe", "Sam"), "Mute not blocking pm from Doe")

			-- Sam and Doe unmutes each other, both are unmuted and defaults apply
			Sam:send_chat_message("/unmute Doe")
			Doe:send_chat_message("/unmute Sam")
			assert_defaults_allow_private_message("Doe", "Sam")
		end)

	end)

	describe("integrations", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		it("whisper is muted & unmuted", function()
			local message = "This is a pm mute test"
			-- Sam mutes Doe, Sam does not receive whispers from Doe
			Sam:send_chat_message("/mute Doe")
			spy.on(minetest, "chat_send_player")
			Doe:send_chat_message("$ " .. message)
			assert.spy(minetest.chat_send_player).called_with("Dummy", M(message))
			assert.spy(minetest.chat_send_player).not_called_with("Sam", M(message))

			-- Sam unmutes Doe, Sam receives whispers from Doe
			Sam:send_chat_message("/unmute Doe")
			spy.on(minetest, "chat_send_player")
			Doe:send_chat_message("$ " .. message)
			assert.spy(minetest.chat_send_player).called_with("Dummy", M(message))
			assert.spy(minetest.chat_send_player).called_with("Sam", M(message))
		end)

		it("pm is muted & unmuted", function()
			local message = "This is a private message mute test"
			-- Sam mutes Doe, Sam does not receive private message from Doe
			Sam:send_chat_message("/mute Doe")
			spy.on(minetest, "chat_send_player")
			Doe:send_chat_message("@Sam " .. message)
			Doe:send_chat_message("@Dummy " .. message)
			assert.spy(minetest.chat_send_player).not_called_with("Sam", M(message))
			assert.spy(minetest.chat_send_player).called_with("Dummy", M(message))

			-- Sam unmutes Doe, Sam receives private message from Doe
			Sam:send_chat_message("/unmute Doe")
			spy.on(minetest, "chat_send_player")
			Doe:send_chat_message("@Sam " .. message)
			Doe:send_chat_message("@Dummy " .. message)
			assert.spy(minetest.chat_send_player).called_with("Sam", M(message))
			assert.spy(minetest.chat_send_player).called_with("Dummy", M(message))
		end)

	end)

	describe("invalid input", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		it("allows before_send_pm nil source", function()
			assert.not_has_error(function()
				beerchat.execute_callbacks('before_send_pm', nil, "test message", "Sam")
			end)
		end)

		it("throws before_send_pm nil destination", function()
			assert.has_error(function()
				beerchat.execute_callbacks('before_send_pm', "Sam", "test message", nil)
			end)
		end)

	end)

	describe("other chatcommands", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		it("allows /list_muted", function()
			spy.on(minetest, "chat_send_player")
			Sam:send_chat_message("/list_muted")
			assert.spy(minetest.chat_send_player).called_with("Sam", M("not muted any players"))
		end)

		it("lists names with /list_muted", function()
			Sam:send_chat_message("/mute Doe")
			Sam:send_chat_message("/mute SomeoneWhoIsntThere")
			spy.on(minetest, "chat_send_player")
			Sam:send_chat_message("/list_muted")
			assert.spy(minetest.chat_send_player).called_with("Sam", M("Doe.*SomeoneWhoIsntThere"))
		end)

		it("repeat /mute", function()
			Sam:send_chat_message("/mute Doe")
			spy.on(minetest, "chat_send_player")
			Sam:send_chat_message("/mute Doe")
			assert.spy(minetest.chat_send_player).called_with("Sam", M("already muted"))
		end)

		it("repeat /unmute", function()
			Sam:send_chat_message("/unmute Doe")
			spy.on(minetest, "chat_send_player")
			Sam:send_chat_message("/unmute Doe")
			assert.spy(minetest.chat_send_player).called_with("Sam", M("not muted"))
		end)

		it("empty /mute", function()
			spy.on(minetest, "chat_send_player")
			Sam:send_chat_message("/mute")
			assert.spy(minetest.chat_send_player).called_with("Sam", M("nvalid.*argument"))
		end)

		it("empty /unmute", function()
			spy.on(minetest, "chat_send_player")
			Sam:send_chat_message("/unmute")
			assert.spy(minetest.chat_send_player).called_with("Sam", M("nvalid.*argument"))
		end)

	end)

	describe("chat", function()
		before_each(create_and_join_players)
		after_each(part_and_remove_players)

		local function assert_chat_delivery(player, message, test)
			spy.on(minetest, "chat_send_player")
			player:send_chat_message(message)
			test(assert.spy(minetest.chat_send_player), message)
		end

		it("not blocking by default", function()
			assert_chat_delivery(Sam, "not blocking by default", function(spy, msg)
				spy.called_with("Doe", M(msg))
			end)
		end)

		it("not blocking others if muted self", function()
			Sam:send_chat_message("/mute Sam")
			assert_chat_delivery(Sam, "not blocking others if muted self", function(spy, msg)
				spy.called_with("Doe", M(msg))
			end)
		end)

		it("not blocking if muted by sender", function()
			Sam:send_chat_message("/mute Doe")
			assert_chat_delivery(Sam, "not blocking if muted by sender", function(spy, msg)
				spy.called_with("Doe", M(msg))
			end)
		end)

		it("not blocking if unmuted", function()
			Doe:send_chat_message("/mute Sam")
			Doe:send_chat_message("/unmute Sam")
			assert_chat_delivery(Sam, "not blocking if unmuted", function(spy, msg)
				spy.called_with("Doe", M(msg))
			end)
		end)

		it("blocking if muted by recipient", function()
			Doe:send_chat_message("/mute Sam")
			assert_chat_delivery(Sam, "blocking if muted by recipient", function(spy, msg)
				spy.not_called_with("Doe", M(msg))
			end)
		end)

	end)

end)
