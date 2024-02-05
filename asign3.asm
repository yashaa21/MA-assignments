section .data

 msg db 10," +ve and -ve elements",10
msg_len equ $-msg

arr64 dq -111H,222H,333H,444H,555H
n  equ 5

pmsg db 10,"No. of positive elemnts :"
pmsg_len equ $-pmsg
nmsg db 10,"No. of negative elemnts :"
nmsg_len equ $-nmsg

section .bss

p_count resq 1
n_count resq 1
char_ans resb 2

%macro Print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
_start:

Print msg,msg_len
mov rsi,arr64
mov rcx,n
mov rbx,0
mov rdx,0

next_num:
mov rax,[rsi]
Rol rax,1
jc negative

positive:
inc rbx
jmp next

negative:
inc rdx 

next:
add rsi,8
dec rcx
jnz next_num

mov [p_count],rbx
mov [n_count],rdx
    
    Print pmsg,pmsg_len
    mov rax,[p_count]
    call disp64_proc
    
    Print nmsg,nmsg_len
    mov rax,[n_count]
    call disp64_proc
    
    
    Exit
    
    disp64_proc :
    mov rbx,16
    mov rcx,2
    mov rsi,char_ans+1
    
    cnt:
    mov rdx,0
    div rbx
    cmp dl,09h
    jbe add30
    add dl,07h
    
    add30:
    add dl,30h
    mov [rsi],dl
    dec rsi
    dec rcx
    jnz cnt
    Print char_ans,2
    ret
    
    


