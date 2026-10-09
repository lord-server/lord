-- УЛЕЙ

local S = core.get_mod_translator()

-- Функции

  function formspecs.hive_artificial(pos)
    local spos = pos.x..','..pos.y..','..pos.z
    local formspec =
      'size[8,9]'..
      'background[0,0;0.1,0.1;bees_hive_artificial_background.png;true]'..
      'list[nodemeta:'..spos..';queen;3.5,1;1,1;]'..
      'list[nodemeta:'..spos..';frames;0,3;8,1;]'..
      'list[current_player;main;0,5;8,4;]'..
      'listring[nodemeta:'..spos..';frames]'..
      'listring[current_player;main]'
    return formspec
  end

  local function hive_artificial_on_rightclick(pos, node, clicker, itemstack)
    core.show_formspec(
      clicker:get_player_name(),
      'bees:hive_artificial',
      formspecs.hive_artificial(pos)
    )
    local meta = core.get_meta(pos)
    local inv  = meta:get_inventory()
    if meta:get_int('agressive') == 1 and inv:contains_item('queen', 'bees:bee') then
      local health = clicker:get_hp()
      if health <= 4 then
              clicker:set_wielded_item("")
      end
      clicker:set_hp(health - 4)
    else
      meta:set_int('agressive', 1)
    end
  end

  --- Checking the collection of an item from the hive
  --- @param pos      vector  position of the hive
  --- @param listname string  inventory list name
  --- @param index    number  slot index
  --- @param stack    ItemStack item being taken
  --- @param player   ObjectRef player or hopper fake-player
  --- @return         number amount allowed to take
  local function hive_artificial_allow_metadata_inventory_take(pos, listname, index, stack, player)
    if not player then return 0 end
    if core.is_protected(pos, player:get_player_name()) then
      return 0
    end
    if player.is_fake_player == ":hopper" then
      if stack:get_name() ~= "bees:frame_full" then
        return 0
      end
    end
    return stack:get_count()
  end

  --- checks for an empty slot in the list
  --- @param inv      InvRef inventory of the hive
  --- @param listname string inventory list name
  --- @return         boolean true if at least one slot is empty
  local function has_empty_slot(inv, listname)
    for i = 1, inv:get_size(listname) do
      if inv:get_stack(listname, i):is_empty() then
        return true
      end
    end
    return false
  end

  --- Arranging frames into empty slots
  --- @param inv InvRef inventory of the hive
  local function spread_frames(inv)
    local size = inv:get_size('frames')
    local free = {}
    for i = 1, size do
      if inv:get_stack('frames', i):is_empty() then
        free[#free + 1] = i
      end
    end
    local k = 1
    for i = 1, size do
      local s = inv:get_stack('frames', i)
      local n = s:get_count()
      if n > 1 then
        local moved = 0
        while moved < n - 1 and k <= #free do
          inv:set_stack('frames', free[k], ItemStack(s:get_name(), 1))
          k = k + 1
          moved = moved + 1
        end
        if moved > 0 then
          s:set_count(n - moved)
          inv:set_stack('frames', i, s)
        end
      end
    end
  end

  --- Activating the hive after inserting the frames
  --- @param pos       vector       position of the hive
  --- @param inv       InvRef       inventory of the hive
  --- @param timer     NodeTimerRef node timer of the position (survives swap_node)
  --- @param is_filled boolean   true if the hive is currently bees:hive_artificial_filled
  local function hopper_put_frames(pos, inv, timer, is_filled)
    spread_frames(inv)
    if inv:contains_item('queen', 'bees:bee')
    and inv:contains_item('frames', 'bees:frame_empty') then
      if is_filled then
        core.swap_node_if_not_same(pos, 'bees:hive_artificial')
      end
      local meta = core.get_meta(pos)
      if not timer:is_started() then
        timer:start(30)
        meta:set_int('progress', 0)
        meta:set_string('infotext', S('bees are acclimating'))
      end
    end
  end

  --- Processing of an item placed by a player
  --- @param pos      vector  position of the hive
  --- @param listname string  inventory list name ('queen' or 'frames')
  --- @param stack    ItemStack item that was put
  local function hive_on_put_player(pos, listname, stack)
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local is_filled = core.get_node(pos).name == 'bees:hive_artificial_filled'
    if not is_filled and listname == 'queen' then
      meta:set_string('queen', stack:get_name())
      meta:set_string('infotext', S('queen is inserted, now for the empty frames'))
    end
    if inv:contains_item('queen', 'bees:bee')
    and inv:contains_item('frames', 'bees:frame_empty') then
      if is_filled then
        core.swap_node_if_not_same(pos, 'bees:hive_artificial')
        meta = core.get_meta(pos)
      end
      local timer = core.get_node_timer(pos)
      if not timer:is_started() then
        timer:start(30)
        meta:set_int('progress', 0)
        meta:set_string('infotext', S('bees are acclimating'))
      end
    end
  end

  --- Checks whether items are allowed to be placed using a hopper
  --- @param inv      InvRef  inventory of the hive
  --- @param listname string  inventory list name
  --- @param stack    ItemStack item being put
  --- @return         number 1 if allowed, 0 otherwise
  local function hopper_allow_put(inv, listname, stack)
    if listname ~= 'frames' then return 0 end
    if stack:get_name() ~= 'bees:frame_empty' then return 0 end
    if not has_empty_slot(inv, 'frames') then return 0 end
    return 1
  end

  --- Checks whether the player is permitted to place items
  --- @param inv      InvRef  inventory of the hive
  --- @param listname string  inventory list name
  --- @param index    number  target slot index
  --- @param stack    ItemStack item being put
  --- @return number 1 if allowed, 0 otherwise
  local function player_allow_put(inv, listname, index, stack)
    if not inv:get_stack(listname, index):is_empty() then return 0 end
    if listname == 'queen' then
      if stack:get_name() == 'bees:bee' then return 1 end
    elseif listname == 'frames' then
      if stack:get_name() == 'bees:frame_empty' then return 1 end
    end
    return 0
  end

-- Ноды

-- Улей (обычный)
  core.register_node('bees:hive_artificial', {
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
      local meta = core.get_meta(pos)
      local inv = meta:get_inventory()
      meta:set_int('agressive', 1)
      inv:set_size('queen', 1)
      inv:set_size('frames', 8)
      meta:set_string('infotext',S('requires queen bee to function'))
    end,

    on_rightclick = hive_artificial_on_rightclick,

    on_timer = function(pos,elapsed)
      local meta = core.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = core.get_node_timer(pos)
      if inv:contains_item('queen', 'bees:bee') then
        if inv:contains_item('frames', 'bees:frame_empty') then
          timer:start(30)
          local rad  = 10
          local minp = {x=pos.x-rad, y=pos.y-rad, z=pos.z-rad}
          local maxp = {x=pos.x+rad, y=pos.y+rad, z=pos.z+rad}
          local flowers = core.find_nodes_in_area(minp, maxp, 'group:flower')
          local progress = meta:get_int('progress')
          progress = progress + #flowers
          meta:set_int('progress', progress)
          if progress > 1000 then
            local flower = flowers[math.random(#flowers)]
            bees.polinate_flower(flower, core.get_node(flower).name)
            local stacks = inv:get_list('frames')
            for k, v in pairs(stacks) do
              if inv:get_stack('frames', k):get_name() == 'bees:frame_empty' then
                meta:set_int('progress', (meta:get_int('progress')-1000))
                inv:set_stack('frames', k, 'bees:frame_full')
                if not inv:contains_item('frames', 'bees:frame_empty') then
                  timer:stop()
                  meta:set_string('infotext', S('does not have empty frame(s)'))
                  core.swap_node_if_not_same(pos, 'bees:hive_artificial_filled') -- Заменить улей на заполненный
                  return
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
          if not inv:is_empty('frames') then
            core.swap_node_if_not_same(pos, 'bees:hive_artificial_filled')
          end
          timer:stop()
        end
      end
    end,

    allow_metadata_inventory_take = hive_artificial_allow_metadata_inventory_take,

    on_metadata_inventory_take = function(pos, listname, index, stack, player)
      if listname == 'queen' then
        local timer = core.get_node_timer(pos)
        local meta = core.get_meta(pos)
        meta:set_string('infotext',S('requires queen bee to function'))
        timer:stop()
      end
    end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      local inv = core.get_meta(pos):get_inventory()
      if core.is_protected(pos, player:get_player_name()) then
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
      if player.is_fake_player == ":hopper" then
        if listname == 'frames' then
          hopper_put_frames(pos, core.get_meta(pos):get_inventory(),
            core.get_node_timer(pos), false)
        end
        return
      end
      if core.is_protected(pos, player:get_player_name()) then
        return
      end
      if listname == 'queen' or listname == 'frames' then
        hive_on_put_player(pos, listname, stack)
      end
    end,

    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
      if not player then return 0 end
      if core.is_protected(pos, player:get_player_name()) then
        return 0
      end
      local inv = core.get_meta(pos):get_inventory()
      if player.is_fake_player == ":hopper" then
        return hopper_allow_put(inv, listname, stack)
      end
      return player_allow_put(inv, listname, index, stack)
    end,
  })

-- Улей (заполненный)
  core.register_node('bees:hive_artificial_filled', {
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
      local meta = core.get_meta(pos)
      local inv = meta:get_inventory()
      meta:set_int('agressive', 1)
      inv:set_size('queen', 1)
      inv:set_size('frames', 8)
      meta:set_string('infotext',S('does not have empty frame(s)'))
      inv:set_stack('queen', 1, 'bees:bee')
      for i=1, inv:get_size('frames') do
        inv:set_stack('frames', i, 'bees:frame_full')
      end
    end,

    on_rightclick = hive_artificial_on_rightclick,

    allow_metadata_inventory_take = hive_artificial_allow_metadata_inventory_take,

    on_metadata_inventory_take = function(pos, listname, index, stack, player)
      local inv = core.get_meta(pos):get_inventory()
      if inv:is_empty('frames') then
        core.swap_node_if_not_same(pos, 'bees:hive_artificial')
      end
    end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
      local inv = core.get_meta(pos):get_inventory()
      if core.is_protected(pos, player:get_player_name()) then
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
      if not player then return 0 end
      if core.is_protected(pos, player:get_player_name()) then
        return 0
      end
      local inv = core.get_meta(pos):get_inventory()
      if player.is_fake_player == ":hopper" then
        return hopper_allow_put(inv, listname, stack)
      end
      return player_allow_put(inv, listname, index, stack)
    end,

    on_metadata_inventory_put = function(pos, listname, index, stack, player)
      if player.is_fake_player == ":hopper" then
        if listname == 'frames' then
          hopper_put_frames(pos, core.get_meta(pos):get_inventory(),
            core.get_node_timer(pos), true)
        end
        return
      end
      if core.is_protected(pos, player:get_player_name()) then
        return
      end
      hive_on_put_player(pos, listname, stack)
    end,
  })
