--Lord Bees
------
--Author (Bees)	Bas080
--Edits			Van (VanicGame)
--Version		2.2
--License		WTFPL

local S = minetest.get_translator("bees")

--VARIABLES
  bees = {}
  formspecs = {}

--FUNCTIONS
  function formspecs.extractor(pos)
    local spos = pos.x .. ',' .. pos.y .. ',' ..pos.z
    local formspec =
      'size[8,9]'..
        'background[0,0;0.1,0.1;bees_extractor_background.png;true]'..
        'listcolors[#b3835288;#cfb29388;#201408]'..
        --input
        'image[1,1;1,1;bees_frame_full.png]'..
        'image[1,3;1,1;vessels_glass_bottle_inv.png]'..
        'list[nodemeta:'.. spos ..';frames_filled;2,1;1,1;]'..
        'list[nodemeta:'.. spos ..';bottles_empty;2,3;1,1;]'..
        --output
        'list[nodemeta:'.. spos ..';frames_emptied;5,0.5;1,1;]'..
        'list[nodemeta:'.. spos ..';wax;5,2;1,1;]'..
        'list[nodemeta:'.. spos ..';bottles_full;5,3.5;1,1;]'..
        --player inventory
        'list[current_player;main;0,5;8,4;]'..
        --listring
        'listring[current_player;main]'..
        'listring[nodemeta:'..spos..';frames_filled]'..
        'listring[current_player;main]'..
        'listring[nodemeta:'..spos..';bottles_empty]'..
        'listring[current_player;main]'..
        'listring[nodemeta:'..spos..';frames_emptied]'..
        'listring[current_player;main]'..
        'listring[nodemeta:'..spos..';wax]'..
        'listring[current_player;main]'..
        'listring[nodemeta:'..spos..';bottles_full]'..
        'listring[current_player;main]'
    return formspec
  end

  -- спавнер цветов
  -- Прим. Van: надо править:
  -- Спавнятся только на dirt_with_grass
  function bees.polinate_flower(pos, flower)
    local spawn_pos = { x=pos.x+math.random(-3,3), y=pos.y, z=pos.z+math.random(-3,3) }
    local floor_pos = { x=spawn_pos.x , y=spawn_pos.y-1 , z=spawn_pos.z }
    local spawn = minetest.get_node(spawn_pos).name
    local floor_node = minetest.get_node(floor_pos).name
    if floor_node == 'default:dirt_with_grass' and spawn == 'air' then
      minetest.set_node(spawn_pos, {name=flower})
    end
  end

--NODES
  minetest.register_node('bees:honey_comb_block', {
    description = S('honey comb block'),
    tiles = {"bees_honey_comb_block.png"},
    groups = {oddly_breakable_by_hand=2, choppy=2},
    sounds = default.node_sound_wood_defaults(),
  })

  minetest.register_node('bees:wax_block', {
    description = S('wax block'),
    tiles = {"bees_wax_block.png"},
    groups = {oddly_breakable_by_hand=2, choppy=2},
    sounds = default.node_sound_wood_defaults(),
  })

  minetest.register_node('bees:extractor', {
    description = S('honey extractor'),
    tiles = {
      'bees_extractor_top.png',
      'bees_extractor_bottom.png',
      'default_wood.png^[transformR90^bees_extractor.png'
      },
    paramtype2 = "facedir",
    groups = {choppy=2,oddly_breakable_by_hand=2,tubedevice=1,tubedevice_receiver=1,wooden=1},
    sounds = default.node_sound_wood_defaults(),
    on_construct = function(pos, node)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      inv:set_size('frames_filled'  ,1)
      inv:set_size('frames_emptied' ,1)
      inv:set_size('bottles_empty'  ,1)
      inv:set_size('bottles_full' ,1)
      inv:set_size('wax',1)
      meta:set_string('formspec', formspecs.extractor(pos))
    end,
	can_dig = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("frames_filled") and
			inv:is_empty("frames_emptied") and
			inv:is_empty("bottles_empty") and
			inv:is_empty("bottles_full") and
			inv:is_empty("wax")
	end,
    on_timer = function(pos, node)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      if
        not inv:contains_item('frames_filled','bees:frame_full') or
        not inv:contains_item('bottles_empty','vessels:glass_bottle')
      then
        return
      end
      if inv:room_for_item('frames_emptied', 'bees:frame_empty')
      and inv:room_for_item('wax','bees:wax')
      and inv:room_for_item('bottles_full', 'bees:bottle_honey') then
        --add to output
        inv:add_item('frames_emptied', 'bees:frame_empty')
        inv:add_item('wax', 'bees:wax')
        inv:add_item('bottles_full', 'bees:bottle_honey')
        --remove from input
        inv:remove_item('bottles_empty','vessels:glass_bottle')
        inv:remove_item('frames_filled','bees:frame_full')

        --wax flying all over the place
        minetest.add_particle({
          pos = {x=pos.x, y=pos.y, z=pos.z},
          velocity = {x=math.random(-4,4),y=math.random(8),z=math.random(-4,4)},
          acceleration = {x=0,y=-6,z=0},
          expirationtime = 2,
          size = math.random(1,3),
          collisiondetection = false,
          texture = 'bees_wax_particle.png',
        })
        local timer = minetest.get_node_timer(pos)
        timer:start(5)
      else
        local timer = minetest.get_node_timer(pos)
        timer:start(1) -- Try again in 1 second
      end
    end,
    tube = {
      insert_object = function(pos, node, stack, direction)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local timer = minetest.get_node_timer(pos)
        if stack:get_name() == "bees:frame_full" then
          if inv:is_empty("frames_filled") then
            timer:start(5)
          end
          return inv:add_item("frames_filled",stack)
        elseif stack:get_name() == "vessels:glass_bottle" then
          if inv:is_empty("bottles_empty") then
            timer:start(5)
          end
          return inv:add_item("bottles_empty",stack)
        end
        return stack
      end,
      can_insert = function(pos,node,stack,direction)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        if stack:get_name() == "bees:frame_full" then
          return inv:room_for_item("frames_filled",stack)
        elseif stack:get_name() == "vessels:glass_bottle" then
          return inv:room_for_item("bottles_empty",stack)
        end
        return false
      end,
      input_inventory = {"frames_emptied", "bottles_full", "wax"},
      connect_sides = {left=1, right=1, back=1, front=1, bottom=1, top=1}
    },
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
      local timer = minetest.get_node_timer(pos)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if inv:get_stack(listname, 1):get_count() == stack:get_count() then -- inv was empty -> start the timer
          timer:start(5) --create a honey bottle and empty frame and wax every 5 seconds
      end
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
      if minetest.is_protected(pos, player:get_player_name()) then
        return 0
      end
      if
        (listname == 'bottles_empty' and stack:get_name() == 'vessels:glass_bottle') or
        (listname == 'frames_filled' and stack:get_name() == 'bees:frame_full')
      then
        return stack:get_count()
      else
        return 0
      end
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      return 0
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
      if minetest.is_protected(pos, player:get_player_name()) then
        return 0
      end

      return stack:get_count()
    end,
  })

  minetest.register_node('bees:bees', {
    description = S('flying bees'),
    drawtype = 'plantlike',
    paramtype = 'light',
    groups = { not_in_creative_inventory=1 },
    tiles = {
      {
        name='bees_strip.png',
        animation={type='vertical_frames', aspect_w=16,aspect_h=16, length=2.0}
      }
    },
    damage_per_second = 1,
    walkable = false,
    buildable_to = true,
    pointable = false,
    on_punch = function(pos, node, puncher)
      local health = puncher:get_hp()
      puncher:set_hp(health-2)
    end,
  })

  --minetest.register_alias("mobs:beehive",'bees:hive_wild')



--ABMS
  --particles / частицы (имитация вылета пчел из улья)
  minetest.register_abm({
    nodenames = {'bees:hive_artificial', 'bees:hive_wild'},
    interval  = 10,
    chance    = 2,
    action = function(pos)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      if inv:contains_item('queen', 'mobs:bee') then
        minetest.add_particle({
            pos = {x=pos.x, y=pos.y, z=pos.z},
          velocity = {x=(math.random()-0.5)*5,y=(math.random()-0.5)*5,z=(math.random()-0.5)*5},
          acceleration = {x=math.random()-0.5,y=math.random()-0.5,z=math.random()-0.5},
          expirationtime = math.random(2.5),
          size = math.random(3),
          collisiondetection = true,
          texture = 'bees_particle_bee.png',
        })
      end
    end,
  })

  --spawn abm. This should be changed to a more realistic type of spawning
  minetest.register_abm({
    nodenames = {'group:leaves'},
    neighbors = {'group:flora'},
    interval = 3000,
    chance = 10,
    action = function(pos, node, _, active_object_count_wider)
        if active_object_count_wider > 0 then
            return
        end
      local p = {x=pos.x, y=pos.y-1, z=pos.z}
      if minetest.get_node(p).walkable == false then
        return
      end

      if minetest.find_node_near(p, 40, 'bees:hive_wild') == nil then
        minetest.add_node(p, {name='bees:hive_wild'})
      end

    end,
  })

  --spawning bees around bee hive
  minetest.register_abm({
    nodenames = {'bees:hive_wild', 'bees:hive_artificial', 'bees:hive_industrial'},
    neighbors = {'group:flowers', 'group:leaves'},
    interval = 300,
    chance = 2,
    action = function(pos, node, _, _)
      local p = {x=pos.x+math.random(-5,5), y=pos.y-math.random(0,3), z=pos.z+math.random(-5,5)}
      if minetest.get_node(p).name == 'air' then
        minetest.add_node(p, {name='bees:bees'})
      end
    end,
  })

  --remove bees
  minetest.register_abm({
    nodenames = {'bees:bees'},
    interval = 100,
    chance = 3,
    action = function(pos, node, _, _)
      minetest.remove_node(pos)
    end,
  })

-- LBMS
   minetest.register_lbm({
     label = "formspec extractor replacement",
     name = "bees:extractor_formspec_replacement_2",
     nodenames = {"bees:extractor"},
     run_at_every_load = false,
     action = function(pos, node)
	 local meta = minetest.get_meta(pos)
	   meta:set_string('formspec', formspecs.extractor(pos))
     end
})

--ITEMS
  minetest.register_craftitem('bees:frame_empty', {
    description = S('empty hive frame'),
    groups = {wooden=1},
    inventory_image = 'bees_frame_empty.png',
  })

  minetest.register_craftitem('bees:frame_full', {
    description = S('filled hive frame'),
    inventory_image = 'bees_frame_full.png',
  })

  minetest.register_craftitem('bees:bottle_honey', {
    description = S('honey bottle'),
    inventory_image = 'bees_bottle_honey.png',
    on_use = minetest.item_eat(22),
    _tt_food_hp = 22,
  })

  minetest.register_craftitem('bees:wax', {
    description = S('bees wax'),
    inventory_image = 'bees_wax.png',
  })

  minetest.register_craftitem('bees:honey_comb', {
    description = S('honey comb'),
    inventory_image = 'bees_comb.png',
    on_use = minetest.item_eat(20),
    _tt_food_hp = 20,
  })

  --minetest.register_craftitem('bees:queen', {
    --description = 'Queen Bee',
    ----inventory_image = 'bees_particle_bee.png',
    --inventory_image = 'mobs_bee_inv.png',
    --stack_max = 1,
  --})

--CRAFTS
  minetest.register_craft({
    output = 'bees:honey_comb_block',
    recipe = {
      {'bees:honey_comb','bees:honey_comb','bees:honey_comb'},
      {'bees:honey_comb','bees:honey_comb','bees:honey_comb'},
      {'bees:honey_comb','bees:honey_comb','bees:honey_comb'},
    }
  })

  minetest.register_craft({
    type = 'shapeless',
    output = 'bees:honey_comb 9',
    recipe = {'bees:honey_comb_block'},
  })

  minetest.register_craft({
    output = 'bees:wax_block',
    recipe = {
      {'bees:wax','bees:wax','bees:wax'},
      {'bees:wax','bees:wax','bees:wax'},
      {'bees:wax','bees:wax','bees:wax'},
    }
  })

  minetest.register_craft({
    type = 'shapeless',
    output = 'bees:wax 9',
    recipe = {'bees:wax_block'},
  })

  minetest.register_craft({
    output = 'bees:extractor',
    recipe = {
      {'group:wood','default:steel_ingot','group:wood'},
      {'default:steel_ingot','group:stick','default:steel_ingot'},
      {'group:wood','default:steel_ingot','group:wood'},
    }
  })

  minetest.register_craft({
    output = 'bees:smoker',
    recipe = {
      {'default:steel_ingot', 'wool:red', ''},
      {'', 'default:torch', ''},
      {'', 'default:steel_ingot',''},
    }
  })

  minetest.register_craft({
    output = 'bees:hive_artificial',
    recipe = {
      {'group:wood','group:wood','group:wood'},
      {'group:wood','group:stick','group:wood'},
      {'group:wood','group:stick','group:wood'},
    }
  })

  minetest.register_craft({
    output = 'bees:grafting_tool',
    recipe = {
      {'', '', 'default:steel_ingot'},
      {'', 'group:stick', ''},
      {'', '', ''},
    }
  })

  minetest.register_craft({
    output = 'bees:frame_empty',
    recipe = {
      {'group:wood',  'group:wood',  'group:wood'},
      {'group:stick', 'group:stick', 'group:stick'},
      {'group:stick', 'group:stick', 'group:stick'},
    }
  })

--TOOLS
  minetest.register_tool('bees:smoker', {
    description = S('smoker'),
    groups = {steel_item = 1},
    inventory_image = 'bees_smoker.png',
    tool_capabilities = {
      full_punch_interval = 3.0,
      max_drop_level=0,
      damage_groups = {fleshy=2},
    },
    on_use = function(tool, user, node)
      if node then
        local pos = node.under
        if pos then
          for i=1,6 do
            minetest.add_particle({
              pos = {x=pos.x+math.random()-0.5, y=pos.y, z=pos.z+math.random()-0.5},
              velocity = {x=0,y=0.5+math.random(),z=0},
              acceleration = {x=0,y=0,z=0},
              expirationtime = 2+math.random(2.5),
              size = math.random(3),
              collisiondetection = false,
              texture = 'bees_smoke_particle.png',
            })
          end
          local meta = minetest.get_meta(pos)
          meta:set_int('agressive', 0)
          return nil
        end
      end
    end,
  })

  minetest.register_tool('bees:grafting_tool', {
    description = S('grafting tool'),
    groups = {steel_item = 1},
    inventory_image = 'bees_grafting_tool.png',
    tool_capabilities = {
      full_punch_interval = 3.0,
      max_drop_level=0,
      damage_groups = {fleshy=2},
    },
  })

--COMPATIBILTY --remove after all has been updated
  --ALIASES
    minetest.register_alias('bees:honey_extractor', 'bees:extractor')
  --BACKWARDS COMPATIBILITY WITH OLDER VERSION
    minetest.register_alias('bees:honey_bottle', 'bees:bottle_honey')
    minetest.register_abm({
      nodenames = {'bees:hive', 'bees:hive_artificial_inhabited'},
      interval = 1000,
      chance = 1,
      action = function(pos, node)
        if node.name == 'bees:hive' then
          minetest.set_node(pos, { name = 'bees:hive_wild' })
          local meta = minetest.get_meta(pos)
          local inv  = meta:get_inventory()
          inv:set_stack('queen', 1, 'mobs:bee')
        end
        if node.name == 'bees:hive_artificial_inhabited' then
          minetest.set_node(pos, { name = 'bees:hive_artificial' })
          local meta = minetest.get_meta(pos)
          local inv  = meta:get_inventory()
          inv:set_stack('queen', 1, 'mobs:bee')
          local timer = minetest.get_node_timer(pos)
          timer:start(60)
        end
      end,
    })

-- Load
local bees_path = minetest.get_modpath("bees")

dofile(bees_path.."/hive_wild.lua")
dofile(bees_path.."/hive_artificial.lua")
