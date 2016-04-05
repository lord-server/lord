minetest.register_chatcommand ("S", {
	description = "Сохранитьданные в файл",
	params = "<file_name>",
	privs = {worldedit = true},
	func = function(name, param)
		if (param == nil)or(param == "") then minetest.chat_send_player(name, "Не задано имя файла") return end

		local path = minetest.get_worldpath() .. "/schems"
		local file_mts = path .. "/" .. param .. ".mts"
		local file_meta = path .. "/" .. param .. ".meta"
		os.execute('mkdir "' .. path .. '"')

		local pos1, pos2 = worldedit.pos1[name], worldedit.pos2[name]
		if pos1 == nil then minetest.chat_send_player(name, "Не задана первая координата") return
		elseif pos2 == nil then minetest.chat_send_player(name, "Не задана вторая координата") return
		else pos1, pos2 = worldedit.sort_pos(pos1, pos2)
		end

		if minetest.create_schematic(pos1, pos2, worldedit.prob_list[name], file_mts) then
			minetest.chat_send_player(name, "Ландшафт записан в файл "..file_mts)
		else
			minetest.chat_send_player(name, "Ошибка записи ландшафта") return
		end

		local data = {}
		for x = pos1.x, pos2.x do
			for y = pos1.y, pos2.y do
				for z = pos1.z, pos2.z do
					local pos = {x=x, y=y, z=z}
					local node = minetest.get_node(pos)
					if node.name ~= "air" and node.name ~= "ignore" then
						local meta = minetest.get_meta(pos):to_table()
						local meta_empty = true
						-- Convert metadata item stacks to item strings
						for name, inventory in pairs(meta.inventory) do
							for index, stack in ipairs(inventory) do
								meta_empty = false
								inventory[index] = stack.to_string and stack:to_string() or stack
							end
						end
						for k in pairs(meta) do
							if k ~= "inventory" then
								meta_empty = false
								break
							end
						end
						local N = 0
						for i,j in pairs(meta.fields) do N=N+1 break end
						for i,j in pairs(meta.inventory) do N=N+1 break end
						if N > 0 then
							table.insert(data, {
								pos = minetest.pos_to_string({x = x-pos1.x, y = y-pos1.y, z = z-pos1.z}),
								fields = meta.fields,
								inventory = meta.inventory,
							})
						end
					end
				end
			end
		end
		data = minetest.serialize(data)

		local file = io.open(file_meta, "wb")
		file:write(data)
		file:flush()
		file:close()

		minetest.chat_send_player(name, "META-данные записаны в файл "..file_meta)
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

		local file = io.open(file_meta, "r")
		local data = file:read("*a")
		file:close()
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
