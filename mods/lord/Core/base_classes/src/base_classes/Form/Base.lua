local FormEvent = require('base_classes.Form.Event')


--- @class base_classes.Form.Base
--- @field on_register fun(form:self)
--- @field on_instance fun(form:self, player:Player, ...)
--- @field on_open     fun(form:self)
--- @field on_close    fun(form:self)
--- @field on_handle   fun(form:self, player:Player, fields:table)
local BaseForm  = {
	--- @const
	--- @type string
	NAME        = '',

	--- @protected
	--- @type base_classes.Form.Event
	event       = nil,

	--- @type string
	player_name = nil,
}

--- @param mixin base_classes.Form.Mixin
function BaseForm:mix(mixin, ...)
	self = setmetatable(self, { __index = table.overwrite(
		table.copy(getmetatable(self).__index),
		mixin
	)})
	mixin.mix_to(self, ...)
end

--- @public
--- @generic GenericForm: base_classes.Form.Base
--- @param child_class GenericForm
--- @return GenericForm
function BaseForm:extended(child_class)
	self = setmetatable(child_class or {}, { __index = self })

	self.event = FormEvent:extended()

	self.on_register = self.event:on(self.event.Type.on_register, self.event)
	self.on_instance = self.event:on(self.event.Type.on_instance, self.event)
	self.on_open     = self.event:on(self.event.Type.on_open, self.event)
	self.on_close    = self.event:on(self.event.Type.on_close, self.event)
	self.on_handle   = self.event:on(self.event.Type.on_handle, self.event)

	return self
end

--- Constructor
--- @public
--- @param player Player
--- @return base_classes.Form.Base
function BaseForm:new(player, ...)
	local class = self
	self = {}

	self.player_name = player:get_player_name()
	self = setmetatable(self, { __index = class })

	self.event:trigger(self.event.Type.on_instance, self, player, ...)
	self:instantiate(player, ...)

	return self
end

--- @protected
--- @param player Player
function BaseForm:instantiate(player, ...)
end

--- @public
--- @abstract
function BaseForm:get_spec()
	error('You need to override method `:get_spec()`')
end

--- @public
function BaseForm:open()
	self.event:trigger(self.event.Type.on_open, self)
	minetest.show_formspec(self.player_name, self.NAME, self:get_spec())
end

--- @public
function BaseForm:close()
	self.event:trigger(self.event.Type.on_close, self)
end

--- @protected
--- @param fields table
function BaseForm:handle(fields)
end

--- @protected
--- @param player    Player
--- @param form_name string
--- @param fields    table
function BaseForm:handler(player, form_name, fields)
	if form_name ~= self.NAME then
		return
	end

	self.event:trigger(self.event.Type.on_handle, self, player, fields)
	self:handle(fields)


	if fields.quit then
		self:close()
	end
end

--- @public
--- @return base_classes.Form.Base
function BaseForm:register()
	self.event:trigger(self.event.Type.on_register, self)

	minetest.register_on_player_receive_fields(function(player, form_name, fields)
		self:handler(player, form_name, fields)
	end)

	return self
end


return BaseForm
