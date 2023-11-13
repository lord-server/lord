Моды из Minetest Game
=====================

Здесь собраны все моды, которые изначально были в [minetest_game](https://github.com/minetest/minetest_game) (MTG).

Многие MTG-моды изначально скопированы из [Lord-of-the-Test](https://github.com/minetest-LOTR/Lord-of-the-Test).
В Lord-of-the-Test они были до этого также скопированы из MTG первых версий и там изменены.
После Lord-of-the-Test иногда потягивал к себе обновления из MTG, а наши безбожно отстали.

Теперь эти моды подключены сабмодулями, а наши правки вынесены в `mods/lord/_overwrites`.  
https://github.com/orgs/lord-server/projects/6/views/1

Для обновления сначала требуетсся обновить моды в [Minetest-Game-Mod](https://github.com/minetest-game-mod/).  
см. закреплённый реп [_readme](https://github.com/minetest-game-mod/_readme)  
Далее обновляем здесь, запуском скрипта из этой папки:
```shell
$ ./up <version>
```

При дальнейших обновлениях сабмодулей из MTG:
 - просмотреть diff на предмет того, что добавилось, чтобы внести в changelog
 - просмотреть/скопировать `default/aliases.lua` в [`lord/Core/legacy/init.lua`](../lord/Core/legacy/init.lua), пометить версию
