local S    = minetest.get_mod_translator()
local spec = forms.Spec


--- @class lord_classes.form.ChooseSkin: base_classes.Form.Base
--- @field new  fun(self:self, player:Player, race:string, gender:string, opened_by:string)
--- @field open fun(self:self, skin_no:number)
local ChooseSkin = {
	--- @type string
	NAME      = 'change_skin',
	--- @private
	race      = nil,
	--- @private
	gender    = nil,
	--- @private
	--- @type string unique name of form-user choice, that indicates by which code the form was opened (for form-users)
	opened_by = nil,
}
ChooseSkin = base_classes.Form:personal():extended(ChooseSkin)

ChooseSkin.event.Type.on_switch = 'on_switch'
ChooseSkin.event.Type.on_apply  = 'on_apply'
ChooseSkin.event.Type.on_back = 'on_back'
ChooseSkin.event.subscribers[ChooseSkin.event.Type.on_switch] = {}
ChooseSkin.event.subscribers[ChooseSkin.event.Type.on_apply]  = {}
ChooseSkin.event.subscribers[ChooseSkin.event.Type.on_back] = {}

--- @type fun(callback:fun(form:lord_classes.form.ChooseRace, skin_no:number))
ChooseSkin.on_switch = ChooseSkin.event:on(ChooseSkin.event.Type.on_switch, ChooseSkin.event)
--- @type fun(callback:fun(form:lord_classes.form.ChooseRace, skin_no:number))
ChooseSkin.on_apply  = ChooseSkin.event:on(ChooseSkin.event.Type.on_apply, ChooseSkin.event)
--- @type fun(callback:fun(form:lord_classes.form.ChooseRace))
ChooseSkin.on_back = ChooseSkin.event:on(ChooseSkin.event.Type.on_back, ChooseSkin.event)


--- @protected
--- @param player    Player
--- @param race      string
--- @param gender    string
--- @param opened_by string
function ChooseSkin:instantiate(player, race, gender, opened_by)
	self.race      = race
	self.gender    = gender
	self.opened_by = opened_by
end

--- @protected
--- @param skin_no number
--- @return string
function ChooseSkin:get_spec(skin_no)
	local skins_list = table.generate_sequence(lord_skins.get_skins_count(self.race, self.gender))

	return spec.size(7, 4)
		.. spec.bold(0, 0, S('Choose a skin for your character'))
		.. spec.image(0, 0.5, 3.3, 3, lord_skins.get_preview_name('both', self.race, self.gender, skin_no))
		.. spec.dropdown_WH(3.6, 0.51, 3, 1, 'skin', skins_list, skin_no)
		.. spec.button_exit(0, 3.3, 3, 1, 'back', '« ' .. S('Back'))
		.. spec.button_exit(4, 3.3, 3, 1, 'ok', S('OK'))
end

--- @protected
--- @param fields table
function ChooseSkin:handle(fields)
	if fields.back then
		self.event:trigger(self.event.Type.on_back, self)
	elseif fields.ok then
		self.event:trigger(self.event.Type.on_apply, self, tonumber(fields.skin))
	elseif fields.skin then
		-- just redraw form to display new skin:
		self:open(tonumber(fields.skin))

		self.event:trigger(self.event.Type.on_switch, self, tonumber(fields.skin))
	end
end


return ChooseSkin:register()
