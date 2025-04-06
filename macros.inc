%macro EXIT 1
  MOV rax, 60 ; exit syscall
  MOV rdi, %1
  SYSCALL
%endmacro

%macro PRINT 1
  LEA rsi, [rel %1] ; loading relative address of string head to %rsi
  CALL println
%endmacro
