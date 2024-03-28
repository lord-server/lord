
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
