local setmetatable
    = setmetatable


--- @class base_classes.Form.Element.Tab
local Tab = {
	--- @type string
	title = nil,
	--- @type base_classes.Form.Base
	form  = nil,
	--- @abstract
	--- @public
	--- @type fun(self:base_classes.Form.Element.Tab):string
	get_spec = function(self)
		return error('You should override method `Tab:get_spec()` in your tab class.')
	end,
}

--- @public
--- @generic GenericDetachedInventory: base_classes.DetachedInventory
--- @param child_class GenericDetachedInventory
--- @return GenericDetachedInventory
function Tab:extended(child_class)
	return setmetatable(child_class or {}, { __index = self })
end

--- @public
--- @overload fun(form:base_classes.Form): base_classes.Form.Element.Tab
--- @param form     base_classes.Form
--- @param instance base_classes.Form.Element.Tab for quick instantiate [optional].
--- @return base_classes.Form.Element.Tab
function Tab:new(form, instance)
	local class = self

	self = instance or {}
	self.form = form

	return setmetatable(self, { __index = class })
end


return Tab
