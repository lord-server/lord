local table_copy, table_key_value_swap, pairs, next, type
	= table.copy, table.key_value_swap, pairs, next, type


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

-- TODO: see https://github.com/minetest/minetest/issues/14906 discussion result
-- --- @param table table
-- --- @param value any
-- --- @return boolean
--function table.contains(table, value)
--	return table_indexOf(table, value) ~= -1
--end

--- @param table table
--- @param value any
--- @return boolean
function table.contains(table, value)
	for _, v in pairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

table.has_value = table.contains

local table_has_value
	= table.has_value

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

local table_has_key
    = table.has_key

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
local table_merge
    = table.merge

--- @param table1 table
--- @param table2 table
--- @return table
function table.overwrite(table1, table2)
	return table_merge(table1, table2, true)
end


--- Adds key-value from `table2` into `table1` only if that key does not exists in `table1`.
--- Values that are tables are copied by `table.copy()`
---
--- @overload fun(table1:table, table2:table):table
---
--- @generic T: table
--- @param table1      table|T
--- @param table2      table
--- @param recursively boolean Default: false. Go recursively if both values are tables.
---
--- @return table|T
function table.join(table1, table2, recursively)
	recursively = recursively or false
	for key, value in pairs(table2) do
		if not table1[key] then
			table1[key] = type(value) == 'table' and table_copy(value) or value
		else
			if recursively and type(table1[key]) == 'table' and type(value) == 'table' then
				table.join(table1[key], value, recursively)
			end
		end
	end

	return table1
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

	return table_key_value_swap(merged_table)
end

--- @param table table
--- @return boolean
function table.is_empty(table)
	return next(table) == nil
end

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

--- @param table1 table
--- @param table2 table
--- @param recursively boolean
function table.equals(table1, table2, recursively)
	for key, value in pairs(table1) do
		if type(value) == "table" then
			if not table2[key] or type(table2[key]) ~= "table" then
				return false
			end
			if not table.equals(value, table2[key]) then
				return false
			end
		else
			if not table2[key] or table2[key] ~= value then
				return false
			end
		end
	end

	return true
end

--- Multiplies every value of `table` by a corresponding value
--- with the same key in `multiplier_table`.
--- Doesn't support the preservation of metatables.
--- @param table            table
--- @param multiplier_table table
--- @return table
function table.multiply_each_value(table, multiplier_table)
	local result = {}
	for key, value in pairs(table) do
		if multiplier_table[key] then
			result[key] = value * multiplier_table[key]
		else
			result[key] = value
		end
	end

	return result
end

---	Runs the input function for each table entry with the entry value as the argument.
--- Whatever the input function returns will be set instead of the value.
--- Non-recurcive, doesn't modify the input table.
--- @param t     table
--- @param func  function
--- @return table
function table.apply_function_to_every_value(t, func)
	local result = table.copy(t)
	for k, v in pairs(t) do
		result[k] = func(v)
	end
	return result
end
