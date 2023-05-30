Наши Моды
=========

Здесь собраны все моды, которые написаны нами. А также сторонние моды, которы мы сильно изменили
под нас и теперь код очень сильно расходится с оригиналом.



Моды:
-----

### [`_overwrites`](_overwrites/readme.md)
 - это modpack с различными нашими переопределениями
 - подробнее в [_overwrites/readme.md](_overwrites/readme.md)

### `arrows`
 - вынесено из [`lottthrowing`]((https://github.com/minetest-LOTR/Lord-of-the-Test/tree/master/mods/lottthrowing)): разделено на движок/api(`throwing`) и бросабельные-итемы/ака-стрелы(`arrows`))

### `death_handler`
 - сохраняем умерших игроков в массив (в момент смерти), выполняя колбек, и удаляем из массива при возрождении
 - Этот мод был нужен для исправления бага с коллбеком на смерть.  
   По какой-то неизвестной причине он срабатывал очень много раз, в итоге из-за одной смерти появлялась сотня трупов.  
   Изначально это просто хотфикс был, может уже в движке починили.

### `factions`
 - вынесено из `mobs`

### `grinder`
 - "Дробилка"
 - полностью переписано из мода аля [technic](https://content.minetest.net/packages/RealBadAngel/technic/)
   ([code](https://github.com/minetest-mods/technic))

### `legacy`
 - вынесено из LOTT/`mods/default/`[legacy.lua](https://github.com/minetest-LOTR/Lord-of-the-Test/blob/master/mods/default/legacy.lua)

### `lord_base_commands`
 - только перевод. (команд)

### `lord_base_privs`
 - регистрация базовых привилегий
 - < наш или откуда-то взят ??? >

### `lord_classes`
 - доработки и переделки из [lottclasses](https://github.com/minetest-LOTR/Lord-of-the-Test/tree/master/mods/lottclasses)
 - все скины здесь
 - обработка смен скинов и выбор скина вначале игры

### `lord_homedecor`
 - < откуда ? >
 - < что там ? >
 - < какие наши правки ? >

### `lord_info`
 - команды `/info`, `/news`, `/new_help`, `/list`, обработка и формочки к ним

### `lord_money`
 - система денег и магазинчиков
 - монеты (4х видов), магазин, лицензия
 - возможно на базе какого-то стороннего мода

### `lord_names_rules`
 - правила формирования имени игрока (при регистрации)

### `lord_screwdriver`
 - Отвёртки `lord_screwdriver:screwdriver`, `lord_screwdriver:screwdriver_galvorn`
 - Оптимизирована текстура `screwdriver_galvorn.png` 9406 bytes -> 257 bytes
 - Зависит от `MTG/screwdriver`

### `lord_wool`
 - ступени и плиты из шерсти `stairs:{stair,slab}_wool<colorname>`

### `lordlib`
 - вспомогательные функции (`lord.require_intllib()`)

### `mega_sl`
 - Сохранение и загрузка области карты (команды `/S` и `/L`)

### `spawn`
 - команды /life, /spawn
 - перемещение на статическую точку спауна

### `throwing`
 - вынесено из [`lottthrowing`](https://github.com/minetest-LOTR/Lord-of-the-Test/tree/master/mods/lottthrowing) и допилено: разделено на движок/api(`throwing`) и бросабельные-итемы/ака-стрелы(`arrows`))
 - завезена физика притяжения (полёт/падение "стрелы" по дуге)
 - возможно на базе другого мода-апи (например, [этого](https://github.com/minetest-mods/throwing))

### `tools`
 - вынесено из [`lottweapons`](https://github.com/minetest-LOTR/Lord-of-the-Test/tree/master/mods/lottweapons) и дополнено

### `< возможно что-то ещё, но оно перенесено в другие папки по ошибке >`
 - ...
