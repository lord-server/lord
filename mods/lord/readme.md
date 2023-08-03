Наши Моды
=========

Здесь собраны все моды, которые написаны нами. А также сторонние моды, которы мы сильно изменили
под нас и теперь код очень сильно расходится с оригиналом.

Присутствуют моды из [Lord-of-the-Test](https://github.com/minetest-LOTR/Lord-of-the-Test) (LOTT) - это сборка,
из которой изначально вырос наш LORD. Т.е. изначально всё было скопировано оттуда и дальше постепенно понемногу
подправлялось, дорабатывалось, дополнялось и пр.  
Большинство этих модов имеют приставку `lott`.  
Было последнее [обновление модов LOTT](https://github.com/orgs/lord-server/projects/6/views/2), т.к. проект больше
не развивается. Теперь эти моды поддерживаем, развиваем сами и в отм числе перерабатываем.

Подпапки:
---------
 - [`Blocks`](Blocks/readme.md) - блоки/ноды
 - [`Core`](Core/readme.md) - общего назначения (хелперы, луа-расширение, ...)
 - [`Player`](Player/readme.md) - инвентарь, внешний вид, HUD, ...
 - [`Tools`](Tools/readme.md) - кирки/лопаты/..., мечи/броня/стрелы/..., ...
 - [`World`](World/readme.md) - mapgen'ы, генерящиеся здания, амбиенс, музыка, арены, ...


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

### `lord_info`
 - команды `/info`, `/news`, `/new_help`, `/list`, обработка и формочки к ним

### `lord_names_rules`
 - правила формирования имени игрока (при регистрации)

### `lord_screwdriver`
 - Отвёртки `lord_screwdriver:screwdriver`, `lord_screwdriver:screwdriver_galvorn`
 - Оптимизирована текстура `screwdriver_galvorn.png` 9406 bytes -> 257 bytes
 - Зависит от `MTG/screwdriver`

### `throwing`
 - вынесено из [`lottthrowing`](https://github.com/minetest-LOTR/Lord-of-the-Test/tree/master/mods/lottthrowing) и допилено: разделено на движок/api(`throwing`) и бросабельные-итемы/ака-стрелы(`arrows`))
 - завезена физика притяжения (полёт/падение "стрелы" по дуге)
 - возможно на базе другого мода-апи (например, [этого](https://github.com/minetest-mods/throwing))

### `tools`
 - вынесено из [`lottweapons`](https://github.com/minetest-LOTR/Lord-of-the-Test/tree/master/mods/lottweapons) и дополнено

### `< возможно что-то ещё, но оно перенесено в другие папки по ошибке >`
 - ...
