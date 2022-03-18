Разработка
==========

 - [Разворачивание локально](#Разворачивание-локально)
 - [Code-Style](#Code-Style)
 - [Установка и настройка LuaCheck](#Установка-и-настройка-LuaCheck)
 - [Обновление своего форка](#Обновление-своего-форка)
 - [Релизный процесс](#Релизный-процесс)

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
gh repo fork lord-server/lord --clone # --recursive
cd ~/.minetest/games/
ln -s ~/projects/lord-server/lord
```
Проверить:
```shell
cd ~/projects/lord-server/lord
git status
minetest # Вкладка "Начать игру" -> выбрать внизу "lord" 
```

Code-Style
----------
Мы придерживаемся code-style, принятого в Minetest:
https://dev.minetest.net/Lua_code_style_guidelines
Наши исключения и дополнения:
- длина строки до 120 символов
- константы капсом
(возможно более актуальный code-style и его обсуждение есть в [ветке Discord](https://discord.com/channels/268093825975713793/842734469336793108/905237586610647151))

Установка и настройка LuaCheck:
-------------------------------
В качестве линтера и статического анализатора мы используем [Luacheck](https://github.com/mpeterv/luacheck).
Проверки Luacheck запускаются автоматически на GitHub, но вы можете запускать их локально,
прежде чем закоммитить и отправить pull request:
 - установите пакетный менеджер LuaRocks:
   ```shell
   sudo apt install luarocks
   ```
 - установите LuaCheck:
   ```shell
   luarocks install --local luacheck
   ```
   
 - запуск проверки:
   ```shell
   luacheck .
   ```

Обновление своего форка:
------------------------
 - Добавьте дополнительный remote на оригинальный репозиторий:
   - для начала проверьте, нет ли его уже:
     ```shell
     $ git remote -v
     ```
     должно вывести что-то вроде этого:
     ```shell
     origin  git@github.com:<your_account>/lord.git (fetch)
     origin  git@github.com:<your_account>/lord.git (push)
     upstream        git@github.com:lord-server/lord.git (fetch)
     upstream        git@github.com:lord-server/lord.git (push)
     ```
   - если нет, добавляем новый remote на оригинальный репозиторий:
     ```shell
     $ git remote add upstream git@github.com:lord-server/lord.git
     ```
     проверьте, что получилось: `git remote -v`
 - Теперь, когда нужно для своего форка обновить, например, ветку `master`:
   - не забываем переключиться на эту ветку: `git checkout master`
   - стягиваем её с upstream локально: `git pull upstream master`
   - обновляем в своём форке на GitHub: `git push` (или `git push origin`)

Релизный процесс:
-----------------

**_Два типа релизов:_**

 - основной (новые фичи, наработки); **tag:** `2022.03`
 - хот-фиксовый патч;                **tag:** `2022.03.p1`

**_Процесс:_**

 - **основной релиз** собирается на ветке `dev`, т.е.:
    - ветка `dev` теперь является default'ной
    - все PR по умолчанию создаются в эту ветку
    - *нужно ветвиться от `dev` (хотя можно и от `master`'а)*
    - *поддерживать в актуальном состоянии ветку `dev`*
    - [авто-деплой на Полигон](.github/workflows/deploy-poligon.yml) идёт с ветки `dev` при любых изменениях в этой ветке
    - ветка `dev` автоматически обновляется из ветки `master` после релиза (любого -- основного или хотфиксового)
    - когда основной релиз готов (протестирован, готовы катить):
        - ветка `dev` мерджится в ветку `master`
        - добавляется bump-commit с changelog'ом (уже на ветке `master`)
        - ставится **tag** вида `YYYY.MM` (напр. `2022.03`)
        - [авто-деплой](.github/workflows/deploy-production.yml):
            - выкатывает это на боевой (с мастера)
            - мерджит `master` в `dev` (за счёт мерджа запускается перевыкатка на Полигон)


 - **хотфиксовый релиз** "собирается" на ветке `master`, т.е.:
    - ветка `master` отражает состояние сервера (практически всегда)
    - PR по баг-фиксам принимаются в ветку `master`
        - если при открытии PR забыли поменять с дефолтной ветки `dev` на ветку `master` -- не страшно, можно поменять позже или поменяет reviewer
    - деплой на боевой идёт с ветки `master` по тегу:
        - добавляется bump-commit с changelog'ом патча
        - ставится патч-**tag** вида `YYYY.MM.pN` (`2022.03.p1`)
        - [авто-деплой]((.github/workflows/deploy-production.yml)):
            - выкатывает это на боевой
            - мерджит `master` в `dev` (за счёт мерджа запускается выкатка на Полигон)


Дополнительные пакеты:
----------------------
 - python3
 - утилита dot, входит в graphviz
 - питон-модуль поддержки graphviz
   `python3 -m pip install graphviz`
