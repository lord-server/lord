
local function find_foods_after_mods_loaded()
	minetest.register_on_mods_loaded(function()
		for key, value in pairs(minetest.registered_items) do
			if value._tt_food then
				print(key .. "\t" .. value._tt_food_hp )
			end
		end
	end)
end


find_foods_after_mods_loaded()
