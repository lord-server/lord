local S    = minetest.get_mod_translator()
local spec = forms.Spec


--- @class lord_classes.form.ChooseSkin: base_classes.Form.Base
--- @field open fun(race:string, gender:string, skin_no:number)
local ChooseSkin = {
	--- @type string
	NAME       = 'change_skin',
	--- @static
	--- @private
	--- @type string[] list of available races to choose. Filled dynamically once on first `:get_spec()` call.
	races_list = nil,
}
ChooseSkin = base_classes.Form:personal():extended(ChooseSkin)

--- @protected
--- @param race    string
--- @param gender  string
--- @param skin_no number
--- @return string
function ChooseSkin:get_spec(race, gender, skin_no)
	local skins_list = table.generate_sequence(lord_skins.get_skins_count(race, gender))

	return spec.size(7, 4)
		.. spec.bold(0, 0, S('Choose a skin for your character'))
		.. spec.image(0, 0.5, 3.3, 3, lord_skins.get_preview_name('both', race, gender, skin_no))
		.. spec.dropdown_WH(3.6, 0.51, 3, 1, 'skin', skins_list, skin_no)
		.. spec.button_exit(0, 3.3, 3, 1, 'back', S('Back'))
		.. spec.button_exit(4, 3.3, 3, 1, 'ok', S('OK'))
end

--- @protected
--- @param fields table
function ChooseSkin:handle(fields)
	local name   = self.player_name
	local player = self:player()

	if fields.back then
		minetest.after(0.1, races.show_change_form, player)
	elseif fields.ok then
		races.set_skin(name, tonumber(fields.skin))
		races.save()
	elseif fields.skin then
		local r = races.get_race_and_gender(name)
		minetest.after(0.1, races.show_skin_change_form, player, r[1], r[2], tonumber(fields.skin))
	end
end


return ChooseSkin:register()
