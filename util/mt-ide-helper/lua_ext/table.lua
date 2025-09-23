--- @diagnostic disable: missing-return


--- Returns a deep copy of `table`
--- - strips metatables, but this may change in the future
---
--- @generic T: table
--- @param table T
---
--- @return T
function table.copy(table) end

--- Returns a deep copy of `table` with metatable copied.
--- - since `5.12`
--- - `table` can also be non-table value, which will be returned as-is
--- - preserves metatables as they are
--- @since 5.12
--- @generic T: table
--- @param table T
---
--- @return T
function table.copy_with_metatables(table) end

--- Returns the smallest numerical index containing the value `val` in the table list.
--- - Non-numerical indices are ignored.
--- - If `val` could not be found, `-1` is returned.
--- - `list` must not have negative indices.
---
--- @generic value
--- @param list value[]
--- @param val  value
---
--- @return integer
function table.indexof(list, val) end

--- Returns the key containing the value val in the table table.
--- - If multiple keys contain `val`, it is unspecified which key will be returned.
--- - If `val` could not be found, `nil` is returned.
---
--- @generic key, value
--- @param table table<key, value>
--- @param val   value
---
--- @return key?
function table.keyof(table, val) end

--- Appends all values in `other_table` to table - uses `#table + 1` to find new indices.
---
--- @generic value
--- @param table       table<number, value>
--- @param other_table table
---
--- @return table<number,value>
function table.insert_all(table, other_table) end


--- Returns a table with keys and values swapped
--- - If multiple keys in `t` map to the same value, it is unspecified which value maps to that key.
---
--- @generic key, value
--- @param t table<key, value>
---
--- @return table<value, key>
function table.key_value_swap(t) end

--- Shuffles elements `from` to `to` in `table` in place (modifies exectly `table`, use `table.copy()` if needed).
--- * `from` defaults to `1`
--- * `to` defaults to `#table`
--- * `random_func` defaults to `math.random`. This function receives two
---   integers as arguments and should return a random integer inclusively
---   between them.
---
--- @param table        table                                    list to shuffle in.
--- @param from?        integer                                  (default: `1`)
--- @param to?          integer                                  (default: `#table`)
--- @param random_func? fun(min: integer, max: integer): integer (default: `math.random`) should return a random integer inclusively between `from` & `to`.
function table.shuffle(table, from, to, random_func) end
