.386
.MODEL flat, stdcall

extern Num_str:byte, Num_Value:dword, end_of_str:byte
public NumToStr
option casemap:none

.data
.code

;параметры - через внешние имена: Num_str, end_of_str, Num_Value
NumToStr proc near  ; взято из лабораторной работы 2; 
    push EBP
    mov EBP, ESP
    pushad
    
    mov edi, offset Num_str 
    mov ebx, Num_Value
    mov ecx, 15
    cmp Num_Value, 0
    jge positive ;если число отрицательное, первым в строку запишется "-"
        mov al, "-"
        stosb
        neg ebx
    positive:
        xor edx, edx
        mov eax, ebx

        mov ebx, 10
        div ebx    ;Деление на 10
        add edx, 48  ;К остатку прибавить 48, остаток точно меньше 10
        mov ebx, eax  ;Сохрaнить целую часть
        mov ax, dx
        push ax     ;Соханить цифру в стек
        cmp bx, 0   ;Если целая часть - 0, выйти из цикла
        loopnz positive
    myEnd:
        mov eax, 15
        sub eax, ecx ; сколько цифр было получено
        cmp Num_Value, 0      ;был ли знак "-" в начале строки числа
        jge pos
        inc eax
        pos:
        mov ecx, eax
        mov edx, eax; Нужно сохранить колличество цифр 
        cycle2:
            pop ax
            stosb
        loop cycle2
        mov esi, offset end_of_str ;Добавить символы окончания строки
        mov edi, offset Num_str
        add edi, edx
        mov ecx, 3
        rep movsw
        popad
        mov ESP, EBP
        pop EBP
        ret 
    NumToStr endp
end