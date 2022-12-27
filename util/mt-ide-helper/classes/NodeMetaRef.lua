---@class NodeMetaRef
NodeMetaRef = {}

---@param key string
---@return boolean|nil
function NodeMetaRef:contains(key) end

---@param key string
---@return string|nil
function NodeMetaRef:get(key) end

---@param key string
---@param value string
---@return number
function NodeMetaRef:set_string(key, value) end

---@param key string
---@return number
function NodeMetaRef:get_string(key) end

---@param key string
---@param value number
---@return number
function NodeMetaRef:set_int(key, value) end

---@param key string
---@return number
function NodeMetaRef:get_int(key) end

---@param key string
---@param value number
---@return number
function NodeMetaRef:set_float(key, value) end

---@param key string
---@return number
function NodeMetaRef:get_float(key) end

---@return table|nil
function NodeMetaRef:to_table() end

---@param value table|nil
---@return boolean
function NodeMetaRef:from_table(value) end

---@param other NodeMetaRef
---@return boolean
function NodeMetaRef:equals(other) end
