section .data
  string db "testando", 0xa, 0

section .text
  global _start

println:
  MOVZX eax, byte [rsi] ; moves zero-extended version of the byte that %rsi is pointing to
  CMP al, 0
  JE return

  MOV rax, 1 ; write syscall
  MOV rdi, 1 ; stdout
  
  ; uses rsi as parameter here, so code below is not needed
  ; MOV rsi, string
  
  MOV rdx, 1 ; chars count to be printed
  SYSCALL

  INC rsi
  JMP println

  return: RET

_start:
  LEA rsi, [rel string] ; loading relative address of string head to %rsi
  CALL println

  MOV rax, 60 ; exit syscall
  MOV rdi, 0 ; exit code
  SYSCALL

