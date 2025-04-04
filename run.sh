#!/bin/bash

nasm -felf64 main.asm
ld -o main main.o

./main
