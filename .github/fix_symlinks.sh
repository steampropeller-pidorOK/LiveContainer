#!/bin/bash
# Windows/git (core.symlinks=false) превращает симлинки в маленькие текстовые файлы.
# Здесь восстанавливаем их внутри OpenSSL.
set -e
cd "$(dirname "$0")/../OpenSSL"
for pass in 1 2 3; do
find . -type f -size -100c ! -name "*.modulemap" ! -name "*.plist" ! -name "*.xcprivacy" | while read -r f; do
  target=$(cat "$f")
  dir=$(dirname "$f")
  # симлинк-кандидат: одна строка без пробелов, и цель существует
  if [[ "$target" =~ ^[A-Za-z0-9_./-]+$ ]] && [ -e "$dir/$target" ]; then
    echo "symlink: $f -> $target"
    rm "$f"
    ln -s "$target" "$f"
  fi
done
done
