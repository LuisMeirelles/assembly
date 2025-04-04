section .data
  string db "teste", 0xa, 0

%define string_len equ ($ - string)

section .text
  global _start

_start:
  MOV rax, 1
  MOV rdi, 1
  MOV rsi, string
  MOV rdx, 6
  SYSCALL

  MOV rax, 60
  MOV rdi, 0
  SYSCALL

