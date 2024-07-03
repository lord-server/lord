local items, colorize
		= minetest.registered_items, minetest.colorize

local S = minetest.get_translator(minetest.get_current_modname())


local properties = {
	"crumbly", "cracky", "snappy", "choppy", "fleshy", "explody",
}


local function register_properties_snippet()
	tt.register_snippet(function(itemstring)
		local groups      = items[itemstring].groups

		local prop_strings = {}
		for _, property in pairs(properties) do
			if table.has_key(groups, property) then
				prop_strings[#prop_strings+1] = "  • " .. colorize("#aaa", S(property)) .. ": " .. groups[property]
			end
		end

		return #prop_strings ~= 0
			and (colorize("#ee8", "\n" .. S("Properties")) .. ":\n" .. table.concat(prop_strings, "\n"))
			or nil
	end)
end


return {
	init = function()
		register_properties_snippet()
	end,
}
