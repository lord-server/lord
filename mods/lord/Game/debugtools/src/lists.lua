local nodes_file = minetest.get_worldpath() .. "/nodes.list"
local tools_file = minetest.get_worldpath() .. "/tools.list"
local items_file = minetest.get_worldpath() .. "/items.list"

minetest.register_privilege("lists", {
	description = "Возможность выводить списки зарегестрированных блоков, инструментов и предметов в файлы",
})

--- Writes given definition table (minetest.registered_nodes/tools/craftitems) to given text file.
---@param filepath string
---@param defs NodeDefinition[]|table<string,table>
local function def2file(filepath, defs)
	local output = io.open(filepath, "w")
	if not output then error("[debugtools] can't open file: "..filepath) end
	local list = {}
	for name, def in pairs(defs) do
		if name == "air" then name = ":air" end
		if name == "ignore" then name = ":ignore" end
		local desc = minetest.get_translated_string("ru", def.description)
		local escaped_desc = string.replace(desc, "\n", " ")
		table.insert(list, string.format("%s\t%s", name, escaped_desc))
	end
	output:write(table.concat(list, "\n"))
	io.close(output)
end

minetest.register_chatcommand("lists", {
	description =
		"Вывести списки зарегестрированных блоков, инструментов и предметов в файлы nodes.list, tools.list, items.list",
	privs = {lists = true},
	func = function(name)
		local c = os.clock()
		def2file(nodes_file, minetest.registered_nodes)
		def2file(tools_file, minetest.registered_tools)
		def2file(items_file, minetest.registered_craftitems)
		return true, string.format("Успешно записано! Выполнение команды заняло: %f сек.", os.clock() - c)
	end
})
