-- vessels/init.lua

-- Были добавлены, но у нас не используются (пока выпиливаем):
-- полка для сосудов (vessels:shelf)
minetest.unregister_item("vessels:shelf")
minetest.clear_craft({output = "vessels:shelf"})
