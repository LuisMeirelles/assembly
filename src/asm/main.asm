%include "macros.inc"

section .bss
  charbuf resb 1 ; char charbuf[1];

section .data
  string db "teste789", 0xa, 0 ; const char *string string = "teste\n"

section .text
  global _start
  default rel

extern print

_start:
  PRINT string ; size_t written = print(string)
  ADD eax, 48 ; written += 48
  MOV [charbuf], rax ; charbuf[0] += written
  PRINT charbuf ; print(charbuf)
 
  EXIT 0 ; return 0

section .note.GNU-stack

