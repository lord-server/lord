local setmetatable, type, table_walk, tonumber, tostring
    = setmetatable, type, table.walk, tonumber, tostring

local FieldType = require('base_classes.Meta.FieldType')


--- @class base_classes.Meta.Base
local BaseMeta = {
	--- @protected
	--- @type MetaDataRef
	meta = nil,
	--- @protected
	--- @type table<string,string> key - name of field, value - field-type (one of base_classes.Meta.FieldType::<CONST>)
	field_type = nil,
}

--- @public
--- @param child_class GenericMeta
--- @generic GenericMeta: base_classes.Meta.Base
--- @return GenericMeta
function BaseMeta:extended(child_class)
	assert(type(child_class) == 'table')
	assert(child_class.field_type and type(child_class.field_type) == 'table')
	table.walk(child_class.field_type, function(value, key)
		assert(type(value) == 'string')
		assertf(value:is_one_of(FieldType), 'Unknown type `%s` for field `%s`', value, key)
	end)

	return setmetatable(child_class, { __index = self })
end

--- @public
--- @param position Position
--- @generic GenericMeta: base_classes.Meta.Base
--- @return GenericMeta
function BaseMeta:new(position)
	local class = self

	self = {}
	self.meta = minetest.get_meta(position)

	return setmetatable(self, {
		__index    = function(instance, field)
			local field_value = class[field]
			if field_value ~= nil then
				return field_value
			end

			return instance:get(field)
		end,
		__newindex = class.set,
	})
end

--- @public
--- @param key string
--- @return boolean
function BaseMeta:contains(key)
	return self.meta:contains(key)
end

BaseMeta.has = BaseMeta.contains

--- @protected
--- @param key     string
--- @param default any
--- @return nil|any
function BaseMeta:get_typified(key, default)
	local field_type = self.field_type[key]

	if field_type == FieldType.BOOLEAN then
		local value = self.meta:get(key) or default

		return value == nil	and nil	or minetest.is_yes(tonumber(value))
	elseif field_type == FieldType.INTEGER then
		return tonumber(self.meta:get(key) or default)
	elseif field_type == FieldType.STRING then
		return self.meta:get(key) or default
	elseif field_type == FieldType.TABLE then
		return minetest.parse_json(self.meta:get(key), default)
	else
		errorf('Something went wrong...')
	end
end

--- @public
--- @param field   string
--- @param default any
--- @return any
function BaseMeta:get(field, default)
	if not self.field_type[field] then
		errorlf('Undefined field: `%s`', 3, field or 'nil')
	end

	return self:get_typified(field, default)
end

--- @protected
--- @param key   string
--- @param value any
--- @generic GenericMeta: base_classes.Meta.Base
--- @return GenericMeta
function BaseMeta:set_typified(key, value)
	local field_type = self.field_type[key]
	if not field_type then
		errorlf('Undefined field: `%s`', 4, key or 'nil')
	end

	if field_type == FieldType.BOOLEAN then
		self.meta:set_int(key, minetest.is_yes(value) and 1 or 0)
	elseif field_type == FieldType.INTEGER then
		self.meta:set_int(key, tonumber(value))
	elseif field_type == FieldType.STRING then
		self.meta:set_string(key, tostring(value))
	elseif field_type == FieldType.TABLE then
		if type(value) ~= 'table' then
			errorlf('Type mismatch for meta-field `%s`: `table` expected, got `%s`', 3, key, type(value))
		end
		self.meta:set_string(key, minetest.write_json(value))
	else
		errorf('Something went wrong...')
	end

	return self
end

--- @param key_or_pairs string|table<string,any>
--- @param value        any
--- @generic GenericMeta: base_classes.Meta.Base
--- @return GenericMeta
function BaseMeta:set(key_or_pairs, value)
	if type(key_or_pairs) == 'table' then
		table_walk(key_or_pairs, function(val, key)
			self:set_typified(key, val)
		end)
	else
		self:set_typified(key_or_pairs, value)
	end

	return self
end


return BaseMeta
