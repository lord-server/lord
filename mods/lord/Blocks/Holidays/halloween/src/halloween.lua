local jack_o_lantern = require('halloween.jack_o_lantern')
local treats         = require('halloween.treats')


--- Проверяет, находится ли текущая дата в хэллоуинском периоде
--- @return boolean true если текущая дата в периоде с 24 октября по 7 ноября, иначе false
local function is_halloween_season()
	local now = os.date('*t')
	local month, day = now.month, now.day
	return (month == 10 and day >= 24) or (month == 11 and day <= 14)
end

--- Подмена хэллоуинских текстур и дропа
-- Заменяет стандартные текстуры на хэллоуинские и добавляет candy_treat в дроп
-- Текстуры назгула меняем в `nazguls.lua:21` и `nazguls.lua:83`
-- Вызывается автоматически при загрузке мода если текущая дата в хэллоуинском периоде
local function apply_halloween_changes()
	if not is_halloween_season() then return end
	local nazgul_def     = minetest.registered_entities['lottmobs:nazgul']
	local witch_king_def = minetest.registered_entities['lottmobs:witch_king']

	if nazgul_def then
		-- Добавляем candy_treat в начало таблицы чтоб увеличить приоритет дропа
		table.insert(nazgul_def.drops, 1, {
			name   = 'halloween:candy_treat',
			chance = 2,
			min    = 1,
			max    = 3,
		})
	end
	if witch_king_def then
		-- Добавляем candy_treat в начало таблицы чтоб увеличить приоритет дропа
		table.insert(witch_king_def.drops, 1, {
			name   = 'halloween:candy_treat',
			chance = 1,
			min    = 2,
			max    = 5,
		})
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		jack_o_lantern.register()
		treats.register()
		minetest.after(0, apply_halloween_changes)
	end,
}
