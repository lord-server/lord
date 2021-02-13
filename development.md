Разработка
==========

 - [Разворачивание локально](#Разворачивание-локально)
 - [Установка и настройка LuaCheck](#Установка-и-настройка-LuaCheck)

Разворачивание локально:
------------------------
Предполагается, что у вас уже установлены:
 - [Minetest](https://www.minetest.net/)
 - [Git](https://git-scm.com/) (`sudo apt install git`) ([экскурс на русском](https://githowto.com/ru))
 - [GitHub CLI](https://cli.github.com/) (`sudo apt install gh`) ([manual](https://cli.github.com/manual/))

и вы [добавили ssh-ключ](https://github.com/settings/ssh/new) на GitHub ([инструкция](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)).

Допустим все ваши проекты лежат в `~/projects` (или замените на свой путь):
```shell
cd ~/projects
mkdir lord-server
cd lord-server
# не забудьте предварительно добавить на GitHub свой публичный ssh-ключ
gh repo fork lord-server/lord --clone
cd ~/.minetest/games/
ln -s ~/projects/lord-server/lord
```
Проверить:
```shell
cd ~/projects/lord-server/lord
git status
minetest # Вкладка "Начать игру" -> выбрать внизу "lord" 
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
