
local S = minetest.get_mod_translator()

lottmobs = {}

lottmobs.guard = function(self, clicker, payment)
	local item = clicker:get_wielded_item()
	local name = clicker:get_player_name()
	if item:get_name() == "lottfarming:ear_of_corn"
		or item:get_name() == "farming:bread" then
		local hp = self.object:get_hp()
		if hp >= self.hp_max then
			minetest.chat_send_player(name, S("NPC at full health."))
			return
		end
		hp = hp + 4
		if hp > self.hp_max then hp = self.hp_max end
		self.object:set_hp(hp)
		if not minetest.is_creative_enabled(name) then
			item:take_item()
			clicker:set_wielded_item(item)
		end
	elseif item:get_name() == payment then
		if not minetest.is_creative_enabled(name) then
			item:take_item()
			clicker:set_wielded_item(item)
		end
		self.tamed = true
		if not self.owner or self.owner == "" then
			self.owner = clicker:get_player_name()
		end
		self.order = "follow"
	else
		if self.owner and self.owner == name then
			if self.order == "follow" then
				self.order = "stand"
			else
				self.order = "follow"
			end
		end
	end
end
