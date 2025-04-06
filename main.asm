%macro EXIT 1
  MOV rax, 60 ; exit syscall
  MOV rdi, %1
  SYSCALL
%endmacro

%macro PRINT 1
  LEA rsi, [rel %1] ; loading relative address of string head to %rsi
  CALL println
%endmacro

section .data
  string db "testando", 0xa, 0

section .text
  global _start

_start:
  PRINT string
  EXIT 0

println:
  MOVZX eax, byte [rsi] ; moves zero-extended version of the byte that %rsi is pointing to
  CMP al, 0
  JE end_println

  MOV rax, 1 ; write syscall
  MOV rdi, 1 ; stdout
 
  MOV rdx, 1 ; chars count to be printed
  SYSCALL

  INC rsi
  JMP println

  end_println: RET

