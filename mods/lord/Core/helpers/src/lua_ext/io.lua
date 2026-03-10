
--- @param name string name of checked file
--- @return boolean
function io.file_exists(name)
	local file = io.open(name, "r")
	if file ~= nil then
		io.close(file)
		return true
	end

	return false
end

--- @type number?, string?
local error_code, error_message

--- Writes `content` into file by path `filepath`.
--- Returns `true` if success or `false, error_code, error_message`.
--- Also you can get last error code and error message from `io.get_file_error` function.
---
--- @param filepath string
--- @param content  string
--- @param mode?    iolib.OpenMode default: `"w"`
---
--- @return boolean,number?,string?
function io.write_to_file(filepath, content, mode)
	mode = mode or "w"

	local file
	file, error_message, error_code = io.open(filepath, mode)
	if not file then
		return false, error_code, error_message
	end

	local success
	success, error_message, error_code = file:write(content)
	if not success then
		file:close()
		return false, (error_code or -1), (error_message or "unknown reason")
	end

	file:close()

	return true
end

--- Reads all content from file by path `filepath`.
--- Returns `string` with file content if success or `false, error_code, error_message`.
--- Also you can get last error code and error message from `io.get_file_error` function.
---
--- @param filepath string
--- @param mode?    iolib.OpenMode default: `"r"`
---
--- @return false|string|nil,number?,string?
function io.read_from_file(filepath, mode)
	mode = mode or "r"

	local file
	file, error_message, error_code = io.open(filepath, mode)
	if not file then
		return false, error_code, error_message
	end

	--- @type string|nil
	local content = file:read("*all")
	file:close()

	return content
end

--- Returns last error code and error message from `io.read_from_file` or `io.write_to_file` function.
--- @return number?, string?
function io.get_file_error()
	return error_code, error_message
end

--- @param path string
--- @return string
function io.dirname(path)
	path = path:replace('[/\\]+$', '') -- del trailing slash
	local dir = path:match('(.*)[/\\]') or '.'

	return dir ~= '' and dir or '.'
end
