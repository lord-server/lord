local S = minetest.get_translator("roads")

local function register_road(name, main_material, desc, fill) -- функция регистрации всех нодов дороги

  local function table_concat(s,t) -- функция объединение таблиц
    for i, v in pairs(t) do
      s[i] = v
    end
  end

  local mn = "roads:"..name -- имя мода с материалом
  local road_name = mn.."_road" -- дорога
  local border_name = mn.."_border" -- бордюр
  local inner_corner_border_name = mn.."_inner_corner_border" -- бордюр (внутренний угол)
  local outer_corner_border_name = mn.."_outer_corner_border" -- бордюр (внешний угол)
  local step_road_name = mn.."_step_road" -- ступенька дороги
  local step_border_name = mn.."_step_border" -- ступнька с бордюром
  local border_item_name = mn.."_border_item" -- бордюр(итем)

  local sp_groups = {not_in_creative_inventory = 1} -- специальная группа
  table_concat(sp_groups, desc.groups)

  -- textures: border_x, border_z, border_top, step_border_x,
  -- step_border_z, incorn_border_top, outcorn_border_top

  minetest.register_node(road_name, {
    description = S(desc.description.." road"),
    tiles = {fill},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
      type = "fixed",
      fixed = {
      {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}}
    },
  })

  -- бордюр

  minetest.register_node(border_name, {
    description = S(desc.description.." border"),
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-.5, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(border_name.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(border_name.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(border_name.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(border_name.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(border_name)
      return itemstack
  end
  })

  minetest.register_node(border_name.."A", {
    description = desc.description.." border A",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR270)",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.5},
        },
    },
    drop = border_name,
  })

  minetest.register_node(border_name.."B", {
    description = desc.description.." border B",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR180)",
             fill,
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, 0.5, 0.5, -0.25},
        },
    },
    drop = border_name,
  })

  minetest.register_node(border_name.."C", {
    description = desc.description.." border C",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR90)",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
        },
    },
    drop = border_name,
  })

    minetest.register_node(border_name.."D", {
    description = desc.description.." border D",
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-.5, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    drop = border_name,
  })

  -- внутренний угол

  minetest.register_node(inner_corner_border_name, {
    description = S(desc.description.." inner corner border"),
    tiles = {fill.."^roads_"..name.."_incorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.25}
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(inner_corner_border_name.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(inner_corner_border_name.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(inner_corner_border_name.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(inner_corner_border_name.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(inner_corner_border_name)
      return itemstack
  end
  })

  minetest.register_node(inner_corner_border_name.."A", {
    description = desc.description.." inner corner border A",
    tiles = {fill.."^(roads_"..name.."_incorn_border_top.png^[transformR270)",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.5},
            {-0.5, 0.25, -0.5, 0.25, 0.5, -0.25}
        },
    },
    drop = inner_corner_border_name,
  })

  minetest.register_node(inner_corner_border_name.."B", {
    description = desc.description.." inner corner border B",
    tiles = {fill.."^(roads_"..name.."_incorn_border_top.png^[transformR180)",
             fill,
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, 0.5, 0.5, -0.25},
            {-0.5, 0.25, -0.25, -0.25, 0.5, 0.5}
        },
    },
    drop = inner_corner_border_name,
  })

  minetest.register_node(inner_corner_border_name.."C", {
    description = desc.description.." inner corner border C",
    tiles = {fill.."^(roads_"..name.."_incorn_border_top.png^[transformR90)",
             fill,
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
            {-0.25, 0.25, 0.25, 0.5, 0.5, 0.5}
        },
    },
    drop = inner_corner_border_name,
  })

  minetest.register_node(inner_corner_border_name.."D", {
    description = desc.description.." inner corner border D",
    tiles = {fill.."^roads_"..name.."_incorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_z.png",
             fill.."^roads_"..name.."_border_z.png^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, 0.25}
        },
    },
    drop = inner_corner_border_name,
  })

  -- внешний угол

  minetest.register_node(outer_corner_border_name, {
    description = S(desc.description.." outer corner border"),
    tiles = {fill.."^roads_"..name.."_outcorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(outer_corner_border_name.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(outer_corner_border_name.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(outer_corner_border_name.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(outer_corner_border_name.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(outer_corner_border_name)
      return itemstack
  end
   })

  minetest.register_node(outer_corner_border_name.."A", {
    description = desc.description.." outer corner border A",
    tiles = {fill.."^(roads_"..name.."_outcorn_border_top.png^[transformR270)",
             fill,
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, -0.5, 0.5, 0.5, -0.25},
        },
    },
    drop = outer_corner_border_name,
   })

   minetest.register_node(outer_corner_border_name.."B", {
    description = desc.description.." outer corner border B",
    tiles = {fill.."^(roads_"..name.."_outcorn_border_top.png^[transformR180)",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, -0.25},
        },
    },
    drop = outer_corner_border_name,
   })

  minetest.register_node(outer_corner_border_name.."C", {
    description = desc.description.." outer corner border C",
    tiles = {fill.."^(roads_"..name.."_outcorn_border_top.png^[transformR90)",
             fill,
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5},
        },
    },
    drop = outer_corner_border_name,
   })

   minetest.register_node(outer_corner_border_name.."D", {
    description = desc.description.." outer corner border D",
    tiles = {fill.."^roads_"..name.."_outcorn_border_top.png",
             fill,
             fill.."^roads_"..name.."_border_x.png",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^(roads_"..name.."_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_border_x.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
            {0.25, 0.25, 0.25, 0.5, 0.5, 0.5},
        },
    },
    drop = outer_corner_border_name,
   })

  -- ступенька

  minetest.register_node(step_road_name, {
    description = S(desc.description.." step road"),
    tiles = {fill},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}
        },
    },
  })

  -- ступенька-бордюр

  minetest.register_node(step_border_name, {
    description = S(desc.description.." step border"),
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, 0.25, 0.5, 0, 0.5}
        },
    },
    on_place = function(itemstack, placer, pointed_thing)
      local dir = minetest.dir_to_facedir(placer:get_look_dir())
      if dir == 0 then
        itemstack:set_name(step_border_name.."D")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 1 then
        itemstack:set_name(step_border_name.."A")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 2 then
        itemstack:set_name(step_border_name.."B")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)

      elseif dir == 3 then
        itemstack:set_name(step_border_name.."C")
        minetest.item_place_node(itemstack, placer, pointed_thing, 0)
      end
      itemstack:set_name(step_border_name)
      return itemstack
    end
  })

  minetest.register_node(step_border_name.."A", {
    description = desc.description.." step border A",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR270)",
             fill,
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_x.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {0.25, -0.25, -0.5, 0.5, 0, 0.5}
        },
    },
    drop = step_border_name,
  })

  minetest.register_node(step_border_name.."B", {
    description = desc.description.." step border B",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR180)",
             fill,
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^roads_"..name.."_step_border_z.png"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.5, 0.5, 0, -0.25}
        },
    },
    drop = step_border_name,
  })

  minetest.register_node(step_border_name.."C", {
    description = desc.description.." step border C",
    tiles = {fill.."^(roads_"..name.."_border_top.png^[transformR90)",
             fill,
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^roads_"..name.."_step_border_z.png",
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)"},
    groups = sp_groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.5, -0.25, 0, 0.5}
        },
    },
    drop = step_border_name,
  })

  minetest.register_node(step_border_name.."D", {
    description = desc.description.." step border D",
    tiles = {fill.."^roads_"..name.."_border_top.png",
             fill,
             fill.."^roads_"..name.."_step_border_x.png",
             fill.."^(roads_"..name.."_step_border_x.png^[transformFX)",
             fill.."^roads_"..name.."_step_border_z.png"},
    groups = desc.groups,
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, 0.25, 0.5, 0, 0.5}
        },
    },
    drop = step_border_name,
  })

  -- бордюр(итем)

  minetest.register_craftitem(border_item_name, {
  description = S(desc.description.." border"),
  inventory_image = "roads_"..name.."_border_item.png"
  })

  -- крафты

  minetest.register_craft({
    output = border_item_name.." 8",
    recipe = {{main_material, main_material}},
  })

  minetest.register_craft({
    output = road_name.." 8",
    recipe = {{main_material, main_material,main_material},
              {main_material, main_material,main_material}},
  })

  minetest.register_craft({
    output = border_name,
    recipe = {{border_item_name},
              {road_name}},
  })

  minetest.register_craft({
    output = inner_corner_border_name,
    recipe = {{border_item_name, ""},
              {road_name, border_item_name}},
  })

  minetest.register_craft({
    output = outer_corner_border_name,
    recipe = {{"", border_item_name},
              {road_name, ""}},
  })

  minetest.register_craft({
    output = step_road_name.." 6",
    recipe = {{road_name, road_name}},
  })

  minetest.register_craft({
    output = step_border_name,
    recipe = {{border_item_name},
              {step_road_name}},
  })

  return true
end

register_road("stonebrick", "default:stonebrick", {
  description = "Stonebrick",
  groups = {cracky = 2}
}, "default_stone_brick.png")

register_road("sandstone",  "default:sandstone", {
  description = "Sandstone",
  groups = {crumbly = 3}
}, "default_sandstone.png")
