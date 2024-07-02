
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

--- Writes `content` into file by path `filepath`
--- Returns `true` if success or `false, error_code, error_message`
---
--- @param filepath string
--- @param content  string
--- @param mode     string default: `"w"`
---
--- @return file|nil,nil|number,nil|string
---
--- @overload fun(filepath:string, content:string):boolean,nil|number,nil|string
--- @overload fun(filepath:string, content:string):boolean,nil|number,nil|string
function io.write_to_file(filepath, content, mode)
	mode = mode or "w"

	local file, error_message, error_code = io.open(filepath, mode)
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
