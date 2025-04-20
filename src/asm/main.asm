%include "macros.inc"

section .bss
  buffer resb 1024 ; char buffer[1024];

section .text
  global _start
  default rel

extern print

_start:
  MOV rax, 0 ; sys_read
  MOV rdi, 0 ; stdin file descriptor
  LEA rsi, [buffer] ; load relative address (due `default rel` in .text section) into %rsi
  MOV rdx, 1024 ; read up to 1024 bytes

  SYSCALL

  PRINT buffer
 
  EXIT 0

section .note.GNU-stack

