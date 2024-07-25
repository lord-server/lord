
--- @class base_classes.Form.Mixin.WithTabs: base_classes.Form.Mixin
local WithTabs = {
	--- @static
	--- @protected
	--- @type table<string,number>
	tabs = {},
	--- @protected
	--- @type number
	tab  = 1,
}

---switch_tab
---@param self       base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
---@param tab_number number
function WithTabs.switch_tab(self, tab_number)
	self.tab = tab_number
	self:open()
end

--- @static
--- @param class base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
--- @param tabs  table <string, number>
function WithTabs.mix_to(class, tabs)
	table.overwrite(class, WithTabs)

	class.tabs = tabs

	--- @param self base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
	class.on_instance(function(self, _, _)
		self.tab = 1
	end)
	--- @param self   base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
	--- @param fields table|{tab:number}
	class.on_handle(function(self, _, fields)
		if fields.tab then
			self:switch_tab(tonumber(fields.tab))
		end
	end)
end


return WithTabs
