# Showcase

### Autocomplete test
![autocomplete-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/autocomplete.gif)
### Rename test
![rename-example](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/rename.gif)

## Мотивация
* Clion работает нестабильно и медленно, активно кушает батарейку
* Разработка идёт в контейнере, независимо от хост-системы
* vim имеет широчайшие возможности для кастомизации
* vim --- *свободное* программное обеспечение

## Основные возможности:
 * Перемещение с помощью `gd` (defenition), `gr` (refereces), `gi` (implementation)
 * Автодополнение. Выбор с помощью `Tab`, `Shift-Tab`, `Enter`
 * Диагностика кода, ашипки
 * Автоформатирование по clang-format при записи `:w`
 * Переименование символов (функций, классов, переменных) с помощью `\` + `r` + `n`
 * Иерархия файлов и перемещение по ним с помощью `\` + `n`
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
Для работы автодополнения, линтера, подсветки, форматирования. На случай, если вы хотите интегрировать изменения в свой .vimrc  --- [**init.basic.vim**](https://raw.githubusercontent.com/otakubeam/concur-nvim/master/init.basic.vim)

#### Моя конфигурация
Осторожно: файл `init.vim` будет перезаписан
```
$ curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/otakubeam/concur-nvim/master/init.default.vim
```

----------------

Линкуем вывод cmake (clippy cmake) для работы ccls
```
$ cd /workspace/concurrency-course
$ ln -s build/Debug/compile_commands.json ./compile_commands.json
```
Теперь всё должно работать.

---
