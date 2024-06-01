
--- @param clan clans.Clan
local function clan_web_create(clan)
	web_api.clans:create({
		-- TODO
	})
end

----- @param clan clans.Clan
--local function clan_web_...(clan)
--	web_api.clans:...({
--		-- TODO
--	})
--end


return {
	register = function()
		clans.on_create(clan_web_create)
		-- TODO: (blocked by: #1406)
		--clans.on_(clan_web_...)
		--clans.on_(clan_web_...)
		--clans.on_(clan_web_...)
		--clans.on_(clan_web_...)
	end
}
