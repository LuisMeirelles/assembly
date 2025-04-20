section .text
  global read_line
  default rel

read_line:
  XOR rcx, rcx

  .loop:
    MOV rax, 0 ; sys_read
    MOV rsi, rdi ; pass the address of buffer as a sys_read argument
    MOV rdi, 0 ; stdin file descriptor
    MOV rdx, 1 ; reads 1 byte

    SYSCALL

    MOV rdi, rsi ; recover pointer to buffer into %rdi
    MOVZX ebx, byte [rdi] ; get a byte in the %rdi position in memory

    CMP bl, 0xa
    JE .exit

    INC rdi

    JMP .loop

  .exit:
    MOV rax, 0
    RET

section .note.GNU-stack

