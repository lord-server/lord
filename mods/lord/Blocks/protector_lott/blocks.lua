local SL = lord.require_intllib()

minetest.register_alias("protector_lott:protect", "protector_lott:protect_stone")

local function reg_prot_node(subname, desc, base_node_name, texture)
	local groups = {}
	groups.protector = 1
	groups.dig_immediate = 2
	groups.unbreakable = 1
	for i, j in pairs(minetest.registered_nodes[base_node_name].groups) do
		groups[i] = j
	end

	minetest.register_node("protector_lott:protect_"..subname, {
		description = SL("Protection "..desc),
		tiles = {texture, texture, texture.."^protector_logo.png"},
		sounds = default.node_sound_stone_defaults(),
		groups = groups,
		paramtype = "light",

		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name() or "")
			meta:set_string("infotext", SL("Protection").." ("..SL("owned by").." " .. meta:get_string("owner") .. ")")
			meta:set_string("members", "")
		end,

		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type ~= "node" then return end
			protector.can_dig(protector.radius, pointed_thing.under, user:get_player_name(), false, 2)
		end,

		on_rightclick = function(pos, node, clicker, itemstack)
			local meta = minetest.get_meta(pos)
			if protector.can_dig(1, pos,clicker:get_player_name(), true, 1) then
				minetest.show_formspec(clicker:get_player_name(),
				"protector_lott:node_" .. minetest.pos_to_string(pos), protector.generate_formspec(meta))
			end
		end,

		on_punch = function(pos, node, puncher)
			if not protector.can_dig(1, pos, puncher:get_player_name(), true, 1) then
				return
			end
			minetest.add_entity(pos, "protector_lott:display")
		end,

		can_dig = function(pos, player)
			return protector.can_dig(1, pos, player:get_player_name(), true, 1)
		end,
	})

	minetest.register_craft({
		output = "protector_lott:protect_"..subname,
		recipe = {
			{base_node_name, "protector_lott:protect2"},
		}
	})
end

reg_prot_node("brick", "Brick Block", "default:brick", "default_brick.png")
reg_prot_node("obsidian", "Obsidian", "default:obsidian", "default_obsidian.png")

reg_prot_node("stone", "Stone", "default:stone", "default_stone.png")
reg_prot_node("cobble", "Cobble", "default:cobble", "default_cobble.png")
reg_prot_node("stonebrick", "Stonebrick", "default:stonebrick", "default_stone_brick.png")

reg_prot_node("desertstone", "Desert Stone", "default:desert_stone", "default_desert_stone.png")
reg_prot_node("desert_cobble", "Desert Cobble", "default:desert_cobble", "default_desert_cobble.png")
reg_prot_node("desertstonebrick", "Desert Stone Brick", "default:desert_stonebrick", "default_desert_stone_brick.png")

reg_prot_node("sandstone", "Sandstone", "default:sandstone", "default_sandstone.png")
reg_prot_node("sandstonebrick", "Sandstone Brick", "default:sandstonebrick", "default_sandstone_brick.png")

reg_prot_node("dungeon_stone", "Dungeon Stone", "castle:dungeon_stone", "castle_dungeon_stone_m.png")
reg_prot_node("pavement", "Paving Stone", "castle:pavement", "castle_pavement_brick.png")
reg_prot_node("marble", "Marble", "lottores:marble", "lottores_marble.png")
reg_prot_node("marble_brick", "Marble Brick", "lottblocks:marble_brick", "lottblocks_marble_brick.png")
reg_prot_node("orc_brick", "Orc Brick", "lottblocks:orc_brick", "lottblocks_orc_brick.png")
reg_prot_node("mordor_stone", "Mordor Stone", "lord_rocks:mordor_stone", "lord_rocks_mordor_stone.png")
