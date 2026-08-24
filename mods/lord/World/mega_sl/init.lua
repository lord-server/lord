local table_is_empty, pairs, ipairs
    = table.is_empty, pairs, ipairs

-- no use `.get_mod_translator()`, we do not want to have extra dependencies
-- maybe it will be a separate mod in the future
local S = core.get_translator('mega_sl')


--- @param pos1 Position
--- @param pos2 Position
--- @param filename string
--- @param player_name string
local function save_schematic(pos1, pos2, filename, player_name)
	if core.create_schematic(pos1, pos2, worldedit.prob_list[player_name], filename) then
		core.chat_send_player(player_name, S('The landscape is written to file ') .. filename)
	else
		core.chat_send_player(player_name, S('Landscape writting error')) return
	end
end

-- It can be replaced with `VoxelArea:iterp()`, but it works fast enough
--- @param pos1 Position
--- @param pos2 Position
--- @param callback fun(x:integer,y:integer,z:integer)
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
		local node = core.get_node(pos)
		if node.name == 'air' or node.name == 'ignore' then
			return
		end

		local meta = core.get_meta(pos):to_table() --[[@as table]]
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
				pos = core.pos_to_string({x = x-pos1.x, y = y-pos1.y, z = z-pos1.z}),
				fields = meta.fields,
				inventory = meta.inventory,
			})
		end
	end)

	io.write_to_file(filename, core.serialize(data), 'wb')

	core.chat_send_player(player_name, S('META-data is written to file ') .. filename)
end

---------------------------------------------------------------------------------------------
--- Chat Commands
---------------------------------------------------------------------------------------------
core.register_chatcommand ('S', {
	description = S('Save data to file'),
	params = '<file_name>',
	privs = {worldedit = true},
	--- @param player_name string
	--- @param param string
	--- @return boolean,string
	func = function(player_name, param)
		if param == nil or param == '' then
			return false, S('File name not specified')
		end

		local path = core.get_worldpath() .. '/schems'
		local file_mts = path .. '/' .. param .. '.mts'
		local file_meta = path .. '/' .. param .. '.meta'
		core.mkdir(path)

		local pos1, pos2 = worldedit.pos1[player_name]--[[@as Position?]], worldedit.pos2[player_name]--[[@as Position?]]
		if pos1 == nil then
			return false, S('Pos1 not specified')
		elseif pos2 == nil then
			return false, S('Pos2 not specified')
		else
			pos1, pos2 = --[[@as Position,Position]]worldedit.sort_pos(pos1, pos2)
		end

		save_schematic(pos1, pos2, file_mts, player_name)

		save_meta_data(pos1, pos2, file_meta, player_name)
	end,
})

core.register_chatcommand ('L', {
	description = S('Load data from file'),
	params = '<file_name>',
	privs = {worldedit = true},
	func = function(name, param)
		if param == nil or param == '' then
			return false, S('File name not specified')
		end

		local path = core.get_worldpath() .. '/schems'
		local file_mts = path .. '/' .. param .. '.mts'
		local file_meta = path .. '/' .. param .. '.meta'

		local pos1 = worldedit.pos1[name]
		if pos1 == nil then
			return false, S('Pos1 not specified')
		end

		if core.place_schematic(pos1, file_mts) then
			core.chat_send_player(name, S('Landscape loaded from file ') .. file_mts)
		else
			return false, S('Landscape loading error')
		end

		local data = io.read_from_file(file_meta, 'r')
		local meta_table = core.deserialize(data)
		for i, m in ipairs(meta_table) do
			local posl = core.string_to_pos(m.pos)
			local pos = {x=pos1.x+posl.x, y=pos1.y+posl.y, z=pos1.z+posl.z}
			local meta = core.get_meta(pos)
			meta:from_table({inventory = m.inventory, fields = m.fields})
		end

		core.chat_send_player(name, S('META-data loaded from file ') .. file_meta)
	end,
})
