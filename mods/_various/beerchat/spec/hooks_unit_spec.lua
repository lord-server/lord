require("mineunit")

describe("Hooks unit test", function()

	-- Use `hooks_spec.lua` for integration tests, this is `hooks_unit_spec.lua`.
	-- This specification is intended to only do bare unit tests for hooks and requires clean environment.

	-- Load bare hooks.lua, assuming no dependencies other than empty global table `beerchat`.
	_G.beerchat = {}
	sourcefile("hooks")

	local order_index
	before_each(function()
		order_index = 0
	end)

	local function expect_order(expected)
		return function()
			order_index = order_index + 1
			assert.equal(order_index, expected)
		end
	end

	it("handles priority correctly", function()
		beerchat.register_callback("on_receive", expect_order(2), 10)
		beerchat.register_callback("on_receive", expect_order(1), 5)
		beerchat.register_callback("on_receive", expect_order(3), 15)
		beerchat.execute_callbacks("on_receive")
		assert.equal(order_index, 3)
	end)

	it("handles priority text correctly", function()
		beerchat.register_callback("before_join", expect_order(2), "medium")
		beerchat.register_callback("before_join", expect_order(5), "lowest")
		beerchat.register_callback("before_join", expect_order(1), "high")
		beerchat.register_callback("before_join", expect_order(4), "low")
		beerchat.register_callback("before_join", expect_order(3), "default")
		beerchat.execute_callbacks("before_join")
		assert.equal(order_index, 5)
	end)

	it("handles mixed priority correctly", function()
		beerchat.register_callback("before_send", expect_order(2), "medium")
		beerchat.register_callback("before_send", expect_order(5), "lowest")
		beerchat.register_callback("before_send", expect_order(1), 0)
		beerchat.register_callback("before_send", expect_order(4), "low")
		beerchat.register_callback("before_send", expect_order(3))
		beerchat.execute_callbacks("before_send")
		assert.equal(order_index, 5)
	end)

end)
