%include "../asm/macros.inc"

section .text
  global read_line
  default rel

; function read_line(char *buffer)
read_line:
  XOR rcx, rcx ; size_t count = 0

  .loop: ; while (1)
    MOV rbx, rcx ; moving %rcx since is not preserved

    ; size_t nread = read(0, &buffer, 1)
    SYS_READ 0, rdi, 1

    MOV rcx, rbx ; recover counter after syscall
    MOV rdi, rsi ; recover pointer to buffer into %rdi

    ADD rcx, rax ; count += nread

    MOVZX ebx, byte [rdi] ; char character = *string

    CMP bl, 0xa ; if (character == '\n')
    JE .exit ; break

    INC rdi ; string++

    JMP .loop

  .exit:
    MOV rax, rcx ; size_t value = count
    RET ; return value

section .note.GNU-stack

