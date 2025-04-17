local S = minetest.get_mod_translator()

-- todo: extract into `lord_chests`. #2049
minetest.register_tool("lottblocks:lockpick", {
	description     = S("Lockpick"),
	inventory_image = "lottblocks_steel_lockpick.png", --Made by HeroOfTheWinds
	--https://github.com/HeroOfTheWinds/lockpicks/blob/master/textures/steel_lockpick.png
	max_stack       = 1,
})

minetest.register_craft({
	output = "lottblocks:lockpick",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "", "default:steel_ingot", "default:steel_ingot" },
		{ "", "group:stick", "" }
	}
})

--- Обработчик отмычки
--- Проверяет, срабатывает ли отмычка.
---@param itemstack   ItemStack стак, содержащий отмычку;
---@param player_name string    имя игрока, использующего отмычку.
---@return boolean сработало или нет.
function lottblocks.lockpick_can_break_in(itemstack, player_name)
	itemstack:add_wear(65535 / 20)
	if math.random(1, 4) ~= 3 then
		minetest.chat_send_player(player_name, S("Lockpick failed"))
		return false
	else
		return true
	end
end
