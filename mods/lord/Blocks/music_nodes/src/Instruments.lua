---
--- @class music_nodes.Instrument
--- @field name string Идентификатор инструмента
--- @field description string Описание инструмента
--- @field tiles string[] Список текстур
--- @field instrument_type string Тип инструмента
--- @field notes table<number, {note: string, pitch: number}> Таблица нот
--- @field sound string Имя звукового файла

---
--- @class music_nodes.Instruments
---
local Instruments = {
	--- @static
	--- @type table<string, music_nodes.Instrument>
	registered_instruments = {},
}
Instruments.__index = Instruments

--- Регистрирует инструмент в реестре
--- @public
--- @param instrument music_nodes.Instrument
function Instruments.register(instrument)
	Instruments.registered_instruments[instrument.name] = instrument
end

--- Возвращает инструмент по имени
--- @public
--- @param name string
--- @return music_nodes.Instrument|nil
function Instruments.get(name)

	return Instruments.registered_instruments[name]
end

--- Возвращает все зарегистрированные инструменты
--- @public
--- @return table<string, music_nodes.Instrument>
function Instruments.get_all()

	return Instruments.registered_instruments
end

--- Наш конструктор инструмента с наследованием
--- @public
--- @generic T: music_nodes.Instruments
--- @param opts T Параметры инструмента
--- @return T
function Instruments:new(opts)
	opts = opts or {}

	return setmetatable(opts, { __index = self })
end

--- Метод для расширения класса (наследования)
--- @public
--- @generic T: music_nodes.Instruments
--- @param child_class T
--- @return T
function Instruments:extended(child_class)

	return setmetatable(child_class or {}, { __index = self })
end


return Instruments
