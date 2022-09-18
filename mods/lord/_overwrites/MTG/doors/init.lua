local function doors_unregister(name)
	minetest.unregister_item(name)
	minetest.unregister_item(name .. "_a")
	minetest.unregister_item(name .. "_b")
	minetest.unregister_item(name .. "_c")
	minetest.unregister_item(name .. "_d")

	doors.registered_doors[name .. "_a"] = nil
	doors.registered_doors[name .. "_b"] = nil
	doors.registered_doors[name .. "_c"] = nil
	doors.registered_doors[name .. "_d"] = nil
end

doors_unregister("doors:door_steel") -- unregistering wrong door (should not have lock!)


local function doors_unregister_trapdoor(name)
	minetest.unregister_item(name)
	minetest.unregister_item(name .. "_open")

	doors.registered_trapdoors[name] = nil
	doors.registered_trapdoors[name .. "_open"] = nil
end

doors_unregister_trapdoor("doors:trapdoor_steel") -- unregistering wrong trapdoor (should not have lock!)


local function doors_unregister_gate(name)
	minetest.unregister_item(name.."_closed")
	minetest.unregister_item(name.."_open")
end

-- unregistering ugly gates
doors_unregister_gate("doors:gate_wood")
doors_unregister_gate("doors:gate_acacia_wood")
doors_unregister_gate("doors:gate_junglewood")
doors_unregister_gate("doors:gate_pine_wood")
doors_unregister_gate("doors:gate_aspen_wood")
