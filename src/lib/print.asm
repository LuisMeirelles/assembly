section .text
  global print
  default rel

; public int print(const char *string)
print:
  XOR rcx, rcx ; size_t count = 0

  .loop: ; while (1)
    MOVZX ebx, byte [rdi] ; char character = *string

    CMP bl, 0 ; if (character == '\0')
    JE .end_print ; break

    MOV rbx, rcx ; moving ecx since ebx is not preserved in sys_write

    ; size_t written = write(1, &string, 1)
    MOV rsi, rdi
    MOV rax, 1 ; `write` syscall
    MOV rdi, 1 ; stdout
 
    MOV rdx, 1 ; chars count to be printed
    SYSCALL

    MOV rcx, rbx ; recovering ecx after syscall

    ADD rcx, rax ; count += written

    ; string++
    MOV rdi, rsi
    INC rdi

    JMP .loop

  .end_print:
    MOV rax, rcx ; size_t value = count
    RET ; return value

section .note.GNU-stack

