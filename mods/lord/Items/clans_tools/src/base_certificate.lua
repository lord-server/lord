local Form = require('base_certificate.Form')

local S        = minetest.get_mod_translator()
local colorize = minetest.colorize


local certify_privilege_name = minetest.settings:get('clans_tools.certify_privilege_name') or 'clan_base_certify'

minetest.register_privilege(certify_privilege_name, {
	description   = S('Can certify clan bases'),
	give_to_admin = true,
})

--- @param player Player
--- @return boolean
local function has_permissions(player)
	local has = minetest.check_player_privs(player, certify_privilege_name)

	return has
end

minetest.register_tool('clans_tools:base_certificate', {
	description     = S('Clan Base Certificate Blank'),
	_tt_help        = colorize('#aaa',  '\n' ..
		S('Only players with `@1` privilege can sign certificate.', certify_privilege_name)
	),
	inventory_image = 'clans_tools_base_certificate.png',
	stack_max       = 1,
	on_use          = function(itemstack, player, pointed_thing)
		local meta = itemstack:get_meta()
		print(dump(minetest.registered_tools['clans_tools:base_certificate']))
		if meta:contains('signed') then
			--- @type {for:string,by:string}
			local signed = minetest.deserialize(meta:get_string('signed'))
			local clan   = clans.clan_get_by_name(signed['for'])
			Form:new(player):open('for_show', clan.title, signed.by)
		else
			if has_permissions(player) then
				Form:new(player):open('for_edit')
			else
				itemstack:add_wear(65536 / 2)
				return itemstack
			end
		end
	end,
})

Form.on_sign(function(form, clan_key)
	local player = form:player()
	if not has_permissions(player) then
		return
	end

	local wielded_item = player:get_wielded_item()
	local meta = wielded_item:get_meta()
	local clan = clans.clan_get_by_name(clan_key)

	--- @type {for:string,by:string}
	local signed = minetest.serialize({
		['for'] = clan_key,
		['by' ] = player:get_player_name(),
	})
	meta:set_string('signed', signed)
	meta:set_string('description', S('Clan "@1" Base Certificate', colorize(clans.COLOR, clan.title)))

	player:set_wielded_item(wielded_item)
end)
