%include "macros.inc"

section .data
  string db "teste", 0xa, 0

section .text
  global _start

_start:
  PRINT string
  EXIT 0

print:
  MOVZX eax, byte [rdi] ; moves zero-extended version of the byte that %rdi is pointing to
  CMP al, 0
  JE .end_println

  MOV rsi, rdi
  MOV rax, 1 ; write syscall
  MOV rdi, 1 ; stdout
 
  MOV rdx, 1 ; chars count to be printed
  SYSCALL

  INC rsi

  ; pass the pointer to the next char to print()
  MOV rdi, rsi
  JMP print

  .end_println: RET

