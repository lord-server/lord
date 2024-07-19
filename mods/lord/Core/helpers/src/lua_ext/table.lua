local table_indexOf, table_copy, pairs, next
	= table.indexof, table.copy, pairs, next


--- @param table table
--- @return string[]|any[] returns list of all keys of specified table
function table.keys(table)
	local keys = {}
	for key, _ in pairs(table) do
		keys[#keys+1] = key
	end

	return keys
end

--- @param table table
--- @param value any
--- @return table|nil returns indexed table of found keys for table `table` or `nil` if nothing found
function table.keys_of(table, value)
	local found_keys = {}
	for key, v in pairs(table) do
		if v == value then
			found_keys[#found_keys+1] = key
		end
	end

	return #found_keys ~= 0 and found_keys or nil
end

--- @param table table
--- @param value any
--- @return boolean
function table.contains(table, value)
	return table_indexOf(table, value) ~= -1
end

table.has_value = table.contains

--- @param table    table
--- @param find_key string
function table.has_key(table, find_key)
	for key, _ in pairs(table) do
		if key == find_key then
			return true
		end
	end
	return false
end

local table_has_key = table.has_key

--- Copies `self` table and remove specified `keys`
--- @param table table
--- @param keys  table|string[]|any[]
--- @return table|string[]|any[]
function table.except(table, keys)
	local result = table_copy(table)
	for _, key in pairs(keys) do
		if table_has_key(result, key) then
			result[key] = nil
		end
	end

	return result
end

--- @overload fun(table1:table, table2:table):table
--- @param table1 table
--- @param table2 table
--- @param overwrite boolean whether to overwrite the `table1` (default: false)
--- @return table
function table.merge(table1, table2, overwrite)
	overwrite = overwrite or false
	local merged_table = overwrite and table1 or table_copy(table1)
	for key, value in pairs(table2) do
		if type(value) == "table" and type(merged_table[key]) == "table" then
			merged_table[key] = table.merge(merged_table[key], value, overwrite)
		else
			merged_table[key] = value
		end
	end
	return merged_table
end
local table_merge = table.merge

--- @param table1 table
--- @param table2 table
function table.overwrite(table1, table2)
	return table_merge(table1, table2, true)
end

--- @param table1 table
--- @param table2 table
--- @return table
function table.merge_values(table1, table2)
	local merged_table = {}
	local merged_index = 1

	for _, value in pairs(table1) do
		merged_table[value] = merged_index
		merged_index = merged_index + 1
	end

	for _, value in pairs(table2) do
		if merged_table[value] == nil then
			merged_table[value] = merged_index
			merged_index = merged_index + 1
		end
	end

	return table.key_value_swap(merged_table)
end


--- @param table table
--- @return boolean
function table.is_empty(table)
	return next(table) == nil
end


local table_has_value
	= table.has_value

--- @param table table
--- @param values table
function table.keys_has_one_of_values(table, values)
	for key in pairs(table) do
		if table_has_value(values, key) then
			return true
		end
	end
	return false
end

--- Checks whether all `table` elements are equal to the specified `value`
--- @param table table
--- @param value any
--- @return boolean
function table.each_value_equals(table, value)
	value = value or true
	for _, v in pairs(table) do
		if v ~= value then
			return false
		end
	end

	return true
end
