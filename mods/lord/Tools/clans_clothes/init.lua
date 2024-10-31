minetest.mod(function(mod)
	local S = mod.translator


	-- Кланы, которые запросили плащ, прислали текстуры на GH
	local clan_titles = {
		['masons']        = 'Masons',
		['vassals']       = 'Vassals',
		['hansa']         = 'Hansa',
		['international'] = 'International',
	}

	for id, title in pairs(clan_titles) do
		minetest.register_tool("clans_clothes:cloak_" .. id, {
			description     = S(title .. " Clan Cloak"),
			inventory_image = "clans_clothes_cloak_" .. id .. "_inv.png",
			groups          = { clothes = 1, no_preview = 1, clothes_cloak = 1 },
			wear            = 0
		})
	end

	-- TODO: удалить в следующем релизе (сами апдейтятся через сундук движком при load map block)
	minetest.register_alias('clans_clothes:mason_cloak',  'clans_clothes:cloak_masons')
	minetest.register_alias('clans_clothes:vassal_cloak', 'clans_clothes:cloak_vassals')
	minetest.register_alias('clans_clothes:hansa_cloak',  'clans_clothes:cloak_hansa')
end)
