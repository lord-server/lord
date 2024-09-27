
--- @class base_classes.Form.Mixin: base_classes.Form.Base
--- @field mix_to fun(base_class:base_classes.Form.Base, ...)

--- @namespace base_classes.Form.Mixin
return {
	Personal     = require('base_classes.Form.Mixin.Personal'),
	ForNode      = require('base_classes.Form.Mixin.ForNode'),
	WithDetached = require('base_classes.Form.Mixin.WithDetached'),
	WithTabs     = require('base_classes.Form.Mixin.WithTabs'),
}
