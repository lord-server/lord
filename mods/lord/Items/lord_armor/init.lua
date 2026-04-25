minetest.mod(function(mod)
if mod.settings:get_bool('toggle_dwarf_armor', false) then
    -- отменяем регистрацию старой брони
		return
     -- регистрируем новую броню
	end

    require("armor")
    require("shield")
end)