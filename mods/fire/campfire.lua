--[[ This make from Minetest mod "New Campfire"
======================
Version: 0.1.3

# License of source code:
- Copyright (C) 2017 Pavel Litvinoff <googolgl@gmail.com>

- Authors of media (contained_campfire.obj) and (campfire.png) files:
- Nathan Salapat

- License of media (models): CC BY-SA

# Notice:
- This mod is only useable with Minetest 0.4.15-dev or above!

# Description:
- You can craft and use better campfire.
]]--

local SL = lord.require_intllib()

-- VARIABLES
campfire = {}

campfire_limit 	= 1;			-- Values: 0 - unlimit campfire, 1 - limit
campfire_ttl    = 90;			-- Time in sec
campfire_stick_time 	= campfire_ttl/2;	-- How long does the stick increase. In sec.

-- FUNCTIONS
local function fire_particles_on(pos) -- 3 layers of fire
    local meta = minetest.get_meta(pos)
    local id = minetest.add_particlespawner({ -- 1 layer big particles fire
          amount = 26,
		  time = 3.3,
		  minpos = {x = pos.x - 0.2, y = pos.y - 0.4, z = pos.z - 0.2},
		  maxpos = {x = pos.x + 0.2, y = pos.y - 0.1, z = pos.z + 0.2},
		  minvel = {x= 0, y= 0, z= 0},
		  maxvel = {x= 0, y= 0.1, z= 0},
		  minacc = {x= 0, y= 0, z= 0},
		  maxacc = {x= 0, y= 1, z= 0},
		  minexptime = 0.3,
		  maxexptime = 0.6,
		  minsize = 2,
		  maxsize = 5,
		  collisiondetection = false,
		  vertical = true,
		  texture = "campfire_fire.png",
--          animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length = 0.7,},
	--	      playername = "singleplayer"
	})
    meta:set_int("layer_1", id)

    local id = minetest.add_particlespawner({ -- 2 layer smol particles fire
		  amount = 3,
		  time = 3.3,
		  minpos = {x = pos.x - 0.1, y = pos.y, z = pos.z - 0.1},
		  maxpos = {x = pos.x + 0.1, y = pos.y + 0.4, z = pos.z + 0.1},
		  minvel = {x= 0, y= 0, z= 0},
		  maxvel = {x= 0, y= 0.1, z= 0},
 		  minacc = {x= 0, y= 0, z= 0},
		  maxacc = {x= 0, y= 1, z= 0},
		  minexptime = 0.3,
		  maxexptime = 0.5,
		  minsize = 0.5,
		  maxsize = 0.7,
		  collisiondetection = false,
		  vertical = true,
		  texture = "campfire_fire.png",
--          animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length = 0.6,},
	     -- playername = "singleplayer" -- показывать только определенному игроку.
	})
    meta:set_int("layer_2", id)

    local id = minetest.add_particlespawner({ --3 layer smoke
		  amount = 6,
		  time = 3.3,
		  minpos = {x = pos.x - 0.1, y = pos.y - 0.2, z = pos.z - 0.1},
		  maxpos = {x = pos.x + 0.2, y = pos.y + 0.4, z = pos.z + 0.2},
		  minvel = {x= 0, y= 0, z= 0},
		  maxvel = {x= 0, y= 0.1, z= 0},
		  minacc = {x= 0, y= 0, z= 0},
		  maxacc = {x= 0, y= 1, z= 0},
		  minexptime = 0.6,
		  maxexptime = 0.6,
		  minsize = 1,
		  maxsize = 4,
		  collisiondetection = true,
		  vertical = true,
		  texture = "campfire_smoke.png",
--          animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length = 0.7,},
		-- playername = "singleplayer"
	})
--    print (dump(id))
    meta:set_int("layer_3", id)
end

local function fire_particles_off(pos)
  local meta = minetest.get_meta(pos)
  local id_1 = meta:get_int("layer_1");
  local id_2 = meta:get_int("layer_2");
  local id_3 = meta:get_int("layer_3");
  minetest.delete_particlespawner(id_1)
  minetest.delete_particlespawner(id_2)
  minetest.delete_particlespawner(id_3)
end

local function indicator(maxVal, curVal)
    local percent_val = math.floor(curVal / maxVal * 100)
    local progress = ""
    local v = percent_val / 10
    for k=1,10 do
        if v > 0 then
            progress = progress.."▓"
        else
            progress = progress.."▒"
        end
        v = v - 1
    end
--    local progress = string.rep("▓", v)..string.rep("▒", 10 - v)
    return "\n"..progress.." "..percent_val.."%"
end

-- NODES

minetest.register_node('fire:campfire', {
	description = SL("Campfire"),
	drawtype = 'mesh',
	mesh = 'contained_campfire.obj',
--	mesh = 'contained_campfire_empty.obj',
	tiles = {name='[combine:16x16:0,0=default_cobble.png:0,8=default_wood.png'},
    inventory_image = "campfire.png",
    wield_image = "[combine:16x16:0,0=fire_basic_flame.png:0,12=default_cobble.png",
	walkable = false,
	buildable_to = false,
	sunlight_propagates = true,
	groups = {dig_immediate=3, flammable=0},
	paramtype = 'light',
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, -0.4, 0.48 },
		},
--	sounds = default.node_sound_stone_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', SL("Campfire"));
	end,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	  if itemstack:get_name() == "default:torch" then
		 minetest.sound_play("fire_flint_and_steel",{pos = pos, gain = 0.5, max_hear_distance = 8})
		 minetest.set_node(pos, {name = 'fire:campfire_active'})
         local id = minetest.add_particle({
	           pos = {x = pos.x, y = pos.y, z = pos.z},
	           velocity = {x=0, y=0.1, z=0},
	           acceleration = {x=0, y=0, z=0},
	           expirationtime = 2,
	           size = 4,
               collisiondetection = true,
               vertical = true,
               texture = "campfire_smoke.png",
--               animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length = 2.5,},
--             playername = "singleplayer"
        })
	  end
	end,
})

minetest.register_node('fire:campfire_active', {
	description = SL("Active campfire"),
	drawtype = 'mesh',
	mesh = 'contained_campfire.obj',
	tiles = {name='[combine:16x16:0,0=campfire_cobble.png:0,8=campfire_wood.png'},
    inventory_image = "campfire.png",
    wield_image = "[combine:16x16:0,0=fire_basic_flame.png:0,12=default_cobble.png",
	walkable = false,
	buildable_to = false,
	sunlight_propagates = true,
	groups = {dig_immediate=3, flammable=0, not_in_creative_inventory=1},
--	paramtype = 'light',
	paramtype = 'none',
    light_source = 13,
    damage_per_second = 3,
    drop = "fire:campfire",
--    sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, -0.4, 0.48 },
		},

    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
      if itemstack:get_definition().groups.stick == 1 then
          local meta = minetest.get_meta(pos)
          local it_val = meta:get_int("it_val") + (campfire_stick_time);
          meta:set_int('it_val', it_val);
          local id = minetest.add_particle({
 	           pos = {x = pos.x, y = pos.y+0.5, z = pos.z},
 	           velocity = {x=0, y=-1, z=0},
 	           acceleration = {x=0, y=0, z=0},
 	           expirationtime = 1,
 	           size = 4,
                collisiondetection = true,
                vertical = true,
                texture = "default_stick.png",
         })
         if not minetest.setting_getbool("creative_mode") then
            itemstack:take_item()
			return itemstack
         end
      end
	end,

    on_construct = function(pos)
  		local meta = minetest.get_meta(pos)
        if campfire_limit == 1 and campfire_ttl > 0 then
            meta:set_int('it_val', campfire_ttl);
            meta:set_string('infotext', SL("Active campfire")..indicator(1, 1));
        else
            meta:set_string('infotext', SL("Active campfire"));
        end
        minetest.get_node_timer(pos):start(2)
  	end,

    on_destruct = function(pos, oldnode, oldmetadata, digger)
        fire_particles_off(pos)
        local meta = minetest.get_meta(pos)
        local handle = meta:get_int("handle")
        minetest.sound_stop(handle)
  	end,

    on_timer = function(pos) -- Every 6 seconds play sound fire_small
        local meta = minetest.get_meta(pos)
        local handle = minetest.sound_play("fire_small",{pos=pos, max_hear_distance = 18, loop=false, gain=0.1})
        meta:set_int("handle", handle)
        minetest.get_node_timer(pos):start(6)
    end,
})

-- ABM
minetest.register_abm({
	nodenames = {"fire:campfire_active"},
--  neighbors = {"group:puts_out_fire"},
	interval = 3.0, -- Run every 3 seconds
	chance = 1, -- Select every 1 in 1 nodes
    catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
    local fpos, num = minetest.find_nodes_in_area(
      {x=pos.x-1, y=pos.y, z=pos.z-1},
      {x=pos.x+1, y=pos.y+1, z=pos.z+1},
      {"group:water"}
    )
    if #fpos > 0 then
      minetest.set_node(pos, {name = 'fire:campfire'})
      minetest.sound_play("fire_extinguish_flame",{pos = pos, max_hear_distance = 16, gain = 0.15})
    else
      if campfire_limit == 1 and campfire_ttl > 0 then
          local meta = minetest.get_meta(pos)
          local it_val = meta:get_int("it_val") - 3;
          if it_val <= 0 then
              minetest.remove_node(pos)
              return
          end
          meta:set_int('it_val', it_val);
          meta:set_string('infotext', SL("Active campfire")..indicator(campfire_ttl, it_val));
      end
      fire_particles_on(pos)
    end
  end
})

-- CRAFTS
minetest.register_craft({
	output = "fire:campfire",
	recipe = {
        {'stairs:slab_cobble','lord_homedecor:sticks', 'stairs:slab_cobble'},
        {'', 'stairs:slab_cobble', ''},
    }
})
