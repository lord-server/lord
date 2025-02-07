local FormEvent = require('base_classes.Form.Event')


--- @class base_classes.Form.Base
--- @field on_register fun(callback:base_classes.Form.callback.on_register)
--- @field on_instance fun(callback:base_classes.Form.callback.on_instance)
--- @field on_open     fun(callback:base_classes.Form.callback.on_open)
--- @field on_close    fun(callback:base_classes.Form.callback.on_close)
--- @field on_handle   fun(callback:base_classes.Form.callback.on_handle)
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

--- Constructor.
---
--- You can pass additional own params into this method.
--- This params will be passed to `on_instance` event subscribers and into `:instantiate()` implementation.
---
--- Do not override this method unless necessary. Instead override `:instantiate()`.
--- If you still need to override this method, you need to replicate its behavior and add your own logic.
---
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

--- Shorten for `minetest.get_player_by_name(self.player_name)`
--- @return Player
function BaseForm:player()
	return minetest.get_player_by_name(self.player_name)
end

--- Override this method instead constructor (`:new()`), if you want to add some logic on instance creating.
--- All additional params from constructor will be passed here.
--- @protected
--- @param player Player
function BaseForm:instantiate(player, ...)
end

--- You should override this method and implement and return form specification for your form.
--- @public
--- @abstract
function BaseForm:get_spec(...)
	error('You need to override method `:get_spec()`')
end

--- Opens the form for the player specified in the constructor (`:new()` method).
---
--- You can pass additional own params into this method.
--- This params will be passed to `on_open` event subscribers and into your `:get_spec()` implementation.
---
--- Example:
--- ```
--- minetest.register_tool('...:...', {
---     on_use = function(itemstack, player, pointed_thing)
---         MyForm:new(player):open(my_param)
--- ```
---
--- @public
function BaseForm:open(...)
	self.event:trigger(self.event.Type.on_open, self, ...)
	minetest.show_formspec(self.player_name, self.NAME, self:get_spec(...))
end

--- This function should be used when you override method `:handler()`,
--- and when user press `esc` or click outside the form.
---
--- Example:
--- ```lua
--- function MyForm:handler(player, form_name, fields)
---     if form_name ~= self.NAME then   return   end
---
---     self:trigger_handle(player, fields)
--- ```
---
--- When you want to close form forcibly, use the `:close()` method.
---
--- @protected
function BaseForm:trigger_handle(player, fields)
	self.event:trigger(self.event.Type.on_handle, self, player, fields)
end

--- This function should be used when you override method `:handler()`,
--- and when user press `esc` or click outside the form.
---
--- Example:
--- ```lua
--- function MyForm:handler(player, form_name, fields)
---     -- ...
---     if fields.quit then
---         self:trigger_close()
---     end
--- ```
---
--- When you want to close form forcibly, use the `:close()` method.
---
--- @protected
function BaseForm:trigger_close(...)
	self.event:trigger(self.event.Type.on_close, self, ...)
end

--- Triggers `on_close` event & call `minetest.close_formspec()`.
--- @public
function BaseForm:close(...)
	self.event:trigger(self.event.Type.on_close, self, ...)
	minetest.close_formspec(self.player_name, self.NAME)
end

--- Override this method to implement some form handling and your own logic.
---
--- @protected
--- @param fields table
--- @return nil|boolean return `true` for stop propagation of handling
function BaseForm:handle(fields)
	return
end

--- If you want just add some handling to your form, just override `:handle()` method.
---
--- If you still need to override this method, you need to replicate its behavior and add your own logic.
---
--- Exactly this method itself is registering as a form handler in the Luanti core.
---
--- @protected
--- @param player    Player
--- @param form_name string
--- @param fields    table
function BaseForm:handler(player, form_name, fields)
	if form_name ~= self.NAME then
		return
	end

	self:trigger_handle(player, fields)
	if self:handle(fields) then
		return
	end


	if fields.quit then
		self:trigger_close()
	end
end

--- You should to call this method after you declare your form class.
--- @public
--- @return base_classes.Form.Base
function BaseForm:register(...)
	self.event:trigger(self.event.Type.on_register, self, ...)

	minetest.register_on_player_receive_fields(function(player, form_name, fields)
		self:handler(player, form_name, fields)
	end)

	return self
end


return BaseForm
