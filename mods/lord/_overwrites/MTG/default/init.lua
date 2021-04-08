

-- default/chests.lua
-- Нам нужно только подсунуть свой фон (background), но для этого приходится переопределить ф-цию:
local old_chest_get_chest_formspec = default.chest.get_chest_formspec
default.chest.get_chest_formspec = function(pos)
	return old_chest_get_chest_formspec(pos) .. "background[-0.5,-0.65;9,10.35;gui_chestbg.png]"
end



-- default/furnace.lua
-- Нам нужно только подсунуть свой фон
local old_get_furnace_active_formspec = default.get_furnace_active_formspec
local old_get_furnace_inactive_formspec = default.get_furnace_inactive_formspec
default.get_furnace_active_formspec = function(fuel_percent, item_percent)
	return old_get_furnace_active_formspec(fuel_percent, item_percent) ..
		"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"
end
default.get_furnace_inactive_formspec = function()
	return old_get_furnace_inactive_formspec() ..
		"background[-0.5,-0.65;9,10.35;gui_furnacebg.png]"
end



-- default/tools.lua
-- свои кирки, лопаты, топоры, мечи и пр. мы определяем в моде `lord/tools/`,
-- поэтому тут мы подчищаем все эти тулзы из `MTG/default`
--
-- (!) сделано без циклов, чтобы выдавалось в поиске по проекту

minetest.unregister_item("default:pick_wood")
minetest.unregister_item("default:pick_stone")
minetest.unregister_item("default:pick_bronze")
minetest.unregister_item("default:pick_steel")
minetest.unregister_item("default:pick_mese")
minetest.unregister_item("default:pick_diamond")
minetest.clear_craft({output = "default:pick_wood"})
minetest.clear_craft({output = "default:pick_stone"})
minetest.clear_craft({output = "default:pick_bronze"})
minetest.clear_craft({output = "default:pick_steel"})
minetest.clear_craft({output = "default:pick_mese"})
minetest.clear_craft({output = "default:pick_diamond"})

minetest.unregister_item("default:shovel_wood")
minetest.unregister_item("default:shovel_stone")
minetest.unregister_item("default:shovel_bronze")
minetest.unregister_item("default:shovel_steel")
minetest.unregister_item("default:shovel_mese")
minetest.unregister_item("default:shovel_diamond")
minetest.clear_craft({output = "default:shovel_wood"})
minetest.clear_craft({output = "default:shovel_stone"})
minetest.clear_craft({output = "default:shovel_bronze"})
minetest.clear_craft({output = "default:shovel_steel"})
minetest.clear_craft({output = "default:shovel_mese"})
minetest.clear_craft({output = "default:shovel_diamond"})

minetest.unregister_item("default:axe_wood")
minetest.unregister_item("default:axe_stone")
minetest.unregister_item("default:axe_bronze")
minetest.unregister_item("default:axe_steel")
minetest.unregister_item("default:axe_mese")
minetest.unregister_item("default:axe_diamond")
minetest.clear_craft({output = "default:axe_wood"})
minetest.clear_craft({output = "default:axe_stone"})
minetest.clear_craft({output = "default:axe_bronze"})
minetest.clear_craft({output = "default:axe_steel"})
minetest.clear_craft({output = "default:axe_mese"})
minetest.clear_craft({output = "default:axe_diamond"})

minetest.unregister_item("default:sword_wood")
minetest.unregister_item("default:sword_stone")
minetest.unregister_item("default:sword_bronze")
minetest.unregister_item("default:sword_steel")
minetest.unregister_item("default:sword_mese")
minetest.unregister_item("default:sword_diamond")
minetest.clear_craft({output = "default:sword_wood"})
minetest.clear_craft({output = "default:sword_stone"})
minetest.clear_craft({output = "default:sword_bronze"})
minetest.clear_craft({output = "default:sword_steel"})
minetest.clear_craft({output = "default:sword_mese"})
minetest.clear_craft({output = "default:sword_diamond"})
