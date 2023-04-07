#!/bin/bash

if [ -z $1 ] ; then
  echo "Не задана директория откуда копировать"
  exit 1
fi

if [ -z $2 ] ; then
  echo "Не задана директория куда копировать"
  exit 1
fi

# цикл по всем файлам в директории
for file in $1/* ; do
  # получаем имя владельца файла
  owner=$(ls -la $file | awk ' { print $3 } ')
  # получаем имя самого фала
  filename=$(ls -la $file | awk ' { print $9 } ')

  # проверяем наличие директории с именем владельца файла и если такой нет, то пытаемся создать
  if [ ! -d $2/$owner ] ; then
    mkdir $2/$owner
    if [ $? -ne 0 ] ; then
      echo "Не удалось создать директорию $2/$owner"
      # вываливаемся как аварийноре завершение
      exit 1
    fi
  fi

  # иначе пытаемся скопировать файл
  echo "Копируем \"$filename\" в \"$2/$owner\""
  cp $filename $2/$owner
  if [ $? -ne 0 ] ; then
    echo "Ошибка копирования"
  fi
done
