require("mineunit")

mineunit("core")
mineunit("player")
mineunit("server")

sourcefile("init")

describe("Hooks", function()

	local M = function(s) return require("luassert.match").matches(s) end
	local SX = Player("SX", { shout = 1 })
	local Sam = Player("Sam", { shout = 1 })
	local Doe = Player("Doe", { shout = 1 })

	-- Use custom event handler to count on_receive calls
	local call_count = {}
	local function test(desc, msg, event, expected_count, recipient, match)
		local assert_chat_msg = 'Event "%s %s %s" did not deliver expected chat message "%s"'
		local assert_msg = '%s called %d times, expected %d times. Message: "%s"'
		if not call_count[event] then
			call_count[event] = 0
			beerchat.register_callback(event, function()
				call_count[event] = call_count[event] + 1
			end)
		end
		it(desc.." "..msg, function()
			if recipient and match then
				spy.on(minetest, "chat_send_player")
			end
			SX:send_chat_message(msg)
			local temp_count = call_count[event]
			call_count[event] = 0
			assert(temp_count == expected_count, assert_msg:format(event, temp_count, expected_count, msg))
			if recipient and match then
				local error_msg = assert_chat_msg:format(event, desc, msg, match)
				assert.spy(minetest.chat_send_player, error_msg).called_with(recipient, M(match))
			end
		end)
	end

	local function describemethod(event, fn)
		describe(event, fn(event))
	end

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

	describemethod("on_receive", function(evt) return function()
		test("executed once for", "default message", evt, 1, "Sam", "main.+default message")
		test("executed once for", "#main test message", evt, 1, "Sam", "main.+test message")
		test("executed once for", "$ test message", evt, 1, "Sam", "test message")
		test("executed once for", "/me test message", evt, 1, "Sam", "test message")
		test("executed once for", "/whis test message", evt, 1, "Sam", "test message")
		test("executed once for", "@Sam test message", evt, 1, "Sam", "test message")
		test("executed once for", "/msg Sam test message", evt, 1, "Sam", "test message")
	end end)

	describemethod("before_send", function(evt) return function()
		test("executed once/player for", "default message", evt, 3, "Doe", "main.+default message")
		test("executed once/player for", "#main test message", evt, 3, "Doe", "main.+test message")
		test("executed once/player for", "$ test message", evt, 3, "Doe", "test message")
		test("executed once/player for", "/me test message", evt, 3, "Doe", "test message")
		test("executed once/player for", "/whis test message", evt, 3, "Doe", "test message")
		test("not executed for", "@Sam test message", evt, 0)
		test("not executed for", "/msg Sam test message", evt, 0)
	end end)

	describemethod("before_send_on_channel", function(evt) return function()
		test("executed once for", "default message", evt, 1)
		test("executed once for", "#main test message", evt, 1)
		test("not executed for", "$ test message", evt, 0)
		test("executed once for", "/me test message", evt, 1)
		test("not executed for", "/whis test message", evt, 0)
		test("not executed for", "@Sam test message", evt, 0)
		test("not executed for", "/msg Sam test message", evt, 0)
	end end)

	describemethod("on_send_on_channel", function(evt) return function()
		test("executed once/player for", "default message", evt, 3)
		test("executed once/player for", "#main test message", evt, 3)
		test("not executed for", "$ test message", evt, 0)
		test("executed once/player for", "/me test message", evt, 3)
		test("not executed for", "/whis test message", evt, 0)
		test("not executed for", "@Sam test message", evt, 0)
		test("not executed for", "/msg Sam test message", evt, 0)
	end end)

	describe("invalid input", function()

		it("handles before_send_pm empty message and recipient", function()
			beerchat.execute_callbacks('before_send_pm', "Sam", "", "")
		end)

		it("handles before_send_pm self recipient", function()
			beerchat.execute_callbacks('before_send_pm', "Sam", "test message", "Sam")
		end)

	end)

end)
