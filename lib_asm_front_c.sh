#!/bin/bash

nasm -f elf64 -o build/asm/libprint.o src/lib/print.asm
lib_compile=$?

if [[ $lib_compile -ne 0 ]]; then
  exit 1
fi

ar rcs lib/libprint.a build/asm/libprint.o
lib_archiving=$?

if [[ $lib_archiving -ne 0 ]]; then
  exit 1
fi

gcc -o bin/main src/c/main.c -L lib -l print
linking=$?

if [[ $linking -ne 0 ]]; then
  exit 1
fi
