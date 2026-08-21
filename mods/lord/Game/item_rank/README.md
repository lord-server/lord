# Item Rank Mod

Модуль для деленя предметов с цветовой подсветкой названий.

## Использование в других модах

```lua
minetest.register_item(':my_mod:my_item', {
    description = 'предмет',
    _rank = item_rank.RARE -- <--- добавляем это
    -- ... и далее по списку со всеми
})
```
