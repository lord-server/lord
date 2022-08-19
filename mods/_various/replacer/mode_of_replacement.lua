
-- store for each user which mode the user has selected
replacer.user_mode = {}

-- descriptions for the dropdown menu (accessible via AUX1 + left-click)
replacer.mode_descriptions = {
	"[ normal ] replace material, shape and orientation according to the stored pattern",
	"[ material ] replace the material only (if possible), while keeping shape and orientation",
	"[ shape ] replace shape and orientation (if possible), while keeping the material"}

-- internal names for the above modes (will be stored in replacer.user_mode[ player_name ])
replacer.mode_names = {"normal", "material", "shape"}

-- make sure all mode descriptions are properly escaped for the dropdown menu
for i, v in ipairs(replacer.mode_descriptions) do
	replacer.mode_descriptions[i] = minetest.formspec_escape(v)
end

-- sometimes some few node names for on or two materials do not follow the
-- pattern of node names for that type; offer a way to translate them here
replacer.node_name_alternatives = {}
replacer.node_name_alternatives[ "default:mese_post_light_wood" ] = "default:mese_post_light"
replacer.node_name_alternatives[ "walls:desert_cobble" ] = "walls:desertcobble"

-- support for the circular saw; table contains prefixes as indices plus
-- a list of known suffixes for that prefix 
replacer.saw_prefixes = {}

-- populate replacer.saw_prefixes
if(minetest.global_exists("circular_saw") and circular_saw.names) then
	-- this is fixed for the saw and does not depend on which actual nodes are
	-- registered for it later on;
	-- we build this table replacer.saw_prefixes for faster lookup because
	-- many shapes share the same prefix
	for i, v in ipairs(circular_saw.names) do
		local prefix = v[1].."_"
		if(not(replacer.saw_prefixes[ prefix ])) then
			replacer.saw_prefixes[ prefix ] = {v[2]}
		else
			table.insert(replacer.saw_prefixes[ prefix ], v[2])
		end
	end
end


-- functions

-- does node_name match any name from the circular saw?
-- or is it a node from the cnc machine?
-- and if so, which material is it?
-- returns: {created_by_machine, source node name, mod_name, prefix, material, suffix}
--          (the last four form the name of the node)
replacer.identify_shape_and_material = function(full_node_name)
	local parts = full_node_name:split(":")
	if(not(parts) or #parts < 2) then
		return nil
	end
	local mod_name = parts[1]
	local node_name = parts[2]

	-- it might be a full block - or any other drawtype not really covered here
	local def = minetest.registered_nodes[ full_node_name ]
	if(def and def.drawtype and def.drawtype == "normal") then
		return {"normal", full_node_name,
			mod_name, "", node_name, ""}
	end

	-- a wooden fence rail
	local prefix = "fence_rail_"
	if(mod_name == "default" and node_name:sub(1, #prefix) == prefix) then
		local material = node_name:sub(#prefix + 1)
		return {"fence_rail", "default:"..material, "default", prefix, material, ""}
	end
	-- a wooden fence
	prefix = "fence_"
	if(mod_name == "default" and node_name:sub(1, #prefix) == prefix) then
		local material = node_name:sub(#prefix + 1)
		return {"fence", "default:"..material, "default", prefix, material, ""}
	end
	-- gates come in diffrent wood types as well
	prefix = "gate_"
	if(mod_name == "doors" and node_name:sub(1, #prefix) == prefix) then
		local gate_suffixes = {"_open", "_closed"}
		for i, suffix in ipairs(gate_suffixes) do
			if(node_name:sub(-#suffix) == suffix) then
				local material = node_name:sub(#prefix+1, -#suffix-1)
				return {"gate", "default:"..material, "doors", prefix, material, suffix}
			end
		end
	end
	-- a mese post (comes in diffrent wood types)
	prefix = "mese_post_light_"
	if(full_node_name == "default:mese_post_light") then
		return {"mese_post", "default:wood", "default", "mese_post_light_", "", ""}
	elseif(mod_name == "default" and node_name:sub(1, #prefix) == prefix) then
		local material = node_name:sub(#prefix + 1)
		return {"mese_post", "default:"..material, "default", prefix, material, ""}
	end
	-- walls (usually made out of stone)
	if(full_node_name == "walls:cobble") then
		return {"walls", "default:cobble", "walls", "", "cobble", ""}
	elseif(full_node_name == "walls:mossycobble") then
		return {"walls", "default:mossycobble", "walls", "", "mossycobble", ""}
	elseif(full_node_name == "walls:desertcobble") then
		return {"walls", "default:desert_cobble", "walls", "", "desert_cobble", ""}
	end

	-- it might be a regular stair (or similar node) from MinetestGame's stair mod
	if(mod_name == "stairs") then
		-- stair_inner_ and stair_outer_ need to be checked before stair_ is checked
		-- because they are more specific
		local stair_prefixes = {"stair_inner_", "stair_outer_", "stair_", "slab_"}
		for i, prefix in ipairs(stair_prefixes) do
			if(node_name:sub(1,#prefix) == prefix) then
				local material = node_name:sub(#prefix+1)
				return {"stairs", "default:"..material,
					mod_name, prefix, material, ""}
			end
		end
		return nil
	end

	-- check if we are dealing with a node from the circular saw from moreblocks
	for prefix, suffixes in pairs(replacer.saw_prefixes) do
		-- the prefix matches; does any suffix match?
		if(node_name:sub(1, #prefix) == prefix) then
			for i, suffix in ipairs(suffixes) do
				if(suffix == "" or node_name:sub(-#suffix) == suffix) then
					local material = node_name:sub(#prefix + 1, -#suffix-1)
					for m_name, m_parts in pairs(circular_saw.known_nodes) do
						if(m_parts[2] == material) then
							return {"circular_saw", m_name,
								m_parts[1], prefix, material, suffix}
						end
					end
				end
			end
			-- no need to check the other prefixes; they won't match either
			return ""
		end
	end

	-- check if we are dealing with a node from the cnc machine
	if(minetest.global_exists("technic_cnc") and technic_cnc.programs) then
		for i, data in ipairs(technic_cnc.programs) do
			if(full_node_name:sub(-#data.suffix-1) == "_"..data.suffix) then
				local source_node = full_node_name:sub(1,-#data.suffix-2)
				local p = source_node:split(":")
				return {"tecnic_cnc", source_node,
					p[1], "", p[2], "_"..data.suffix}
			end
		end
	end

	-- TODO: pkarcs, mymillworks etc. mods, pillars, castle, ..
	return nil
end


-- try to convert the old node into the desired new node
-- the mode is stored in replacer.user_mode[ player_name ] (fallback: normal)
replacer.get_new_node_data = function(old_node, stored_pattern, player_name)
	if(not(old_node) or not(stored_pattern) or not(old_node.name)) then
		return nil
	end

	-- normal mode of operation: replace material, shape and orientation
	if(not(replacer.user_mode)
	  or not(replacer.user_mode[ player_name ])
	  or replacer.user_mode[ player_name ] == "normal") then
		return stored_pattern
	end

	-- what type of node does the stored pattern represent? 
	local new_data = replacer.identify_shape_and_material(stored_pattern[1])
	-- if the type of the stored pattern cannot be identified, then abort here
	if(not(new_data)) then
		return nil
	end
	local old_data = replacer.identify_shape_and_material(old_node.name)
	-- if the type of the node that is to be replaced cannot be identified, then abort here
	if(not(old_data)) then
		return nil
	end

	-- replace material, but keep shape and orientation
	if(replacer.user_mode[ player_name ] == "material") then
		-- now try to replace the *material* of the old node while keeping prefix and postfix
		local new_name = old_data[3]..":"..old_data[4]..new_data[5]..old_data[6]
		-- handle some exceptions like mese post light wood and desert_cobble walls
		if(not(minetest.registered_nodes[ new_name ])
		  and replacer.node_name_alternatives[ new_name ]) then
			new_name = replacer.node_name_alternatives[ new_name ]
		end
		-- perhaps we need to change the mod name to the new material as well
		if(not(minetest.registered_nodes[ new_name ])) then
			new_name = new_data[3]..":"..old_data[4]..new_data[5]..old_data[6]
		end
		-- if the node still doesn't exist: give up
		if(not(minetest.registered_nodes[ new_name ])) then
			return nil
		end
		-- keep param1 and param2, but change the node name
		return {new_name, old_node.param1, old_node.param2}

	-- replace shape and orientation, but keep material
	elseif(replacer.user_mode[ player_name ] == "shape") then
		-- now try to replace the *material* of the old node while keeping prefix and postfix
		local new_name = new_data[3]..":"..new_data[4]..old_data[5]..new_data[6]
		-- handle some exceptions like mese post light wood and desert_cobble walls
		if(not(minetest.registered_nodes[ new_name ])
		  and replacer.node_name_alternatives[ new_name ]) then
			new_name = replacer.node_name_alternatives[ new_name ]
		end
		-- perhaps we need to change the mod name to the new material as well
		if(not(minetest.registered_nodes[ new_name ])) then
			new_name = old_data[3]..":"..new_data[4]..old_data[5]..new_data[6]
		end
		-- if the node still doesn't exist: give up
		if(not(minetest.registered_nodes[ new_name ])) then
			return nil
		end
		-- keep material, but change shape and orientation
		return {new_name, stored_pattern[2], stored_pattern[3]}
	end
end
