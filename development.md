Разработка
==========

Разворачивание локально:
------------------------
Предполагается, что у вас уже установлены Minetest и Git (`sudo apt install git`).

Допустим все ваши проекты лежат в `~/projects` (или замените на свой путь):
```shell
cd ~/projects
mkdir lord-server
cd lord-server
git clone git@github.com:lord-server/lord.git # не забудьте добавить на GitHub свой публичный ssh-ключ
cd ~/.minetest/games/
ln -s ~/projects/lord-server/lord
```

Установка и настройка LuaCheck:
-------------------------------
 - установите пакетный менеджер LuaRocks:
   ```shell
   sudo apt install luarocks
   ```
 - установите LuaCheck:
   ```shell
   luarocks install --local luacheck
   ```
 - добавьте
