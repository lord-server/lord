-- ДИКИЙ УЛЕЙ

local S = minetest.get_translator("bees")

-- Функции

  function formspecs.hive_wild(pos, grafting)
    local spos = pos.x .. ',' .. pos.y .. ',' ..pos.z
    local formspec =
      'size[8,9]'..
      'background[0,0;0.1,0.1;bees_hive_wild_background.png;true]'..
      'list[nodemeta:'.. spos .. ';combs;1.5,3;5,1;]'..
      'list[current_player;main;0,5;8,4;]'..
      'listcolors[#a0742588;#efca8588;#72531a]'..
      'listring[nodemeta:'..spos..';combs]'..
      'listring[current_player;main]'
    if grafting then
      formspec = formspec..'list[nodemeta:'.. spos .. ';queen;3.5,1;1,1;]'
    end
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

  local function hive_wild_on_punch(pos, node, puncher)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      if inv:contains_item('queen','mobs:bee') then
        local health = puncher:get_hp()
        puncher:set_hp(health-4)
      end
    end

  function hive_wild_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
      minetest.show_formspec(
        clicker:get_player_name(),
        'bees:hive_artificial',
        formspecs.hive_wild(pos, (itemstack:get_name() == 'bees:grafting_tool'))
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

-- Ноды

-- Дикий улей (обычный)
  minetest.register_node('bees:hive_wild', {
    description = S('wild bee hive'),
    tiles = {
      'bees_hive_wild_top.png',
      'bees_hive_wild_top.png',
      'bees_hive_wild.png',
      'bees_hive_wild.png',
      'bees_hive_wild.png',
      'bees_hive_wild.png^bees_hive_wild_hole.png'
    },
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
        meta:set_string('infotext', S('this colony died, not enough flowers in area'))
        return
      end --not any flowers nearby The queen dies!

      -- Requires 2 or more flowers before can make honey
      -- Требуется 2 или более цветов, чтобы можно было сделать мед
      if #flowers < 3 then return end
      local flower = flowers[math.random(#flowers)]
      local timer_mod = #flowers
      if timer_mod > 30 then timer_mod = 30 end
      bees.polinate_flower(flower, minetest.get_node(flower).name)
      local stacks = inv:get_list('combs')
      for k, v in pairs(stacks) do
        if inv:get_stack('combs', k):is_empty() then
          -- then replace that with a full one and reset pro..
          -- то заменяем на полную и сбрасываем про .. (таймер?)
          inv:set_stack('combs',k,'bees:honey_comb')
          if k == inv:get_size('combs') then -- Если был заполнен последний стак
            swap_node(pos, 'bees:hive_wild_filled') -- Заменить улей на заполненный
            timer:stop()
          else
            timer:start(60-timer_mod)
          end
          return
        end
      end
    end,

    on_construct = function(pos)
      minetest.get_node(pos).param2 = 0
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      meta:set_int('agressive', 1)
      timer:start(5)
      inv:set_size('queen', 1)
      inv:set_size('combs', 5)
      inv:set_stack('queen', 1, 'mobs:bee')
      for i=1,math.random(3) do
        inv:set_stack('combs', i, 'bees:honey_comb')
      end
    end,

    on_punch = hive_wild_on_punch,

    on_metadata_inventory_take = function(pos, listname, index, stack, taker)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer= minetest.get_node_timer(pos)
      if listname == 'combs' and inv:contains_item('queen', 'mobs:bee') then
        local health = taker:get_hp()
        timer:start(30)
        taker:set_hp(health-2)
      end
    end,

    --restart the colony by adding a queen / перезагрузите колонии, добавив королеву
    on_metadata_inventory_put = function(pos, listname, index, stack, taker)
      local meta = minetest.get_meta(pos)
      local timer = minetest.get_node_timer(pos)
      meta:set_string('infotext', '')
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

    on_rightclick = hive_wild_on_rightclick,

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

-- Дикий улей (Заполненный)
  minetest.register_node('bees:hive_wild_filled', {
    description = S('filled wild bee hive'),
    tiles = {
      'bees_hive_wild_top.png',
      'bees_hive_wild_top.png',
      'bees_hive_wild.png',
      'bees_hive_wild.png',
      'bees_hive_wild.png',
      'bees_hive_wild.png^bees_hive_wild_honey_hole.png'
    },
    drawtype = 'nodebox',
    paramtype = 'light',
    paramtype2 = 'wallmounted',
    drop = {
      max_items = 6,
      items = {
        { items = {'bees:honey_comb'}, rarity = 5}
      }
    },
    groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,attached_node=1,not_in_creative_inventory=1},
    node_box = { --VanessaE's wild hive nodebox contribution
      type = 'fixed',
      fixed = {
        {-0.250000,-0.500000,-0.250000,0.250000,0.375000,0.250000}, --NodeBox 2
        {-0.312500,-0.375000,-0.312500,0.312500,0.250000,0.312500}, --NodeBox 4
        {-0.375000,-0.250000,-0.375000,0.375000,0.125000,0.375000}, --NodeBox 5
        {-0.062500,-0.500000,-0.062500,0.062500,0.500000,0.062500}, --NodeBox 6
      }
    },

    on_construct = function(pos)
      minetest.get_node(pos).param2 = 0
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      meta:set_int('agressive', 1)
      timer:start(5)
      inv:set_size('queen', 1)
      inv:set_size('combs', 5)
      inv:set_stack('queen', 1, 'mobs:bee')
      for i=1, inv:get_size('combs') do
        inv:set_stack('combs', i, 'bees:honey_comb')
      end
    end,

    on_punch = hive_wild_on_punch,

    on_metadata_inventory_take = function(pos, listname, index, stack, taker)
      local meta = minetest.get_meta(pos)
      local inv  = meta:get_inventory()
      local timer= minetest.get_node_timer(pos)
      if listname == 'combs' then
        local health = taker:get_hp()
        timer:start(30)
        if inv:contains_item('queen', 'mobs:bee') then
          taker:set_hp(health-2)
        end
        swap_node(pos, 'bees:hive_wild')
      end
    end,

    on_rightclick = hive_wild_on_rightclick,

    can_dig = function(pos,player)
        return false
      end
  })
