local nodes_file = core.get_worldpath() .. "/nodes.list"
local tools_file = core.get_worldpath() .. "/tools.list"
local items_file = core.get_worldpath() .. "/items.list"

core.register_privilege("lists", {
	description = "Возможность выводить списки зарегестрированных блоков, инструментов и предметов в файлы",
})

--- Writes given definition table (core.registered_nodes/tools/craftitems) to given text file.
---@param filepath string
---@param defs NodeDefinition[]|table<string,table>
local function def2file(filepath, defs)
	local list = {}
	for name, def in pairs(defs) do
		if name == "air" then name = ":air" end
		if name == "ignore" then name = ":ignore" end
		local desc         = core.get_translated_string("ru", def.description)
		local escaped_desc = string.replace(desc, "\n", " ")
		table.insert(list, string.format("%s\t%s", name, escaped_desc))
	end

	local wrote, _, error_message = io.write_to_file(filepath, table.concat(list, "\n"))
	if not wrote then error("[debugtools] can't open file: " .. filepath .. ": " .. error_message) end
end

core.register_chatcommand("lists", {
	description =
		"Вывести списки зарегестрированных блоков, инструментов и предметов в файлы nodes.list, tools.list, items.list",
	privs = {lists = true},
	func = function(name)
		local c = os.clock()
		def2file(nodes_file, core.registered_nodes)
		def2file(tools_file, core.registered_tools)
		def2file(items_file, core.registered_craftitems)
		return true, string.format("Успешно записано! Выполнение команды заняло: %f сек.", os.clock() - c)
	end
})
