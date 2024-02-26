section .data

cmsg db 10, "Enter 5 digit BCD Number :-"
    cmsg_len equ $-cmsg
    lhmsg db 10, "This is the Equivalent Hex Number :-",10
    lhmsg_len equ $-lhmsg

section .bss

buf resb 6
    char_ans resb 4
    ans resw 1



%macro Print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro read 2
    mov rax,0
    mov rdi,0
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro exit 0
     
    mov rax, 60
    xor rdi, rdi
    syscall
%endmacro

section .text
global _start

_start:

BCD_HEX:
    Print cmsg, cmsg_len
    read buf, 6
    mov rsi, buf
    xor ax, ax
    mov rbp, 5
    mov rbx, 10
next: 
    xor cx, cx
    mul bx
    mov cl, [rsi]
    sub cl, 30h
    add ax, cx
    inc rsi
    dec rbp
    jnz next
    mov [ans], ax
    Print lhmsg, lhmsg_len
    mov ax, [ans]
    call Disp_16
    jmp exit
    
     
  
   Disp_16:
    mov rsi, char_ans+3
    mov rcx, 4
    mov rbx, 16
next_digit:
    xor rdx, rdx
    div rbx
    cmp dl, 9
    jbe add30
    add dl, 07H
add30:
    add dl, 30H
    mov [rsi], dl
    dec rsi
    dec rcx
    jnz next_digit
    Print char_ans, 4
    ret

    




