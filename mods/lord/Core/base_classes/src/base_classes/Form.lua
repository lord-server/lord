--local ForNode  = require("base_classes.Form.ForNode")
--local Personal = require("base_classes.Form.Personal")
--local Shared   = require("base_classes.Form.Shared")
--local WithTabs = require("base_classes.Form.WithTabs")
local BaseForm = require('base_classes.Form.Base')

--- Form Class Factory class.
--- This class constructs for you a base form class.
--- Use methods to mix functionality you need and then call `:extended()` method.
---
--- @class base_classes.Form
--- @field base      fun(self:self): self
--- @field for_node  fun(self:self): self
--- @field with_tabs fun(self:self): self
local Form = {
	--- @generic GenericForm: base_classes.Form.Base
	--- @type GenericForm
	now_constructing = nil,

	--- @param self
	__index = function(self, mixin)
		return function(message, ...)
			-- self.now_constructing = BaseForm:extended(self.now_constructing)

			return self[mixin]
		end
	end
}

--- @static
--- @generic GenericForm: base_classes.Form.Base
--- @param child_class GenericForm
---
--- @return GenericForm
function Form:extended(child_class)
	--- @generic GenericForm: base_classes.Form.Base
	--- @type GenericForm
	local class       = child_class or {}
	local constructed = self.now_constructing or BaseForm

	self.now_constructing = nil

	return setmetatable(class, { __index = constructed } )
end


return Form
