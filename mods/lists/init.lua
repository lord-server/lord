local nodes_file = minetest.get_worldpath() .. "/nodes.list"
local tools_file = minetest.get_worldpath() .. "/tools.list"
local items_file = minetest.get_worldpath() .. "/items.list"

minetest.register_privilege("lists", {
	description = "Возможность выводить списки зарегестрированных блоков, инструментов и предметов в файлы",
})

minetest.register_chatcommand("lists", {
	description = "Вывести списки зарегестрированных блоков, инструментов и предметов в файлы nodes.list, tools.list, items.list",
	privs = {lists = true},
	func = function(name)
		local List = ""
		local output = io.open(nodes_file, "w")
		for n, d in pairs(minetest.registered_nodes) do
			if n == "air" then n = ":air" end
			if n == "ignore" then n = ":ignore" end
			List = List..n..":"..string.gsub(d.description, "\n", " ").."\n"
		end
		output:write(List)
		io.close(output)
		
		local List = ""
		local output = io.open(tools_file, "w")
		for n, d in pairs(minetest.registered_tools) do
			List = List..n..":"..string.gsub(d.description, "\n", " ").."\n"
		end
		output:write(List)
		io.close(output)
		
		local List = ""
		local output = io.open(items_file, "w")
		for n, d in pairs(minetest.registered_craftitems) do
			List = List..n..":"..string.gsub(d.description, "\n", " ").."\n"
		end
		output:write(List)
		io.close(output)
	end
})
