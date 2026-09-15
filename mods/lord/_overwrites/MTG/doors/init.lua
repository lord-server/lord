local function doors_unregister(name)
	core.unregister_item(name)
	core.unregister_item(name .. "_a")
	core.unregister_item(name .. "_b")
	core.unregister_item(name .. "_c")
	core.unregister_item(name .. "_d")

	doors.registered_doors[name .. "_a"] = nil
	doors.registered_doors[name .. "_b"] = nil
	doors.registered_doors[name .. "_c"] = nil
	doors.registered_doors[name .. "_d"] = nil
end

core.clear_craft({output = "doors:door_steel"})
doors_unregister("doors:door_steel") -- unregistering wrong door (should not have lock!)


local function doors_unregister_trapdoor(name)
	core.unregister_item(name)
	core.unregister_item(name .. "_open")

	doors.registered_trapdoors[name] = nil
	doors.registered_trapdoors[name .. "_open"] = nil
end

doors_unregister_trapdoor("doors:trapdoor_steel") -- unregistering wrong trapdoor (should not have lock!)


local function doors_unregister_gate(name)
	core.unregister_item(name.."_closed")
	core.unregister_item(name.."_open")
end

-- unregistering ugly gates
doors_unregister_gate("doors:gate_wood")
doors_unregister_gate("doors:gate_acacia_wood")
doors_unregister_gate("doors:gate_junglewood")
doors_unregister_gate("doors:gate_pine_wood")
doors_unregister_gate("doors:gate_aspen_wood")
