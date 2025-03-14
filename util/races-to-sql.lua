#!/usr/bin/env lua
-- This script is created to convert old races.txt file into SQL file
-- for import into minetest database
--
-- How to generate SQL file:
--
-- util/races-to-sql.lua races.txt --sqlite > races.sql  # for SQLite
-- util/races-to-sql.lua races.txt > races.sql           # for PostgreSQL
--
-- Generated SQL file adds records into table 'player_metadata'
-- If minetest uses sqlite database, it can be imported by
--
-- sqlite3 players.sqlite < races.sql
--
-- In case of other database read the documentation to database.


local input_filename = arg[1]
local db_type        = (arg[2] and arg[2] == '--sqlite') and 'sqlite' or 'postgre'
if not input_filename then
	io.stderr:write('error: input file not specified.\n')
	return
end

local key_field_name = (db_type == 'sqlite') and 'metadata' or 'attr'
local batch_size     = 1000;

--- @param filename string
--- @return table|nil
local function read_races(filename)
	local file, error_message, error_code = io.open(filename)
	if not file then
		io.stderr:write(
			'error: can\'t open file `' .. filename .. ': error[' .. error_code .. ']`: ' .. error_message .. '.\n'
		)

		return nil
	end
	file:close()

	return dofile(filename)
end

--- @param s string
--- @return string
local function escape_str(s)
	return '\'' .. s:gsub('\'', '\'\'') .. '\''
end

--- @param player_name string
--- @param attribute string attribute name
--- @param value any
local function values_string(player_name, attribute, value)
	return '(' .. escape_str(player_name) .. ', ' .. escape_str(attribute) .. ', ' .. escape_str(tostring(value)) .. ')'
end

--- @param values_strings string[]
local function bulk_upsert_stmt(values_strings)
	return
		'	WITH temp_player_metadata (player, ' .. key_field_name .. ', value) AS (\n' ..
		'		VALUES\n' ..
		'			' .. table.concat(values_strings, ',\n			') .. '\n' ..
		'	)\n' ..
		'	INSERT INTO player_metadata (player, ' .. key_field_name .. ', value)\n' ..
		'	SELECT tmp.player, tmp.' .. key_field_name .. ', tmp.value\n' ..
		'	FROM temp_player_metadata AS tmp\n' ..
		'	WHERE EXISTS (\n' ..
		'		SELECT 1 FROM player WHERE player.name = tmp.player\n' ..
		'	)\n' ..
		'	ON CONFLICT (player, ' .. key_field_name .. ')\n' ..
		'	DO UPDATE SET\n' ..
		'		value = EXCLUDED.value;'
end

--- @param callback fun()
local function transaction(callback)
	print('BEGIN TRANSACTION;')
	callback()
	print('COMMIT;')
end

local function echo(message)
	io.stderr:write(message .. '\n')
end

--- @param items table
--- @param get_values fun(player_name:string,item:any)
local function batched_transaction_for(items, get_values)
	transaction(function()
		local batch_i      = 0
		local batch_values = {}

		for player_name, item in pairs(items) do
			batch_values[#batch_values + 1] = values_string(get_values(player_name, item))
			batch_i                         = batch_i + 1
			if batch_i == batch_size then
				print(bulk_upsert_stmt(batch_values))
				batch_i      = 0
				batch_values = {}
			end
		end
		if batch_i ~= 0 then
			print(bulk_upsert_stmt(batch_values))
		end
	end)
end

--- @param privs table
local function serialize_privileges(privs)
	local val = 'return {'
	for priv_name, priv_value in pairs(privs) do
		if priv_value then
			val = val .. '"' .. tostring(priv_name) .. '",'
		end
	end
	val = val .. '}'
	return val
end

function generate_sql(races)
	local revoked_privs = races['revoked_privs']
	local granted_privs = races['granted_privs']
	local can_change    = races['can_change']
	local skins         = races['skins']
	local players       = races['players']

	-- TODO: research whether the privs storing is needed
	--batched_transaction_for(revoked_privs, function(player_name, privs)
	--	return player_name, 'character:revoked_privs', serialize_privileges(privs)
	--end)
	--
	--batched_transaction_for(granted_privs, function(player_name, privs)
	--	return player_name, 'character:granted_privs', serialize_privileges(privs)
	--end)

	batched_transaction_for(can_change, function(player_name, change)
		return player_name, 'character:has_second_chance', change
	end)

	batched_transaction_for(skins, function(player_name, skin)
		return player_name, 'character:skin', skin
	end)

	batched_transaction_for(players, function(player_name, player)
		local race = player[1]
		return player_name, 'character:race', race
	end)
	batched_transaction_for(players, function(player_name, player)
		local gender = player[2]
		return player_name, 'character:gender', gender
	end)
end

local races = read_races(input_filename)
generate_sql(races)
