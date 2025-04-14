local S        = minetest.get_mod_translator()
local spec     = forms.Spec
local colorize = minetest.colorize


--- @class lord_classes.form.ChooseRace: base_classes.Form.Base
--- @field new
local ChooseRaceForm = {
	--- @type string
	NAME       = 'change_race',
	--- @static
	--- @private
	--- @type string[] list of available races to choose. Filled dynamically once on first `:get_spec()` call.
	races_list = nil,
	-- TODO: extract into gui.color.COMMAND #2150
	--- @type string
	commands_color = '#8ff',
	--- @private
	--- @type string unique name of form-user choice, that indicates by which code the form was opened (for form-users)
	opened_by = nil,
}
ChooseRaceForm = base_classes.Form:personal():extended(ChooseRaceForm)

ChooseRaceForm.event.Type.on_switch = 'on_switch'
ChooseRaceForm.event.Type.on_apply  = 'on_apply'
ChooseRaceForm.event.Type.on_cancel = 'on_cancel'
ChooseRaceForm.event.subscribers[ChooseRaceForm.event.Type.on_switch] = {}
ChooseRaceForm.event.subscribers[ChooseRaceForm.event.Type.on_apply]  = {}
ChooseRaceForm.event.subscribers[ChooseRaceForm.event.Type.on_cancel] = {}

--- @alias lord_classes.form.ChooseRace.callback fun(form:lord_classes.form.ChooseRace, race:string, gender:string)

--- @type fun(callback:lord_classes.form.ChooseRace.callback)
ChooseRaceForm.on_switch = ChooseRaceForm.event:on(ChooseRaceForm.event.Type.on_switch, ChooseRaceForm.event)
--- @type fun(callback:lord_classes.form.ChooseRace.callback)
ChooseRaceForm.on_apply  = ChooseRaceForm.event:on(ChooseRaceForm.event.Type.on_apply, ChooseRaceForm.event)
--- @type fun(callback:lord_classes.form.ChooseRace.callback)
ChooseRaceForm.on_cancel = ChooseRaceForm.event:on(ChooseRaceForm.event.Type.on_cancel, ChooseRaceForm.event)


--- @protected
--- @param player    Player
--- @param opened_by string
function ChooseRaceForm:instantiate(player, opened_by)
	self.opened_by = opened_by
end

--- @static
--- @private
--- @return string[]
function ChooseRaceForm.get_races_list()
	if not ChooseRaceForm.races_list then
		local list = {}
		for _, def in pairs(races.list) do
			if not def.cannot_be_selected then -- Exclude 'shadow'
				table.insert(list, def.name)
			end
		end

		ChooseRaceForm.races_list = list
	end

	return ChooseRaceForm.races_list
end

--- @param show_spawns_info boolean
--- @return string
function ChooseRaceForm:get_spec(show_spawns_info)
	-- TODO: extract into gui.colorize.cmd() #2150
	--- @param text string
	local function cmd(text)
		return colorize(self.commands_color, text)
	end

	--- @type string
	local form
	local races_list = ChooseRaceForm.get_races_list()

	form = spec.size(7.5, 4)
		.. spec.bold (0, 0.0, S('Please select the race you wish to be'))
		.. spec.label(0, 0.5, S('You will be able to change your race once during your gameplay.'))
		.. spec.label(0, 0.8, S('Use command @1 to do this.', cmd('/second_chance')))
		.. (show_spawns_info
			and spec.label(0, 1.3, S('While selecting a race, you will be instantly teleported to that race’s spawn!'))
			or ''
		)
		.. spec.dropdown_WH(0.25, 2.3, 3.25, 1.0, 'race', races_list, 1)
		.. spec.dropdown_WH(4.00, 2.3, 3.00, 1.0, 'gender', { S('Male'), S('Female') }, 1)
		.. spec.button_exit(0.25, 3.3, 3.25, 1.0, 'cancel', S('Cancel'))
		.. spec.button_exit(4.00, 3.3, 3.00, 1.0, 'ok', S('OK'))

	return form
end

--- @protected
--- @param fields table
function ChooseRaceForm:handle(fields)
	if (fields.race or fields.gender) and not fields.ok and not fields.quit and not fields.cancel then
		self.event:trigger(self.event.Type.on_switch, self, fields.race, fields.gender)

		return
	end

	if fields.ok then
		-- `OK` button pressed
		self.event:trigger(self.event.Type.on_apply, self, fields.race, fields.gender)
	else
		-- `Cancel` button pressed, or escape pressed, or click outside the form
		self.event:trigger(self.event.Type.on_cancel, self)
	end
end


return ChooseRaceForm:register()
