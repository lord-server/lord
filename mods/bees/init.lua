--Bees
------
--Author	Bas080
--Version	2.2
--License	WTFPL

local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

--VARIABLES
  local bees = {}
  local formspecs = {}

--FUNCTIONS
  function formspecs.hive_wild(pos, grafting)
    local spos = pos.x .. ',' .. pos.y .. ',' ..pos.z
    local formspec =
      'size[8,9]'..
      'list[nodemeta:'.. spos .. ';combs;1.5,3;5,1;]'..
      'list[current_player;main;0,5;8,4;]'
    if grafting then
      formspec = formspec..'list[nodemeta:'.. spos .. ';queen;3.5,1;1,1;]'
    end
    return formspec
  end

  function formspecs.hive_artificial(pos)
    local spos = pos.x..','..pos.y..','..pos.z
    local formspec =
      'size[8,9]'..
      'list[nodemeta:'..spos..';queen;3.5,1;1,1;]'..
      'list[nodemeta:'..spos..';frames;0,3;8,1;]'..
      'list[current_player;main;0,5;8,4;]'
    return formspec
  end

  -- спавнер цветов
  function bees.polinate_flower(pos, flower)
    local spawn_pos = { x=pos.x+math.random(-3,3) , y=pos.y+math.random(-3,3) , z=pos.z+math.random(-3,3) }
    local floor_pos = { x=spawn_pos.x , y=spawn_pos.y-1 , z=spawn_pos.z }
    local spawn = minetest.get_node(spawn_pos).name
    local floor = minetest.get_node(floor_pos).name
    if floor == 'default:dirt_with_grass' and spawn == 'air' then
      minetest.set_node(spawn_pos, {name=flower})
    end
  end

--NODES
  minetest.register_node('bees:extractor', {
    description = SL('honey extractor'),
    tiles = {"bees_extractor_top.png", "bees_extractor.png", "bees_extractor.png", "bees_extractor.png", "bees_extractor.png", "bees_extractor.png"},
    paramtype2 = "facedir",
    groups = {choppy=2,oddly_breakable_by_hand=2,tubedevice=1,tubedevice_receiver=1},
    on_construct = function(pos, node)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local pos = pos.x..','..pos.y..','..pos.z
      inv:set_size('frames_filled'  ,1)
      inv:set_size('frames_emptied' ,1)
      inv:set_size('bottles_empty'  ,1)
      inv:set_size('bottles_full' ,1)
      inv:set_size('wax',1)
      meta:set_string('formspec',
        'size[8,9]'..
        --input
        'image[1,1;1,1;bees_frame_full.png]'..
        'image[1,3;1,1;vessels_glass_bottle_inv.png]'..
        'list[nodemeta:'..pos..';frames_filled;2,1;1,1;]'..
        'list[nodemeta:'..pos..';bottles_empty;2,3;1,1;]'..
        --output
        'list[nodemeta:'..pos..';frames_emptied;5,0.5;1,1;]'..
        'list[nodemeta:'..pos..';wax;5,2;1,1;]'..
        'list[nodemeta:'..pos..';bottles_full;5,3.5;1,1;]'..
        --player inventory
        'list[current_player;main;0,5;8,4;]'
      )
    end,
    on_timer = function(pos, node)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      if not inv:contains_item('frames_filled','bees:frame_full') or not inv:contains_item('bottles_empty','vessels:glass_bottle') then
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
        local p = {x=pos.x+math.random()-0.5, y=pos.y+math.random()-0.5, z=pos.z+math.random()-0.5}
        --wax flying all over the place
        minetest.add_particle({
          pos = {x=pos.x, y=pos.y, z=pos.z},
          vel = {x=math.random(-4,4),y=math.random(8),z=math.random(-4,4)},
          acc = {x=0,y=-6,z=0},
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
      if (listname == 'bottles_empty' and stack:get_name() == 'vessels:glass_bottle') or (listname == 'frames_filled' and stack:get_name() == 'bees:frame_full') then
        return stack:get_count()
      else
        return 0
      end  
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      return 0
    end,
  })

  minetest.register_node('bees:bees', {
    description = SL('flying bees'),
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

-- дикий улей
  minetest.register_node('bees:hive_wild', {
    description = SL('wild bee hive'),
    tiles = {'bees_hive_wild.png','bees_hive_wild.png','bees_hive_wild.png', 'bees_hive_wild.png', 'bees_hive_wild_bottom.png'}, --Neuromancer's base texture
    drawtype = 'nodebox',
    paramtype = 'light',
    paramtype2 = 'wallmounted',
    drop = {
      max_items = 6,
      items = {
        { items = {'bees:honey_comb'}, rarity = 5}
      }
    },
    groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,attached_node=1},
    node_box = { --VanessaE's wild hive nodebox contribution
      type = 'fixed',
      fixed = {
        {-0.250000,-0.500000,-0.250000,0.250000,0.375000,0.250000}, --NodeBox 2
        {-0.312500,-0.375000,-0.312500,0.312500,0.250000,0.312500}, --NodeBox 4
        {-0.375000,-0.250000,-0.375000,0.375000,0.125000,0.375000}, --NodeBox 5
        {-0.062500,-0.500000,-0.062500,0.062500,0.500000,0.062500}, --NodeBox 6
      }
    },
    on_timer = function(pos)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer= minetest.get_node_timer(pos)
      local r  = 5
      local minp = {x=pos.x-r, y=pos.y-r, z=pos.z-r}
      local maxp = {x=pos.x+r, y=pos.y+r, z=pos.z+r}
      local flowers = minetest.find_nodes_in_area(minp, maxp, 'group:flower')
      
      -- если нет цветов в радиусе "r" королева умирает и колония погибает
      if #flowers == 0 then 
        inv:set_stack('queen', 1, '')
        meta:set_string('infotext', SL('this colony died, not enough flowers in area'))
        return 
      end --not any flowers nearby The queen dies! 
      
      if #flowers < 3 then return end --requires 2 or more flowers before can make honey / Требуется 2 или более цветов, еще можно сделать мед
      local flower = flowers[math.random(#flowers)] 
      bees.polinate_flower(flower, minetest.get_node(flower).name)
      local stacks = inv:get_list('combs')
      for k, v in pairs(stacks) do
        if inv:get_stack('combs', k):is_empty() then --then replace that with a full one and reset pro.. / затем заменить, что с полной и сбросить про ..
          inv:set_stack('combs',k,'bees:honey_comb')
          timer:start(1000/#flowers)
          return
        end
      end
      --what to do if all combs are filled / что делать, если все соты заполнены
      
    end,
    
    on_construct = function(pos)
      minetest.get_node(pos).param2 = 0
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      meta:set_int('agressive', 1)
      timer:start(100+math.random(100))
      inv:set_size('queen', 1)
      inv:set_size('combs', 5)
      inv:set_stack('queen', 1, 'mobs:bee')
      for i=1,math.random(3) do
        inv:set_stack('combs', i, 'bees:honey_comb')
      end
    end,
    
    on_punch = function(pos, node, puncher)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if inv:contains_item('queen','mobs:bee') then
        local health = puncher:get_hp()
        puncher:set_hp(health-4)
      end
    end,
    
    on_metadata_inventory_take = function(pos, listname, index, stack, taker)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer= minetest.get_node_timer(pos)
      if listname == 'combs' and inv:contains_item('queen', 'mobs:bee') then
        local health = taker:get_hp()
        timer:start(10)
        taker:set_hp(health-2)
      end
    end,
    
	--restart the colony by adding a queen / перезагрузите колонии, добавив королеву
    on_metadata_inventory_put = function(pos, listname, index, stack, taker) 
      local timer = minetest.get_node_timer(pos)
      if not timer:is_started() then
        timer:start(10)
      end
    end,
    
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
      if listname == 'queen' and stack:get_name() == 'mobs:bee' then
        return 1
      else
        return 0
      end
    end,
    
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
      minetest.show_formspec(
        clicker:get_player_name(),
        'bees:hive_artificial',
        formspecs.hive_wild(pos, (itemstack:get_name() == 'bees:grafting_tool'))
      )
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      if meta:get_int('agressive') == 1 and inv:contains_item('queen', 'mobs:bee') then
        local health = clicker:get_hp()
        clicker:set_hp(health-4)
      else
        meta:set_int('agressive', 1)
      end
    end,
    
    can_dig = function(pos,player)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      if inv:is_empty('queen') and inv:is_empty('combs') then
        return true
      else
        return false
      end
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, user)
      local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
      if 'bees:grafting_tool' == wielded:get_name() then 
        local inv = user:get_inventory()
        if inv then
          inv:add_item('main', ItemStack('mobs:bee'))
        end
      end
    end
  })

  --minetest.register_alias("mobs:beehive",'bees:hive_wild')

-- улей
  minetest.register_node('bees:hive_artificial', {
    description = SL('bee hive'),
    tiles = {'default_wood.png','default_wood.png','default_wood.png', 'default_wood.png','default_wood.png','bees_hive_artificial.png'},
    drawtype = 'nodebox',
    paramtype = 'light',
    paramtype2 = 'facedir',
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
    sounds = default.node_sound_wood_defaults(),
    node_box = {
      type = 'fixed',
      fixed = {
        {-4/8, 2/8, -4/8, 4/8, 3/8, 4/8},
        {-3/8, -4/8, -2/8, 3/8, 2/8, 3/8},
        {-3/8, 0/8, -3/8, 3/8, 2/8, -2/8},
        {-3/8, -4/8, -3/8, 3/8, -1/8, -2/8},
        {-3/8, -1/8, -3/8, -1/8, 0/8, -2/8},
        {1/8, -1/8, -3/8, 3/8, 0/8, -2/8},
      }
    },
    on_construct = function(pos)
      local timer = minetest.get_node_timer(pos)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      meta:set_int('agressive', 1)
      inv:set_size('queen', 1)
      inv:set_size('frames', 8)
      meta:set_string('infotext',SL('requires queen bee to function'))
    end,
    
    on_rightclick = function(pos, node, clicker, itemstack)
      minetest.show_formspec(
        clicker:get_player_name(),
        'bees:hive_artificial',
        formspecs.hive_artificial(pos)
      )
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      if meta:get_int('agressive') == 1 and inv:contains_item('queen', 'mobs:bee') then
        local health = clicker:get_hp()
        clicker:set_hp(health-4)
      else
        meta:set_int('agressive', 1)
      end
    end,
    
    on_timer = function(pos,elapsed)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if inv:contains_item('queen', 'mobs:bee') then
        if inv:contains_item('frames', 'bees:frame_empty') then
          timer:start(30)
          local rad  = 10
          local minp = {x=pos.x-rad, y=pos.y-rad, z=pos.z-rad}
          local maxp = {x=pos.x+rad, y=pos.y+rad, z=pos.z+rad}
          local flowers = minetest.find_nodes_in_area(minp, maxp, 'group:flower')
          local progress = meta:get_int('progress')
          progress = progress + #flowers
          meta:set_int('progress', progress)
          if progress > 1000 then
            local flower = flowers[math.random(#flowers)] 
            bees.polinate_flower(flower, minetest.get_node(flower).name)
            local stacks = inv:get_list('frames')
            for k, v in pairs(stacks) do
              if inv:get_stack('frames', k):get_name() == 'bees:frame_empty' then
                meta:set_int('progress', 0)
                inv:set_stack('frames',k,'bees:frame_full')
                return
              end
            end
          else
            meta:set_string('infotext', 'Progress: '..progress..'+'..#flowers..'/1000')
          end
        else
          meta:set_string('infotext', SL('does not have empty frame(s)'))
          timer:stop()
        end
      end
    end,
    
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
      if listname == 'queen' then
        local timer = minetest.get_node_timer(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string('infotext',SL('requires queen bee to function'))
        timer:stop()
      end
    end,
    
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      local inv = minetest.get_meta(pos):get_inventory()
      if from_list == to_list then 
        if inv:get_stack(to_list, to_index):is_empty() then
          return 1
        else
          return 0
        end
      else
        return 0
      end
    end,
    
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if listname == 'queen' or listname == 'frames' then
        meta:set_string('queen', stack:get_name())
        meta:set_string('infotext',SL('queen is inserted, now for the empty frames'));
        if inv:contains_item('frames', 'bees:frame_empty') then
          timer:start(30)
          meta:set_string('infotext',SL('bees are acclimating'));
        end
      end
    end,
    
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
      if not minetest.get_meta(pos):get_inventory():get_stack(listname, index):is_empty() then return 0 end
      if listname == 'queen' then
        if stack:get_name():match('mobs:bee*') then
          return 1
        end
      elseif listname == 'frames' then
        if stack:get_name() == ('bees:frame_empty') then
          return 1
        end
      end
      return 0
    end,
  })

--ABMS
  --particles / частицы (имитация вылета пчел из улья)
  --minetest.register_abm({ 
    --nodenames = {'bees:hive_artificial', 'mobs:beehive', 'bees:hive_industrial'},
    --interval  = 300,
    --chance    = 4,
    --action = function(pos)
      --minetest.add_particle({
        --pos = {x=pos.x, y=pos.y, z=pos.z},
        --vel = {x=(math.random()-0.5)*5,y=(math.random()-0.5)*5,z=(math.random()-0.5)*5},
        --acc = {x=math.random()-0.5,y=math.random()-0.5,z=math.random()-0.5},
        --expirationtime = math.random(2.5),
        --size = math.random(3),
        --collisiondetection = true,
        --texture = 'bees_particle_bee.png',
      --})
    --end,
  --})

  --spawn abm. This should be changed to a more realistic type of spawning
  minetest.register_abm({ 
    nodenames = {'group:leaves'},
    neighbors = {'group:flora'},
    interval = 3000,
    chance = 10,
    action = function(pos, node, _, active_object_count_wider)
		if active_object_count_wider > 0 then 
			--print("Здесь уже есть улей")
			return 
		end
      local p = {x=pos.x, y=pos.y-1, z=pos.z}
      if minetest.get_node(p).walkable == false then 
		return 
	  end
      
      --if (minetest.find_node_near(p, 5, 'group:flora') ~= nil and minetest.find_node_near(p, 40, 'mobs:beehive') == nil) then
        --minetest.add_node(p, {name='mobs:beehive'})
      --end
      print("начало спавна улья - "..tostring(os.clock()))
      if minetest.find_node_near(p, 40, 'bees:hive_wild') == nil then
        minetest.add_node(p, {name='bees:hive_wild'})
      end
      print("окончание спавна улья - "..tostring(os.clock()))
      
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

--ITEMS
  minetest.register_craftitem('bees:frame_empty', {
    description = SL('empty hive frame'),
    inventory_image = 'bees_frame_empty.png',
    stack_max = 24,
  })

  minetest.register_craftitem('bees:frame_full', {
    description = SL('filled hive frame'),
    inventory_image = 'bees_frame_full.png',
    stack_max = 12,
  })

  minetest.register_craftitem('bees:bottle_honey', {
    description = SL('honey bottle'),
    inventory_image = 'bees_bottle_honey.png',
    stack_max = 12,
    on_use = minetest.item_eat(3, "vessels:glass_bottle"),
  })
  
  minetest.register_craftitem('bees:wax', {
    description = SL('bees wax'),
    inventory_image = 'bees_wax.png',
    stack_max = 48,
  })

  minetest.register_craftitem('bees:honey_comb', {
    description = SL('honey comb'),
    inventory_image = 'bees_comb.png',
    on_use = minetest.item_eat(2),
    stack_max = 8,
  })

  --minetest.register_craftitem('bees:queen', {
    --description = 'Queen Bee',
    ----inventory_image = 'bees_particle_bee.png',
    --inventory_image = 'mobs_bee_inv.png',
    --stack_max = 1,
  --})
  
--CRAFTS
  minetest.register_craft({
    output = 'bees:extractor',
    recipe = {
      {'default:wood','default:steel_ingot','default:wood'},
      {'default:steel_ingot','default:stick','default:steel_ingot'},
      {'default:wood','default:steel_ingot','default:wood'},
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
      {'group:wood','default:stick','group:wood'},
      {'group:wood','default:stick','group:wood'},
    }
  })

  minetest.register_craft({
    output = 'bees:grafting_tool',
    recipe = {
      {'', '', 'default:steel_ingot'},
      {'', 'default:stick', ''},
      {'', '', ''},
    }
  })
  
  minetest.register_craft({
    output = 'bees:frame_empty',
    recipe = {
      {'group:wood',  'group:wood',  'group:wood'},
      {'default:stick', 'default:stick', 'default:stick'},
      {'default:stick', 'default:stick', 'default:stick'},
    }
  })

--TOOLS
  minetest.register_tool('bees:smoker', {
    description = SL('smoker'),
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
              vel = {x=0,y=0.5+math.random(),z=0},
              acc = {x=0,y=0,z=0},
              expirationtime = 2+math.random(2.5),
              size = math.random(3),
              collisiondetection = false,
              texture = 'bees_smoke_particle.png',
            })
          end
          --tool:add_wear(2)
          local meta = minetest.get_meta(pos)
          meta:set_int('agressive', 0)
          return nil
        end
      end
    end,
  })

  minetest.register_tool('bees:grafting_tool', {
    description = SL('grafting tool'),
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

  --PIPEWORKS
    if minetest.get_modpath("pipeworks") then
      minetest.register_node('bees:hive_industrial', {
        description = SL('industrial bee hive'),
        tiles = { 'bees_hive_industrial.png'},
        paramtype2 = 'facedir',
        groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,tubedevice=1,tubedevice_receiver=1},
        sounds = default.node_sound_wood_defaults(),
        tube = {
          insert_object = function(pos, node, stack, direction)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            if stack:get_name() ~= "bees:frame_empty" or stack:get_count() > 1 then
              return stack
            end
            for i = 1, 8 do
              if inv:get_stack("frames", i):is_empty() then
                inv:set_stack("frames", i, stack)
                local timer = minetest.get_node_timer(pos)
                timer:start(30)
                meta:set_string('infotext','bees are aclimating')
                return ItemStack("")
              end
            end
            return stack
          end,
          can_insert = function(pos,node,stack,direction)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            if stack:get_name() ~= "bees:frame_empty" or stack:get_count() > 1 then
              return false
            end
            for i = 1, 8 do
              if inv:get_stack("frames", i):is_empty() then
                return true
              end
            end
            return false
          end,
          can_remove = function(pos,node,stack,direction)
            if stack:get_name() == "bees:frame_full" then
              return 1
            else
              return 0
            end
          end,
          input_inventory = "frames",
          connect_sides = {left=1, right=1, back=1, front=1, bottom=1, top=1}
        },
        on_construct = function(pos)
          local timer = minetest.get_node_timer(pos)
          local meta = minetest.get_meta(pos)
          local inv = meta:get_inventory()
          meta:set_int('agressive', 1)
          inv:set_size('queen', 1)
          inv:set_size('frames', 8)
          meta:set_string('infotext','requires queen bee to function')
        end,
        on_rightclick = function(pos, node, clicker, itemstack)
          minetest.show_formspec(
            clicker:get_player_name(),
            'bees:hive_artificial',
            formspecs.hive_artificial(pos)
          )
          local meta = minetest.get_meta(pos)
          local inv  = meta:get_inventory()
          if meta:get_int('agressive') == 1 and inv:contains_item('queen', 'mobs:bee') then
            local health = clicker:get_hp()
            clicker:set_hp(health-4)
          else
            meta:set_int('agressive', 1)
          end
        end,
        on_timer = function(pos,elapsed)
          local meta = minetest.get_meta(pos)
          local inv = meta:get_inventory()
          local timer = minetest.get_node_timer(pos)
          if inv:contains_item('queen', 'mobs:bee') then
            if inv:contains_item('frames', 'bees:frame_empty') then
              timer:start(30)
              local rad  = 10
              local minp = {x=pos.x-rad, y=pos.y-rad, z=pos.z-rad}
              local maxp = {x=pos.x+rad, y=pos.y+rad, z=pos.z+rad}
              local flowers = minetest.find_nodes_in_area(minp, maxp, 'group:flower')
              local progress = meta:get_int('progress')
              progress = progress + #flowers
              meta:set_int('progress', progress)
              if progress > 1000 then
                local flower = flowers[math.random(#flowers)] 
                bees.polinate_flower(flower, minetest.get_node(flower).name)
                local stacks = inv:get_list('frames')
                for k, v in pairs(stacks) do
                  if inv:get_stack('frames', k):get_name() == 'bees:frame_empty' then
                    meta:set_int('progress', 0)
                    inv:set_stack('frames',k,'bees:frame_full')
                    return
                  end
                end
              else
                meta:set_string('infotext', 'progress: '..progress..'+'..#flowers..'/1000')
              end
            else
              meta:set_string('infotext', 'does not have empty frame(s)')
              timer:stop()
            end
          end
        end,
        on_metadata_inventory_take = function(pos, listname, index, stack, player)
          if listname == 'queen' then
            local timer = minetest.get_node_timer(pos)
            local meta = minetest.get_meta(pos)
            meta:set_string('infotext',SL('requires queen bee to function'))
            timer:stop()
          end
        end,
        allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
          local inv = minetest.get_meta(pos):get_inventory()
          if from_list == to_list then 
            if inv:get_stack(to_list, to_index):is_empty() then
              return 1
            else
              return 0
            end
          else
            return 0
          end
        end,
        on_metadata_inventory_put = function(pos, listname, index, stack, player)
          local meta = minetest.get_meta(pos)
          local inv = meta:get_inventory()
          local timer = minetest.get_node_timer(pos)
          if listname == 'queen' or listname == 'frames' then
            meta:set_string('queen', stack:get_name())
            meta:set_string('infotext','queen is inserted, now for the empty frames');
            if inv:contains_item('frames', 'bees:frame_empty') then
              timer:start(30)
              meta:set_string('infotext','bees are aclimating');
            end
          end
        end,
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
          if not minetest.get_meta(pos):get_inventory():get_stack(listname, index):is_empty() then return 0 end
          if listname == 'queen' then
            if stack:get_name():match('mobs:bee*') then
              return 1
            end
          elseif listname == 'frames' then
            if stack:get_name() == ('bees:frame_empty') then
              return 1
            end
          end
          return 0
        end,
      })
      minetest.register_craft({
        output = 'bees:hive_industrial',
        recipe = {
          {'default:steel_ingot','homedecor:plastic_sheeting','default:steel_ingot'},
          {'pipeworks:tube_1','bees:hive_artificial','pipeworks:tube_1'},
          {'default:steel_ingot','homedecor:plastic_sheeting','default:steel_ingot'},
        }
      })
    end

print('[Mod]Bees Loaded!')
