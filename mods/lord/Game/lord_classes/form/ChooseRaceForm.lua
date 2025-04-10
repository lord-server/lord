local S        = minetest.get_mod_translator()
local spec     = forms.Spec
local colorize = minetest.colorize


--- @class lord_classes.form.ChooseRace: base_classes.Form.Base
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
				end)
			end
		end
	end
	if fields.ok then
		-- OK button pressed
		local r = races.to_internal(fields.race, fields.gender)
		races.set_race_and_gender(name, r, true)
		races.show_skin_change_form(player, r[1], r[2], 1)
	else
		-- Cancel button pressed, or escape pressed
		local r = races.default
		races.set_race_and_gender(name, r, true)
		races.show_shadow_hud(player)
	end
end


return ChooseRaceForm:register()
