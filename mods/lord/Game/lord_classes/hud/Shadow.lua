local S         = minetest.get_mod_translator()
local colorize  = minetest.colorize


--- @class lord_classes.hud.Shadow: base_classes.HUD
--- @field show fun(self:lord_classes.hud.Shadow, show_spawn_to:boolean)
local ShadowHUD = {
	--- @type HudDefinition
	common         = {
		alignment = { x = 0, y = 1 },
		position  = { x = 0.5, y = 0 },
	},
	--- @type string
	text_color     = '#eeec',
	--- @type string
	commands_color = '#8ffc',
}
ShadowHUD = base_classes.HUD:extended(ShadowHUD)

--- @return HudDefinition[]
function ShadowHUD:get_definitions(show_spawn_to)
	--- @param text string
	local function cmd(text)
		return colorize(self.commands_color, text)
	end

	local text_offset_dy = show_spawn_to and 0 or 10

	--- @type HudDefinition
	local background = {
		name   = 'shadow_info_bg',
		type   = 'image',
		offset = { x = 0, y = 10 },
		text   = 'lord_classes_shadow_hud_bg.png^[opacity:170',
		scale  = { x = 2.5, y = 1.55 },
	}
	--- @type HudDefinition
	local header = {
		name   = 'shadow_info_header',
		type   = 'text',
		offset = { x = 0, y = 30 },
		text   = colorize(self.text_color, S('You are in Shadow mode!')),
		style  = 1,
		number = 0xff0000,
	}
	--- @type HudDefinition
	local text = {
		name   = 'shadow_info_text',
		type   = 'text',
		offset = { x = 0, y = 85 + text_offset_dy},
		text   = colorize(
			self.text_color,
			S('The Shadow can\'t interact with the world or chat.') .. '\n' ..
				S('However, the Shadow can fly and move quickly.') .. '\n' ..
				(show_spawn_to
					and
						S('Also, the Shadow can teleport to different race spawns') .. '\n' ..
						S('using the @1 command. (see @2)', cmd('/spawn_to'), cmd('/help spawn_to')) .. '\n'
					or
						''
				)
		) .. S('If you want to choose a race, use the @1 command.', cmd('/choose_race')) .. '\n',
	}
	--- @type HudDefinition[]
	local definitions = { background, header, text }

	return definitions
end



return ShadowHUD:register()
