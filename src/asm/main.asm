%include "macros.inc"

section .bss
  buffer resb 1024 ; char buffer[1024];

section .text
  global _start
  default rel

extern print

_start:
  LEA rdi, [buffer] ; load relative address (due `default rel` in .text section) into %rsi

  .loop:
    MOV rax, 0 ; sys_read
    MOV rsi, rdi ; pass the address of buffer as a sys_read argument
    MOV rdi, 0 ; stdin file descriptor
    MOV rdx, 1 ; reads 1 byte

    SYSCALL

    MOV rdi, rsi ; recover pointer to buffer into %rdi
    MOVZX ebx, byte [rdi] ; get a byte in the %rdi position in memory

    CMP bl, 0xa
    JE .exit

    INC rdi

    JMP .loop

  .exit:
    PRINT buffer
    EXIT 0

section .note.GNU-stack

