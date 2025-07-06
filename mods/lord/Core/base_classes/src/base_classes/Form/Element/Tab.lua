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
	--- @abstract
	--- @protected
	--- @type fun(self:base_classes.Form.Element.Tab,fields:table):nil|boolean
	handle = nil,
}

--- @public
--- @generic GenericTab: base_classes.Form.Element.Tab
--- @param child_class GenericTab
--- @return GenericTab
function Tab:extended(child_class)
	return setmetatable(child_class or {}, { __index = self })
end

--- @public
--- Don't override this method, use `:instantiate()` instead.
--- @overload fun(form:base_classes.Form): base_classes.Form.Element.Tab
--- @param form     base_classes.Form
--- @param instance base_classes.Form.Element.Tab for quick instantiate [optional].
--- @return base_classes.Form.Element.Tab
function Tab:new(form, instance, ...)
	local class = self

	self = instance or {}
	self.form = form

	self = setmetatable(self, { __index = class })
	self:instantiate(...)

	return self
end

--- Override this method instead constructor (`:new()`), if you want to add some logic on instance creating.
--- All additional params from constructor will be passed here.
--- Neither `form` nor `instance` will not be passed, as it assign to `self.form` & `self` respectively.
--- @protected
--- @param form base_classes.Form.Base
function Tab:instantiate(...)
end


return Tab
