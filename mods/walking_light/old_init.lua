local players = {}
local player_positions = {}
local last_wielded = {}

function round(num) 
	return math.floor(num + 0.5) -- округление вниз
end

-- при регистрации игрока
minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	-- перед добавлением игрока в таблицу поищем его там
	-- вдруг был некорректный выход и он не удалился
	for i,v in ipairs(players) do
		if v == player_name then 
			table.remove(players, i)
		end
	end
	table.insert(players, player_name)
	last_wielded[player_name] = player:get_wielded_item():get_name()
	local pos = player:getpos()
	local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
	local wielded_item = player:get_wielded_item():get_name()
	if wielded_item ~= "default:torch" and wielded_item ~= "light:streetlight" then
		-- Neuberechnung des Lichts erzwingen
		-- пересчет силы света
		minetest.set_node(rounded_pos,{type="node",name="air"})
	end
	player_positions[player_name] = {}
	player_positions[player_name]["x"] = rounded_pos.x;
	player_positions[player_name]["y"] = rounded_pos.y;
	player_positions[player_name]["z"] = rounded_pos.z;
end)


-- при выходе игрока
minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	for i,v in ipairs(players) do
		if v == player_name then 
			table.remove(players, i)
			last_wielded[player_name] = nil
			-- Neuberechnung des Lichts erzwingen
			-- пересчет силы света
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			minetest.set_node(rounded_pos,{type="node",name="air"})
			player_positions[player_name]["x"] = nil
			player_positions[player_name]["y"] = nil
			player_positions[player_name]["z"] = nil
			player_positions[player_name]["m"] = nil
			player_positions[player_name] = nil
		end
	end
end)

-- Вызывается каждый шаг сервера, как правило, интервал 0,05 с
minetest.register_globalstep(function(dtime)
	for i,player_name in ipairs(players) do
	if minetest.get_player_by_name(player_name) then	
		local player = minetest.get_player_by_name(player_name)
		local wielded_item = player:get_wielded_item():get_name()
		if wielded_item == "default:torch" or wielded_item == "light:streetlight" then
			-- Fackel ist in der Hand
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			if (last_wielded[player_name] ~= "default:torch" and last_wielded[player_name] ~= "light:streetlight") 
			or (player_positions[player_name]["x"] ~= rounded_pos.x 
			or player_positions[player_name]["y"] ~= rounded_pos.y 
			or player_positions[player_name]["z"] ~= rounded_pos.z) then
				-- Fackel gerade in die Hand genommen oder zu neuem Node bewegt
				local is_air  = minetest.get_node_or_nil(rounded_pos)
				if is_air == nil or (is_air ~= nil and (is_air.name == "air" or is_air.name == "walking_light:light")) then
					-- wenn an aktueller Position "air" ist, Fackellicht setzen
					minetest.set_node(rounded_pos,{type="node",name="walking_light:light"})
				end
				if (player_positions[player_name]["x"] ~= rounded_pos.x or player_positions[player_name]["y"] ~= rounded_pos.y or player_positions[player_name]["z"] ~= rounded_pos.z) then
					-- wenn Position geänder, dann altes Licht löschen
					local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
					-- Neuberechnung des Lichts erzwingen
					local is_light = minetest.get_node_or_nil(old_pos)
					if is_light ~= nil and is_light.name == "walking_light:light" then
						minetest.set_node(old_pos,{type="node",name="air"})
					end
				end
				-- gemerkte Position ist nun die gerundete neue Position
				player_positions[player_name]["x"] = rounded_pos.x
				player_positions[player_name]["y"] = rounded_pos.y
				player_positions[player_name]["z"] = rounded_pos.z
			end

			last_wielded[player_name] = wielded_item;
		elseif last_wielded[player_name] == "default:torch" or last_wielded[player_name] == "light:streetlight" then
			-- Fackel nicht in der Hand, aber beim letzten Durchgang war die Fackel noch in der Hand
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			repeat
				local is_light  = minetest.get_node_or_nil(rounded_pos)
				if is_light ~= nil and is_light.name == "walking_light:light" then
					-- minetest.remove_node(rounded_pos)
					-- Erzwinge Neuberechnung des Lichts
					minetest.set_node(rounded_pos,{type="node",name="air"})
				end
			until minetest.get_node_or_nil(rounded_pos) ~= "walking_light:light"
			local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
			repeat
				is_light  = minetest.get_node_or_nil(old_pos)
				if is_light ~= nil and is_light.name == "walking_light:light" then
					-- minetest.remove_node(old_pos)
					-- Erzwinge Neuberechnung des Lichts
					minetest.set_node(old_pos,{type="node",name="air"})
				end
			until minetest.get_node_or_nil(old_pos) ~= "walking_light:light"
			last_wielded[player_name] = wielded_item
		end
	end
	end
end)

minetest.register_node("walking_light:light", {
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	buildable_to = true,
	light_source = 14,
	pointable = false,
	groups = {not_in_creative_inventory=1},
})
