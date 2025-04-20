%include "macros.inc"

section .bss
  buffer resb 1024 ; char buffer[1024];

section .text
  global _start
  default rel

extern read_line
extern print

_start:
  READ_LINE buffer

  PRINT buffer

  EXIT rax

section .note.GNU-stack

