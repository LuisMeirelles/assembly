%include "macros.inc"

section .data
  string db "testando", 0xa, 0

section .text
  global _start

_start:
  PRINT string
  EXIT 0

println:
  MOVZX eax, byte [rsi] ; moves zero-extended version of the byte that %rsi is pointing to
  TEST al, al
  JE .end_println

  MOV rax, 1 ; write syscall
  MOV rdi, 1 ; stdout
 
  MOV rdx, 1 ; chars count to be printed
  SYSCALL

  INC rsi
  JMP println

  .end_println: RET

