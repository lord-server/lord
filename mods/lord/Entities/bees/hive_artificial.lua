-- УЛЕЙ

local S = minetest.get_translator("bees")

-- Функции

  function formspecs.hive_artificial(pos)
    local spos = pos.x..','..pos.y..','..pos.z
    local formspec =
      'size[8,9]'..
      'background[0,0;0.1,0.1;bees_hive_artificial_background.png;true]'..
      'list[nodemeta:'..spos..';queen;3.5,1;1,1;]'..
      'list[nodemeta:'..spos..';frames;0,3;8,1;]'..
      'list[current_player;main;0,5;8,4;]'..
      'listcolors[#e5a73588;#f2d39a88;#201408]'..
      'listring[nodemeta:'..spos..';frames]'..
      'listring[current_player;main]'
    return formspec
  end

  local function swap_node(pos, name)
    local node = minetest.get_node(pos)
    if node.name == name then
      return
    end
    node.name = name
    minetest.swap_node(pos, node)
  end

  local function hive_artificial_on_rightclick(pos, node, clicker, itemstack)
    minetest.show_formspec(
      clicker:get_player_name(),
      'bees:hive_artificial',
      formspecs.hive_artificial(pos)
    )
    local meta = minetest.get_meta(pos)
    local inv  = meta:get_inventory()
    if meta:get_int('agressive') == 1 and inv:contains_item('queen', 'mobs:bee') then
      local health = clicker:get_hp()
      if health <= 4 then
              clicker:set_wielded_item("")
      end
      clicker:set_hp(health - 4)
    else
      meta:set_int('agressive', 1)
    end
  end

  local function hive_artificial_allow_metadata_inventory_take(pos, listname, index, stack, player)
    if minetest.is_protected(pos, player:get_player_name()) then
      return 0
    end
     return stack:get_count()
  end

-- Ноды

-- Улей (обычный)
  minetest.register_node('bees:hive_artificial', {
    description = S('bee hive'),
    tiles = {
      'default_wood.png',
      'default_wood.png',
      'default_wood.png',
      'default_wood.png',
      'default_wood.png',
      'default_wood.png^bees_hive_artificial_hole.png'
    },
    drawtype = 'nodebox',
    paramtype = 'light',
    paramtype2 = 'facedir',
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wooden=1},
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
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      meta:set_int('agressive', 1)
      inv:set_size('queen', 1)
      inv:set_size('frames', 8)
      meta:set_string('infotext',S('requires queen bee to function'))
    end,

    on_rightclick = hive_artificial_on_rightclick,

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
                meta:set_int('progress', (meta:get_int('progress')-1000))
                inv:set_stack('frames',k,'bees:frame_full')
                if k == inv:get_size('frames') then -- Если был заполнен последний стак
                  timer:stop()
                  meta:set_string('infotext', S('does not have empty frame(s)'))
                  swap_node(pos, 'bees:hive_artificial_filled') -- Заменить улей на заполненный
                end
                if meta:get_int('progress') < 1000 then
                  meta:set_string('infotext', 'Progress: '..meta:get_int('progress')..'+'..#flowers..'/1000')
                  return
                end
              end
            end
          else
            meta:set_string('infotext', 'Progress: '..progress..'+'..#flowers..'/1000')
          end
        else
          meta:set_string('infotext', S('does not have empty frame(s)'))
          swap_node(pos, 'bees:hive_artificial_filled')
          timer:stop()
        end
      end
    end,

    allow_metadata_inventory_take = hive_artificial_allow_metadata_inventory_take,

    on_metadata_inventory_take = function(pos, listname, index, stack, player)
      if listname == 'queen' then
        local timer = minetest.get_node_timer(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string('infotext',S('requires queen bee to function'))
        timer:stop()
      end
    end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      local inv = minetest.get_meta(pos):get_inventory()
      if minetest.is_protected(pos, player:get_player_name()) then
        return 0
      end
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
      if minetest.is_protected(pos, player:get_player_name()) then
        return 0
      end
      if listname == 'queen' or listname == 'frames' then
        meta:set_string('queen', stack:get_name())
        meta:set_string('infotext',S('queen is inserted, now for the empty frames'));
        if inv:contains_item('frames', 'bees:frame_empty') then
          timer:start(30)
          meta:set_int('progress', 0)
          meta:set_string('infotext',S('bees are acclimating'));
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

-- Улей (заполненный)
  minetest.register_node('bees:hive_artificial_filled', {
    description = S('filled bee hive'),
    tiles = {
      'default_wood.png',
      'default_wood.png',
      'default_wood.png^bees_hive_artificial_honey_drops.png',
      'default_wood.png^bees_hive_artificial_honey_drops.png',
      'default_wood.png^bees_hive_artificial_honey_drops.png',
      'default_wood.png^bees_hive_artificial_honey_drops.png^bees_hive_artificial_honey_hole.png'
    },
    drawtype = 'nodebox',
    paramtype = 'light',
    paramtype2 = 'facedir',
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wooden=1,not_in_creative_inventory=1},
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
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      meta:set_int('agressive', 1)
      inv:set_size('queen', 1)
      inv:set_size('frames', 8)
      meta:set_string('infotext',S('does not have empty frame(s)'))
      inv:set_stack('queen', 1, 'mobs:bee')
      for i=1, inv:get_size('frames') do
        inv:set_stack('frames', i, 'bees:frame_full')
      end
    end,

    on_rightclick = hive_artificial_on_rightclick,

    allow_metadata_inventory_take = hive_artificial_allow_metadata_inventory_take,

    on_metadata_inventory_take = function(pos, listname, index, stack, player)
      local inv = minetest.get_meta(pos):get_inventory()
      if inv:is_empty('frames') then
        swap_node(pos, 'bees:hive_artificial')
      end
    end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      local inv = minetest.get_meta(pos):get_inventory()
      if minetest.is_protected(pos, player:get_player_name()) then
        return 0
      end
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

    on_metadata_inventory_put = function(pos, listname, index, stack, player)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      if minetest.is_protected(pos, player:get_player_name()) then
        return 0
      end
      if inv:contains_item('frames', 'bees:frame_empty') then
        swap_node(pos, 'bees:hive_artificial')
        timer:start(30)
        meta:set_int('progress', 0)
        meta:set_string('infotext',S('bees are acclimating'));
      end
    end,
  })
