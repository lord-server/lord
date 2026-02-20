# Code Style Guidelines
**Русский** | [English](code-style.en.md)

Мы придерживаемся общепринятых правил code-style.  
И этот документ не является полным описанием всех правил code-style, 
а лишь дополнением к общепризнанным стандартам в языках программирования.

## Наши исключения и дополнения

### Длина строки
- Максимальная длина строки: **120 символов**

### Табуляция и отступы
- Используйте **табы** для отступов
- Используйте **пробелы** для выравнивания/отступов внутри строк

**Исключение:**  
**4 пробела** вместо таба в первом блоке с локальными присвоениями внешних функций:
```lua
local math_floor, math_random, v
····= math.floor, math.random, vector.new
```

### Выравнивание
- **Таблицы и структуры**: выравнивайте значения по вертикали для читаемости
- **Подряд идущие присвоения**: выравнивайте знаки `=`
- **Элементы массивов/таблиц**: выравнивайте значения

Рекомендуется:
- **Комментарии справа от кода**: выравнивайте по колонке
- **Другие выравнивания**, улучшающие читаемость и хорошо вписывающиеся в код

### Пробелы
- **Внутри таблиц**: пробел после открывающей скобки и перед закрывающей `{ a = 1 }`
- **После запятой**: всегда ставьте пробел `{ a, b, c }`
- **Вокруг операторов**:
  - пробелы вокруг `=`, `+`, `-`, `..`, `and`, `or`
  - допускается отсутствие пробелов вокруг `*`, `/`, `%`, `^`, `..`
- **В doc-block'ах**: после `---` всегда ставьте пробел

Рекомендации:
- **В комментариях**: пробел после знаков комментария(`--`): `-- комментарий`, не `--комментарий`

### Именование
- **Константы** пишутся капслоком: `MAX_PLAYERS`, `DEFAULT_COLOR`
- **Переменные, содержащие описание "класса"** начинаются с большой буквы: `Player`, `World`
- **Остальные переменные** начинаются с маленькой буквы snake_case'ом: `player_name`, `position`

### Кавычки
- Используются **одинарные кавычки** (в новых файлах и по ходу изменений/рефакторинга)

### Пустые строки
- Перед `return` из функции/метода — **1 пустая строка**
  - **Исключение**: если это единственный statement в блоке кода (в `if`, `for`, `function`, ...) — **0 пустых строк**
- Между `local-aliases`-блоком (локальных присвоений внешних функций) и `require`-блоком — **1 пустая строка**
- После `require`-блока (или после `local-aliases`-блока, если `require`-блок отсутствует) — **2 пустые строки**
- Перед `return` из модуля/класса (из файла) — **2 пустые строки**
- Между функциями/методами — **1 пустая строка**
  - **Исключение**: если это функции внутри definition-блока — **0 пустых строк** (как и между остальными элементами таблицы)

## Примеры

### Правильное именование и выравнивание
```lua
local MAX_HEALTH     = 100
local MAX_PLAYERS    = 16
local Player         = setmetatable({}, { __index = parent })
local player_name    = 'alek'
local position       = { x =   0, y =  0, z =   0 }
local spawn_position = { x = 100, y = 32, z = 200 }
```

### Правильное форматирование
```lua
local require, setmetatable, math_floor, math_random, v          -- это local-aliases-блок
    = require, setmetatable, math.floor, math.random, vector.new -- после него 1 пустая - если есть require-блок или 2 пустые - если нет

local core  = require('core')  -- это require-блок
local utils = require('utils') -- перед ним 1 пустая строка, т.к. есть local-aliases-блок; после него 2 пустые


-- Класс/модуль
local Player = {}

--- Creates new player
--- @param name string
--- @return Player
function Player:new(name)
	local class = self

	self = {
		name   = name,
		health = 100,
		pos    = { x = 0, y = 0, z = 0 }
	}

	return setmetatable(self, { __index = class })
end

--- Returns player name
--- @return string
function Player:get_name()
	return self.name
end

--- Decreases player's health or kills them if health is less than or equal to 0
--- @param amount integer
function Player:take_damage(amount)
	self.health = self.health - amount
	if self.health <= 0 then
		self:die()
	end
end


return Player -- перед `return` модуля/класса (из файла) 2 пустые строки
```

### Пустые строки перед `return` функции
```lua
local function get_player_name(player)
	return player:get_player_name() -- единственный statement в блоке `function` - без пустой строки перед `return`
end

local function get_lower_player_name(player)
	local name
	name = player:get_player_name()
	name = name:lower()

	return name -- не единственный statement в блоке `function` - с пустой строкой перед `return`
end

local function is_admin(player)
	if minetest.check_player_privs(player, {admin = true}) then
		return true -- единственный statement в блоке `if` - без пустой строки перед return
	end

	return false -- это уже второй statement в функции (первый - `if`) - с пустой строкой перед return
end

local function process_command(player, cmd)
	if not cmd or cmd == '' then
		minetest.chat_send_player(player:get_player_name(), 'Empty command')

		return false -- `return` не единственный в блоке `if` - с пустой строкой перед `return`
	end

	-- обработка команды...

	return true -- не единственный - пустая строка перед `return`
end
```
