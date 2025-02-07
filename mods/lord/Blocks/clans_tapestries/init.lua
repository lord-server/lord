
minetest.mod(function(mod)

	local S        = mod.translator
	local logger   = mod.logger
	local colorize = minetest.colorize

	castle.tapestry.register(
		'clans_tapestries:example',
		S('@1 Clan Tapestry', S('"Example"')),
		'clans_tapestries_example.png'
	)
	-- --------------------------------
	local clans_with_tapestries = {
		'masons', 'vassals', 'hansa', 'international',
	}
	for _, clan_name in pairs(clans_with_tapestries) do
		local clan = clans.clan_get_by_name(clan_name)
		if not clan then
			logger.warning('Clan `%s` not found', clan_name)
		else
			castle.tapestry.register(
				'clans_tapestries:' .. clan_name,
				S('@1 Clan Tapestry', colorize(clans.COLOR, clan.title)),
				'clans_tapestries_' .. clan_name .. '.png'
			)
		end
	end

end)
