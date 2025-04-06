%include "macros.inc"

section .bss
  charbuf resb 1

section .data
  string db "teste789", 0xa, 0 ; const char *string string = "teste\n"

section .text
  global _start

_start:
  PRINT string ; size_t written = print(string)
  ADD eax, 48 ; written += 48
  MOV [charbuf], rax ; char len = written
  PRINT charbuf ; print(written)
  
  EXIT 0 ; return 0

; public int print(const char *string)
print:
  XOR ecx, ecx ; size_t count = 0

  .loop: ; while (*string != '\0')
    MOVZX ebx, byte [rdi] ; char character = *string

    ; stop condition
    CMP bl, 0
    JE .end_print

    MOV ebx, ecx ; moving ecx since ebx is not preserved in sys_write

    ; size_t written = write(1, &string, 1)
    MOV rsi, rdi
    MOV rax, 1 ; `write` syscall
    MOV rdi, 1 ; stdout
  
    MOV rdx, 1 ; chars count to be printed
    SYSCALL

    MOV ecx, ebx ; recovering ecx after syscall

    ADD ecx, eax ; count += written

    ; string++
    MOV rdi, rsi
    INC rdi

    JMP .loop

  .end_print:
    MOV eax, ecx ; size_t value = count
    RET ; return value

