.386
.MODEL flat, stdcall
option casemap:none
public CalcNumOfDays
public GetDayOfWeek

.const
    month_days  db 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 
    week_days   db  "Monday   ", "Tuesday  ", "Wednesday", "Thursday ", "Friday   ", "Saturday ", "Sunday   "

.data
    is_year_leap db ?
    num_days    dd  0
    num_leap_years  dw  0
.code

;В стеке - год(Значение!)
; вернет в поле is_year_leap 0 - год НЕ високосный, 1 - год високосный
;year%4==0&&year%100!=0||year%400==0
IsYearLeap proc near uses EAX EBX EDX, year:word
    mov AX, year
    cwd
    mov BX, 4
    div BX
    cmp DX, 0
    jne first_condition_false;year%4!=0 - NOT OK
    ;year%4==0
    mov AX, year
    cwd
    mov BX, 100
    div BX
    cmp DX, 0
    jne true ;year%100!=0 - OK
    first_condition_false:
        mov AX, year
        cwd
        mov BX, 400
        div BX
        cmp DX, 0
        je true ; OK
    false:
        mov is_year_leap, 0
        jmp finish
    true:
        mov is_year_leap, 1;
    finish:
ret
IsYearLeap endp


;Считает количество дней текущего года в указанной дате
;Сама увеличивает значение поля num_days
;параметр 1 -  адрес хранения даты, получает из регистра ESI
CalcMonthDays proc near uses EAX
    ;посчитать количество дней в соответствии с таблицей месяцев
    ;является ли год високосным
    ;по необходимости добавить день
    ;добавить дни текущего месяца
    movzx ECX, word ptr[ESI + 2];текущий месяц

    cmp ECX, 2
    jle not_add_day;текущий месяц - январь или февраль(в случает высокосности не прибавлять день)
    cmp is_year_leap, 1
    jne not_add_day; год не высокосный

    inc num_days
    not_add_day:
    sub ECX, 1;последний месяц не считается
    cmp ECX, 0
    push ESI
    je first_month

    lea ESI, month_days
    cycle:
        movzx EAX, byte ptr [ESI]
        add num_days, EAX
        inc ESI
    loop cycle
    first_month:
    pop ESI
    ;добавить дни
    movzx eax, word ptr [ESI]
    add num_days, EAX
    dec num_days;не считать текущий день

ret
CalcMonthDays endp




;В стеке(порядок PUSH!):
;1) адр поля, где хранится дата
;2) адр поля, куда будет записан результат
CalcNumOfDays proc near uses EAX ESI EDI EBX EDX
    push EBP
    mov EBP, ESP

    mov ESI, [EBP + 32] ;дата 
    mov EDI, [EBP + 28] ;результат
    ;Посчитать количество высокосных лет до указанного года НЕ ВКЛЮЧИТЕЛЬНО
    ;N - текущий год; N--
    ;количество высокосных лет  = N/4 - N/100 + N/400
    add ESI, 4
    
    irp i, <4, -100, 400>
        mov EAX, [ESI] 
        dec EAX; чтоб не учитывать текущий год
        cdq
        mov EBX, i
        idiv EBX
        add num_leap_years, AX ;
    endm
    mov AX, num_leap_years; диапазон года - до 9999, високосных лет не более 2424
    mov bx, 366
    mul bx
    shl EAX, 16
    shld EDX, EAX, 16
    mov num_days, EDX ;сумма дней в высокосных годах до указанной даты

    mov AX, [ESI] 
    dec AX
    sub AX, num_leap_years 
    mov BX, 365
    mul BX
    shl EAX, 16
    shld EDX, EAX, 16
    add num_days, EDX

    ;вызов процедуры CalcMonthDays
    invoke IsYearLeap, [ESI] ; высокосный текущий год или нет

    sub ESI, 4
    call CalcMonthDays
    ; сумма
    mov EAX, num_days
    mov [EDI], EAX


    mov ESP, EBP
    pop EBP
ret
CalcNumOfDays endp

;Вернет строковое представление дня недели, соответствующего указанной дате
;Аргумент 1 - адрес поля, содержащего дату, как 3dup dw
;Аргумент 2 - адрес поля для записи результата - 9 байт
GetDayOfWeek proc near uses EAX
push EBP
mov EBP, ESP

push [EBP + 16]
push offset num_days
mov EAX, num_days
cdq
mov EBX, 7
idiv EBX ;в edx -  номер дня недели, где 0 - понедельник

lea ESI, week_days; нужно сдвинуть на нужный день недели(каждое название - 9 символов)
mov al, dl
mov bl, 9
mul bl
cwde
add ESI, EAX


mov EDI, [EBP + 12]
mov ECX, 9
mov [EDI], EDX
rep movsb


mov ESP, EBP
pop EBP
ret
GetDayOfWeek endp
end