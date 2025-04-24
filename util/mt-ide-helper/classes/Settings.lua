--- An interface to read config files in the format of `minetest.conf`.
---
--- `minetest.settings` is a `Settings` instance that can be used to access the
--- main config file (`minetest.conf`). Instances for other config files can be
--- created via `Settings(filename)`.
---
--- Engine settings on the `minetest.settings` object have internal defaults that
--- will be returned if a setting is unset.
--- The engine does *not* (yet) read `settingtypes.txt` for this purpose. This
--- means that no defaults will be returned for mod settings.
---
--- ### Format
---
--- The settings have the format `key = value`. Example:
--- ```
---     foo = example text
---     bar = """
---     Multiline
---     value
---     """
--- ```
--- @class Settings
Settings = {}

--- Returns a value of setting `key`
--- Returns `nil` if `key` is not found.
--- @param key string
--- @return string|nil
function Settings:get(key) end
--- returns a boolean
--- * `default` is the value returned if `key` is not found.
--- * Returns `nil` if `key` is not found and `default` not specified.
--- @overload fun(key:string):boolean|nil
--- @param key string
--- @return boolean|nil
function Settings:get_bool(key, default) end
--- returns a NoiseParams table
--- @param key string
function Settings:get_np_group(key) end
--- * Returns `{flag = true/false, ...}` according to the set flags.
--- * Is currently limited to mapgen flags `mg_flags` and mapgen-specific flags like `mgv5_spflags`.
--- @param key string
function Settings:get_flags(key) end
--- * Setting names can't contain whitespace or any of `="{}#`.
--- * Setting values can't contain the sequence `\n"""`.
--- * Setting names starting with "secure." can't be set on the main settings object (`minetest.settings`).
--- @param key string
--- @param value string
function Settings:set(key, value) end
--- * See documentation for set() above.
--- @param key string
--- @param value boolean
function Settings:set_bool(key, value) end
--- * `value` is a NoiseParams table.
--- * Also, see documentation for set() above.
--- @param key string
--- @param value table
function Settings:set_np_group(key, value) end
--- Returns a boolean (`true` for success)
--- @param key string
--- @return boolean
function Settings:remove(key) end
--- returns `{key1,...}`
--- @return table
function Settings:get_names() end

--- * Returns a boolean indicating whether `key` exists.
--- * In contrast to the various getter functions, `has()` doesn't consider any default values.
--- * This means that on the main settings object (`minetest.settings`), `get(key)` might return a value even if `has(key)` returns `false`.
--- @param key string
--- @return boolean
function Settings:has(key) end
--- returns a boolean (`true` for success)
--- * Writes changes to file.
--- @return boolean
function Settings:write() end
--- returns `{[key1]=value1,...}`
--- @return table<string,string>
function Settings:to_table() end
