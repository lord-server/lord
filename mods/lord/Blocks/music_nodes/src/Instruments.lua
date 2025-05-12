local Instruments = {}
Instruments.__index = Instruments

-------------------------------
-- Реестр инструментов START --
-------------------------------

--- @table Локальный реестр зарегистрированных инструментов
local registered_instruments = {}

--- Регистрирует инструмент в модуле
--- @param instrument table Объект инструмента (должен содержать поле .name)
--- @return nil
function Instruments.register(instrument)
	registered_instruments[instrument.name] = instrument
end

--- Возвращает все зарегистрированные инструменты
--- @return table -- Таблица вида {[name] = instrument}
function Instruments.get_all()

return registered_instruments
end

-----------------------------
-- Реестр инструментов END --
-----------------------------

--- Конструктор инструмента. Создаёт новый объект с наследованием от Instruments.
--- @param opts table Таблица параметров инструмента (обязательные поля: name, description и др.)
--- @return table -- Новый объект инструмента
function Instruments:new(opts)
	opts = opts or {}
	-- Настраиваем метатаблицу для наследования методов
	setmetatable(opts, self)
	self.__index = self

return opts
end


return Instruments
