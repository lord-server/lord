local table_is_empty
	= table.is_empty

--- @param pos1 Position
--- @param pos2 Position
--- @param filename string
--- @param player_name string
local function save_schematic(pos1, pos2, filename, player_name)
	if minetest.create_schematic(pos1, pos2, worldedit.prob_list[player_name], filename) then
		minetest.chat_send_player(player_name, "Ландшафт записан в файл ".. filename)
	else
		minetest.chat_send_player(player_name, "Ошибка записи ландшафта") return
	end
end

-- Можно это заменить на использование `VoxelArea:iterp()`, но работает и так быстро
--- @param pos1 Position
--- @param pos2 Position
--- @param callback fun(x:number,y:number,z:number)
local function iterate_cube(pos1, pos2, callback)
	for x = pos1.x, pos2.x do
		for y = pos1.y, pos2.y do
			for z = pos1.z, pos2.z do
				callback(x, y, z)
			end
		end
	end
end

--- @param pos1 Position
--- @param pos2 Position
--- @param filename string
--- @param player_name string
local function save_meta_data(pos1, pos2, filename, player_name)
	local data = {}
	iterate_cube(pos1, pos2, function(x, y, z)
		local pos = {x=x, y=y, z=z}
		local node = minetest.get_node(pos)
		if node.name == "air" or node.name == "ignore" then
			return
		end

		local meta = minetest.get_meta(pos):to_table()
		-- Convert metadata item stacks to item strings
		for _, inventory in pairs(meta.inventory) do
			for index, stack in ipairs(inventory) do
				inventory[index] = stack.to_string and stack:to_string() or stack
			end
		end
		if
			not table_is_empty(meta.fields) or
			not table_is_empty(meta.inventory)
		then
			table.insert(data, {
				pos = minetest.pos_to_string({x = x-pos1.x, y = y-pos1.y, z = z-pos1.z}),
				fields = meta.fields,
				inventory = meta.inventory,
			})
		end
	end)
	data = minetest.serialize(data)

	io.write_to_file(filename, data, "wb")

	minetest.chat_send_player(player_name, "META-данные записаны в файл ".. filename)
end

---------------------------------------------------------------------------------------------
--- Chat Commands
---------------------------------------------------------------------------------------------
minetest.register_chatcommand ("S", {
	description = "Сохранить данные в файл",
	params = "<file_name>",
	privs = {worldedit = true},
	--- @param player_name string
	--- @param param string
	--- @return boolean,string
	func = function(player_name, param)
		if (param == nil)or(param == "") then minetest.chat_send_player(player_name, "Не задано имя файла") return end

		local path = minetest.get_worldpath() .. "/schems"
		local file_mts = path .. "/" .. param .. ".mts"
		local file_meta = path .. "/" .. param .. ".meta"
		minetest.mkdir(path)

		local pos1, pos2 = worldedit.pos1[player_name], worldedit.pos2[player_name]
		if pos1 == nil then minetest.chat_send_player(player_name, "Не задана первая координата") return
		elseif pos2 == nil then minetest.chat_send_player(player_name, "Не задана вторая координата") return
		else pos1, pos2 = worldedit.sort_pos(pos1, pos2)
		end

		save_schematic(pos1, pos2, file_mts, player_name)

		save_meta_data(pos1, pos2, file_meta, player_name)
	end,
})

minetest.register_chatcommand ("L", {
	description = "Загрузить данные из файла",
	params = "<file_name>",
	privs = {worldedit = true},
	func = function(name, param)
		if (param == nil)or(param == "") then minetest.chat_send_player(name, "Не задано имя файла") return end

		local path = minetest.get_worldpath() .. "/schems"
		local file_mts = path .. "/" .. param .. ".mts"
		local file_meta = path .. "/" .. param .. ".meta"

		local pos1 = worldedit.pos1[name]
		if pos1 == nil then minetest.chat_send_player(name, "Не задана первая координата") return end

		if minetest.place_schematic(pos1, file_mts) then
			minetest.chat_send_player(name, "Ландшафт загружен из файла "..file_mts)
		else
			minetest.chat_send_player(name, "Ошибка загрузки ландшафта") return
		end

		local data = io.read_from_file(file_meta, "r")
		local meta_table = minetest.deserialize(data)
		for i, m in ipairs(meta_table) do
			local posl = minetest.string_to_pos(m.pos)
			local pos = {x=pos1.x+posl.x, y=pos1.y+posl.y, z=pos1.z+posl.z}
			local meta = minetest.get_meta(pos)
			meta:from_table({inventory = m.inventory, fields = m.fields})
		end

		minetest.chat_send_player(name, "META-данные загружены из файла "..file_meta)
	end,
})
