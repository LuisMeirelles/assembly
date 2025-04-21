#!/bin/bash

nasm -f elf64 -o build/asm/libprint.o -I src/asm src/lib/print.asm
lib_compile=$?

if [[ $lib_compile -ne 0 ]]; then
  exit 1
fi

nasm -f elf64 -o build/asm/libread_line.o src/lib/read_line.asm
lib_compile=$?

if [[ $lib_compile -ne 0 ]]; then
  exit 1
fi

nasm -f elf64 -o build/asm/main.o -I src/asm src/asm/main.asm
main_compile=$?

if [[ $main_compile -ne 0 ]]; then
  exit 1
fi

gcc -nostartfiles -o bin/main build/asm/*.o
linking=$?

if [[ $linking -ne 0 ]]; then
  exit 1
fi
