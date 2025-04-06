section .data
  string db "teste", 0xa, 0
  string_len db 6

section .text
  global _start

println:
  MOV rax, 1
  MOV rdi, 1
  ; we can use rsi as parameter here, so code below is not needed
  ; MOV rsi, string
  MOV rdx, [string_len]
  SYSCALL
  RET

_start:
  MOV rsi, string
  CALL println

  MOV rax, 60
  MOV rdi, 0
  SYSCALL

