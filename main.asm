bits 32

global start

extern nr_caractere, numaram_aparitile, afisare
extern exit, gets, printf
import printf msvcrt.dll
import exit msvcrt.dll
import gets msvcrt.dll

segment data use32 class=data:
    buffer resb 100
    citeste db "Introduceti propozitia: ", 0
    format db "%s", 0
    afiseaza db "Litera %c a aparut de %d ori ", 10, 13, 0
    len dd 0
    litere db "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    len_litere equ 52
    frecventa times len_litere dd 0
    
segment code use32 class=code:
    start:
        push dword citeste
        call [printf]
        add esp, 4
        
        push dword buffer
        call [gets]
        add esp, 4
        
        ;determinam numarul de caractere
        
        mov eax, buffer
        call nr_caractere
        mov [len], esi
        
        ; aflam numarul de aparitii a fiecarei litere
                
        push dword litere
        push dword frecventa
        push dword len_litere
        push dword [len]
        push dword buffer
        call numaram_aparitile
               
        ; afisare
        
        mov eax, litere
        mov ebx, frecventa
        mov ecx, len_litere
        call afisare
        
        
        push dword 0
        call [exit]