# Item Collection Mod

Мод для объединения предметов в коллекции (праздничные, уникальные и т.д.).
Коллекция предмета автоматически выводится в его подсказке (tooltip) после аннотации (`_annotation`).

## Использование в других модах

Объявите id коллекции константой и зарегистрируйте её (из любого мода, зависящего от `item_collection`):
```lua
item_collection.Id.CHRISTMAS = 'christmas'
item_collection.register(item_collection.Id.CHRISTMAS, {
    title = S('Christmas collection'),
    color = '#B380FF', -- необязательно
})
```

И укажите её в определении предмета:
```lua
core.register_craftitem('my_mod:my_item', {
    description = S('My Item'),
    _collection = item_collection.Id.CHRISTMAS, -- <--- добавляем это
    -- ... и далее по списку со всеми
})
```
