bits 32

global nr_caractere, numaram_aparitile, afisare

extern printf
import printf msvcrt.dll

segment data use32 class=data:
    afiseaza db "Litera %c a aparut de %d ori ", 10, 13, 0

segment code use32 class=code:
        
     nr_caractere:   
        ; determinam numarul de caractere
        ;input: eax     output: esi
        
        mov esi, 0
        bucla:
            cmp byte[eax + esi], 0
            je am_ajuns_la_final
            
            nu_am_ajuns_la_final:
                add esi, 1
                jmp bucla
        
        am_ajuns_la_final:
            
        ret
    
    numaram_aparitile:
        ; aflam de cate ori apare fiecare litera
        ;input: stiva  output: -
        ;input: buffer, len, len_litere, frecventa, litere
        
        mov ecx, [esp + 12] ; len_litere
            
        ; prelucram caracterele
            
        mov esi, 0; i = 0
        mov ebx, [esp + 20] ; litere
        mov edx, [esp + 16]; frecventa
        prelucram:
             mov edi, [esp + 4]; punem in edi bufferu ca s pregatim scasb
             push ecx
             mov ecx, [esp + 12]; len acum va fi esp + 12 din cauza acelui push
                
             mov al, [ebx + esi] ; al = litere[i]
             bucla1: ; bucla1 se va executa de len ori
                 scasb ; scanam
                 jne nu
                 da:
                    add byte[edx + esi * 4], 1
                    
                 nu:
                    
                 loop bucla1
                
             add esi, 1; i = i + 1
             pop ecx
             loop prelucram
             
        ret 4 * 5
        
    afisare:
        ; afisare
        ;input: regisrtrii EAX - litere, EBX - frecventa, ECX - len_litere;   output: -
        
        mov esi, 0
        repeta:
            cmp byte[ebx + esi * 4], 0    ;incearca si dword
            je nu_afisam
            
            push ecx; salvam ecx
            push eax; salvam eax
            push ebx; salvam ebx
            push dword[ebx + esi * 4]
            push dword[eax + esi]
            push dword afiseaza
            call [printf]
            add esp, 4 * 3
            pop ebx
            pop eax
            pop ecx; readucem ecx la valoare initiala
            
            nu_afisam:
                add esi,1
            
            loop repeta
            
        ret
 