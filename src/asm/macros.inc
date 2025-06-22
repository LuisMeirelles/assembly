%macro EXIT 1
  MOV rdi, %1
  MOV rax, 60 ; exit syscall
  SYSCALL
%endmacro

%macro SYS_WRITE 3
  MOV rax, 1 ; write syscall

  MOV rsi, %2 ; buffer
  MOV rdi, %1 ; file descriptor
  MOV rdx, %3 ; count

  SYSCALL
%endmacro

%macro SYS_READ 3
    MOV rax, 0 ; `read` syscall

    MOV rsi, %2 ; buffer
    MOV rdi, %1 ; file descriptor
    MOV rdx, %3 ; count

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
