#!/bin/bash

rm build/asm/* >/dev/null 2>&1
rm build/c/* >/dev/null 2>&1
rm bin/* >/dev/null 2>&1
rm lib/* >/dev/null 2>&1

nasm -f elf64 -o build/asm/libprint.o -I src/asm src/lib/print.asm
lib_compile=$?

if [[ $lib_compile -ne 0 ]]; then
  exit 1
fi

nasm -f elf64 -o build/asm/libreadline.o -I src/asm src/lib/read_line.asm
lib_compile=$?

if [[ $lib_compile -ne 0 ]]; then
  exit 1
fi

ar rcs lib/libprint.a build/asm/libprint.o
lib_archiving=$?

if [[ $lib_archiving -ne 0 ]]; then
  exit 1
fi

ar rcs lib/libreadline.a build/asm/libreadline.o
lib_archiving=$?

if [[ $lib_archiving -ne 0 ]]; then
  exit 1
fi

gcc -o bin/main src/c/main.c -L lib -l print -l readline
linking=$?

if [[ $linking -ne 0 ]]; then
  exit 1
fi
