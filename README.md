# Showcase

### Autocomplete and linting
![autocomplete-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/gifs/errorsautocomplete.gif)
### Rename symbols
![rename-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/gifs/rename.gif)
### Go to definition
![goto-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/gifs/godefinition.gif)
### Show all references to symbol
![goref-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/gifs/goreference.gif)
### Auto-format on write
![autoformat-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/gifs/clangformat.gif)


## Мотивация
* Clion работает нестабильно и медленно, активно кушает батарейку
* Разработка идёт в контейнере, независимо от хост-системы
* Vim имеет широчайшие возможности для кастомизации
* Vim -- *свободное* программное обеспечение

## Основные возможности:
* Перемещение с помощью `gd` (defenition), `gr` (refereces), `gi` (implementation)
* Автодополнение. Выбор с помощью `Tab`, `Shift-Tab`, `Enter`
* Диагностика кода, ашипки
* Автоформатирование по clang-format при записи `:w`
* Переименование символов (функций, классов, переменных) с помощью `\` + `r` + `n`
* Иерархия файлов и перемещение по ним с помощью `\` + `n`
* Отображение изменённых по сравнению с последним коммитом строк
* And more! Check config files and `:help`


# Установка
Логин от имени рута через скрипт `docker/client/bin/root`

Внутри контейнера обновить софт
```
# apt update && apt upgrade
```

**Optional:** подключить тестовый репозиторий для получения последних версий.
```
# apt install software-properties-common
# add-apt-repository ppa:neovim-ppa/unstable
```
\
Устанавливаем софт:
* __curl__ -- для загрузки конфигов
* __npm, yarn__ -- как зависимости [Coc](https://github.com/neoclide/coc.nvim)
* [__ccls__](https://github.com/MaskRay/ccls) -- сервер *language server protocol* для умного автодополнения, перехода по символам и прочего взамодействия с кодом.
```
# apt install neovim curl npm ccls
# npm install -g yarn
```

---

\
Дальнейшие действия выполнять от имени юзера, через скрипт `login`
## Конфиг
#### Минимальная конфигурация
Для работы автодополнения, линтера, подсветки, форматирования. На случай, если вы хотите интегрировать изменения в свой `.vimrc`  -- [**init.basic.vim**](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/init.basic.vim)

#### Моя конфигурация
Если вы не попадаете под предыдущий случай. На выходе получаем полностью рабочее окружение.
**Осторожно:** файл `init.vim` будет перезаписан.
```
$ curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/otakubeam/concur-nvim/master/init.default.vim
```

---

Линкуем вывод cmake (clippy cmake) для работы ccls
```
$ cd /workspace/concurrency-course
$ ln -s build/Debug/compile_commands.json ./compile_commands.json
```
Теперь всё должно работать.

---


Для новых проектов нужно:
1) добавить строчку `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)` в cmake-файле
2) сгенерировать make-файлы
3) слинковать файл `compile_commands.json` из build-директории с аналогичным файлом в корне проекта

### Пример: репозиторий [tinyfibers](https://gitlab.com/Lipovsky/tinyfibers)
Из контейнера:
```
$ cd /workspace
$ git clone https://gitlab.com/Lipovsky/tinyfibers.git
```
Затем в файле `tinyfibers/cmake/CompileOptions.cmake` добавим строчку `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)` и сгенерируем make-файлы:
```
$ cd /workspace/tinyfibers && cmake .
```
Теперь в `/workspace/tinyfibers` лежит файл `compile_commands.json`.
В общем случае он может находиться в другом месте. Тогда его нужно найти и слинковать:
```
$ ln -s project/build-dir/compile_commands.json /project/compile_commands.json
```
