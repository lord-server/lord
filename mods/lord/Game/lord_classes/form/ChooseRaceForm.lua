local S    = minetest.get_mod_translator()
local spec = minetest.formspec


--- @class lord_classes.form.ChooseRace: base_classes.Form.Base
local ChooseRaceForm = {
	--- @type string
	NAME       = 'change_race',
	--- @static
	--- @private
	--- @type string[] list of available races to choose. Filled dynamically once on first `:get_spec()` call.
	races_list = nil,
}
ChooseRaceForm = base_classes.Form:personal():extended(ChooseRaceForm)

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

--- @return string
function ChooseRaceForm:get_spec()
	--- @type string
	local form
	local races_list = ChooseRaceForm.get_races_list()

	form = spec.size(7, 4)
		.. spec.label(0, 0, S('Please select the race you wish to be:'))
		.. spec.dropdown_WH(0.0, 2.3, 3.0, 1.0, 'race', races_list, 1)
		.. spec.dropdown_WH(4.0, 2.3, 3.0, 1.0, 'gender', { S('Male'), S('Female') }, 1)
		.. spec.button_exit(4.0, 3.3, 3.0, 1.0, 'ok', S('OK'))
		.. spec.button_exit(0.0, 3.3, 3.0, 1.0, 'cancel', S('Cancel'))

	if minetest.settings:get_bool('dynamic_spawn') then
		form = form
			.. spec.label(0, 0.5, minetest.colorize('#ff033e',
				S('(Warning: choosing the race will teleport \n' .. 'you at the race spawn!)')
			))
	end

	return form
end

--- @protected
--- @param fields table
function ChooseRaceForm:handle(fields)
	local name   = self.player_name
	local player = self:player()

	if fields.race and not fields.ok and not fields.quit and not fields.cancel then
		local r = races.to_internal(fields.race, fields.gender)
		if r then races.set_race_and_gender(name, r, true) end

		if minetest.settings:get_bool("dynamic_spawn") == true then
			if races.tp_process[name] ~= true then
				--minetest.chat_send_player(name, SL("Teleporting to Spawn..."))
				races.tp_process[name] = true
				minetest.after(1, function()
					if spawn.check_conf(r[1] .. "_spawn_pos") then
						spawn.put_player_at_spawn(player, r[1] .. "_spawn_pos")
					else
						spawn.put_player_at_spawn(player, "common_spawn_pos")
					end
					races.tp_process[name] = false
					--minetest.after(1, function()
					--	races.show_skin_change_form(r[1], r[2], 1, name)
					--end)
				end)
			end
		end
	end
	if fields.ok then
		-- OK button pressed
		local r = races.to_internal(fields.race, fields.gender)
		races.set_race_and_gender(name, r, true)
		races.show_skin_change_form(r[1], r[2], 1, name)
	else
		-- Cancel button pressed, or escape pressed
		local r = races.default
		races.set_race_and_gender(name, r, true)
	end
end


return ChooseRaceForm
