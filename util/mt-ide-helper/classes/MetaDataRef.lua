--- Base class used by [`StorageRef`], [`NodeMetaRef`], [`ItemStackMetaRef`],
--- and [`PlayerMetaRef`].
---
--- Note: If a metadata value is in the format `${k}`, an attempt to get the value
--- will return the value associated with key `k`. There is a low recursion limit.
--- This behavior is **deprecated** and will be removed in a future version. Usage
--- of the `${k}` syntax in formspecs is not deprecated.
---
--- @class MetaDataRef
MetaDataRef = {}

---@param key string
---@return boolean|nil
function MetaDataRef:contains(key) end

---@param key string
---@return string|nil
function MetaDataRef:get(key) end

---@param key string
---@param value string value "" will delete the key
---@return number
function MetaDataRef:set_string(key, value) end

---@param key string
---@return number
function MetaDataRef:get_string(key) end

---@param key string
---@param value number
---@return number
function MetaDataRef:set_int(key, value) end

---@param key string
---@return number Returns `0` if `key` not present.
function MetaDataRef:get_int(key) end

---@param key string
---@param value number
---@return number
function MetaDataRef:set_float(key, value) end

---@param key string
---@return number
function MetaDataRef:get_float(key) end

--- Returns a list of all keys in the metadata.
--- @return table
function MetaDataRef:get_keys() end

--- returns `nil` or a table with keys:
---   * `fields`: key-value storage
---   * `inventory`: `{list1 = {}, ...}}` (NodeMetaRef only)
--- @return table|nil
function MetaDataRef:to_table() end

---   * Any non-table value will clear the metadata
---   * See [Node Metadata] for an example
---   * returns `true` on success
--- @param value table|nil
--- @return boolean
function MetaDataRef:from_table(value) end

--- * returns `true` if this metadata has the same key-value pairs as `other`
--- @param other
--- @return boolean
function MetaDataRef:equals(other) end
