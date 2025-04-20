%macro EXIT 1
  MOV rdi, %1
  MOV rax, 60 ; exit syscall
  SYSCALL
%endmacro

%macro PRINT 1
  LEA rdi, [rel %1] ; loading relative address of string head to %rdi
  CALL print
%endmacro

%macro READ_LINE 1
  LEA rdi, [rel %1]
  CALL read_line
%endmacro
