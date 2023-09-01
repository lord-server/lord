local table_indexOf, table_copy, pairs, next
	= table.indexof, table.copy, pairs, next


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

--- @overload fun(table1:table, table2:table):table
--- @param table1 table
--- @param table2 table
--- @param overwrite boolean whether to overwrite the `table1` (default: false)
--- @return table
function table.merge(table1, table2, overwrite)
	overwrite = overwrite or false
	local merged_table = overwrite and table1 or table_copy(table1)
	for key, value in pairs(table2) do
		merged_table[key] = value
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
