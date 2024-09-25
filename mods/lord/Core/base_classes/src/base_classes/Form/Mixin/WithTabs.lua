
--- @class base_classes.Form.Mixin.WithTabs: base_classes.Form.Mixin
local WithTabs = {
	--- @static
	--- @protected
	--- @type table<string,number>
	tab = {},
	--- @protected
	--- @type number
	current_tab  = 1,
}

--- @protected
--- @param tab_number number
function WithTabs:switch_tab(tab_number)
	print(__FILE_LINE__())
	print(dump(tab_number))
	self.current_tab = tab_number
	self:open()
end

--- @abstract
--- @protected
function WithTabs:get_tab_spec(tab_number)
	error('You should override method `:get_tab_spec` in your Form.')
end

--- @protected
--- @return string
function WithTabs:get_spec()
	local tabs_names = {}
	for name, number in pairs(self.tab) do
		tabs_names[#tabs_names+1] = name:lower():first_to_upper()
	end

	local formspec = 'size[8,9]' ..
		'tabheader[0,0;current_tab;' .. table.concat(tabs_names, ',') .. ';'.. self.current_tab ..']'
	formspec = formspec .. self:get_tab_spec(self.current_tab)

	return formspec
end

--- @static
--- @param class base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
--- @param tabs  table <string, number>
function WithTabs.mix_to(class, tabs)
	table.overwrite(class, WithTabs)

	class.tab = tabs

	--- @param self base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
	--- @param _    Player
	--- @param _    Position
	class.on_instance(function(self, _, _)
		self.current_tab = 1
	end)
	--- @param self   base_classes.Form.Base|base_classes.Form.Mixin.WithTabs
	--- @param _      Player
	--- @param fields table|{tab:number}
	class.on_handle(function(self, _, fields)
		if fields.current_tab then
			self:switch_tab(tonumber(fields.current_tab))
		end
	end)
end


return WithTabs
