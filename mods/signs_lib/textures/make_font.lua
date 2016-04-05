-- Used by `build_char_db' to locate the file.
local FONT_FMT = "%s/hdf_%02x.png"

-- Simple texture name for building text texture.
local FONT_FMT_SIMPLE = "hdf_%02x.png"

-- Path to the textures.
local TP = MP.."/textures"

	for c = 32, 255 do

		-- ***** badger ***** создание файлов, чтобы не было ошибки.
		-- Пытается открыть файл в режиме "чтения/записи"
		local f
		f = io.open(FONT_FMT:format(TP, c),"r+");
		-- Если файл не существует
		if f == nil then 
			-- Создает файл в режиме "записи"
			f = io.open(FONT_FMT:format(TP, c),"w"); 
			-- Закрывает файл
			f:close();
			-- Открывает уже существующий файл в режиме "чтения/записи"
			--f = io.open(FONT_FMT:format(TP, c),"r+");
			-- записываем данные
			-- закрываем файл
		else
			f:close();
		end;
		-- ***** badger *****
	end
