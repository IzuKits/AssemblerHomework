.386
.MODEL flat, stdcall
option casemap:none
public GetNumData

.data
.code
;получение из строки с датой -  массив чисел
;в стекe: 1) адрес строки с датой db
;2) адрес переменной для записи результата dw
GetNumData proc near uses ECX ESI EDI EAX EBX ECX
    push EBP
    mov EBP, ESP
    mov ESI, [EBP + 36] ;строка с датой 
    mov EDI, [EBP + 32] ; сюда записывается результат

    irp i, <2, 2, 4>
        rept i
            xor ax, ax
            lodsb
            sub ax, 30h
            push ax ;запись прочитанной цифры
        endm
        xor cx, cx; тут накапливается число
        mov bx, 1;тут накапливаются десятки
        rept i
            pop ax
            mul bx; умножение на накопленные десятки.
            add cx, ax; предполагается, что число не выйдет за пределы слова
            mov ax, bx
            mov bx, 10
            mul bx
            mov bx, ax
        endm 
        mov [EDI], cx
        add EDI, 2
        inc ESI ; Пропуск разделителя
    endm

    mov ESP, EBP
    pop EBP
    ret 
GetNumData endp
end