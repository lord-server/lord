--- Node metadata: reference extra data and functionality stored in a node.
--- Can be obtained via `minetest.get_meta(pos)`.
---
--- @class NodeMetaRef: MetaDataRef
NodeMetaRef = {}

--- @return InvRef
function NodeMetaRef:get_inventory() end

--- Mark specific vars as private.
---  This will prevent them from being sent to the client. Note that the "private"
---  status will only be remembered if an associated key-value pair exists,
---  meaning it's best to call this when initializing all other meta (e.g.
---  `on_construct`).
--- @param name string|table name or {name1, name2, ...}
function NodeMetaRef:mark_as_private(name) end
