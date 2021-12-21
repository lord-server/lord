### Переопределения для мода `minetest_game/wool`

- Вынесены текстуры шерсти 32x32
- Текстуры оптимизированы c уменьшением размера (примерно в два раза) при помощи [pngquant](https://github.com/kornelski/pngquant) (`pngquant --ext .png --strip --speed 1 --force --skip-if-larger --quality 60-85 *.png`)
- Лестницы и плиты из шерсти перенесены в [lord/lord_wool](../../../../lord/lord_wool)
