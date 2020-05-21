.386
.model flat, stdcall
include masm32.inc 
include kernel32.inc 
includelib masm32.lib
includelib kernel32.lib

;Условие, вариант 17:
;Задано число x 0 и функции f(x), g(x), h(x). Пусть
;x1 = f(x0)     x2 = f(x1)      x3 = g(x2)      x4 = h(x3)
;x5 = g(x4)     x6 = g(x5)      x7 = h(x6)      x8 = f(x7)
;x9 = h(x8)     x10 = h(x9)     x11 = h(x10)    x12 = h(x11)
;x13 = g(x12)   x14 = f(x13)    x15 = f(x14)    x16 = h(x15)
;Требуется вычислить 16x при f(x) = 3x - 5, g(x) = 3x + 12, h(x) = 3x
;Вычисление функций оформить в виде макроопределения с параметром-
;константой. Если аргумент отсутствует, то команду сложения не генерировать.
;Выбор функции организовать с помощью логической шкалы.


;Результаты для тестов:
; x = 1; res = -30678972
; х = 0; res =  -73725693
; x = 2; res =  12367749
; x = 9; res = 313694796
; x = -9; res = -461146182
; x = -1; res = -116772414
;Числа в процессе вычисления не должны выходить за пределы двойного слова

;Макрос получает число num и записывает в поле Num_str его строковое представление
NumToStr MACRO num ;поле должно быть размером двойное слово
    local positive
    local myEnd
    local cycle2
    local pos
    mov edi, offset Num_str 
    mov ebx, num
    mov ecx, 15
    cmp num, 0
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
        cmp num, 0      ;был ли знак "-" в начале строки числа
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
ENDM
;3x - 5
;3x + 12
;3x
Func MACRO arg:=<0> ;Аргумент должен быть байтом\константой
    push eax
    push ebx
    push edx
    mov eax, ValueX  ;;Значение Х для вычислений берется из поля ValueX и туда же записывается результат
    mov ebx, 3
    imul ebx     ;;x*3
    IF arg NE 0;;если аргумент не 0, значит сложение нужно, и макрорасширение будет генерироваться
        ;;ПРОБЛЕМА 2
        push arg
        movsx ebx, byte ptr [esp]
        add esp, 4
        add eax, ebx  ;;x*3 + n
    ENDIF
    mov ValueX, eax
    pop edx
    pop ebx
    pop eax
ENDM
.const
    exitStr db 'Press someting to exit', 10, 13, 0
    infoStr db  'zero X:', 10, 13, 0
    infoResult  db  'Result', 10, 13, 0
    inputInfo   db  'Enter num (-9 to 9)'
.data 
    FuncLogicScale  dd  00000110010110001010101001000010b       ;логическая шкала хранит порядок выолнение функций
                                                                ; функции 00, 01, 10
    temp db 5 dup (?)
    ValueX   dd  2      ; Значение Х, используется в макросе функций 
    Num_str   db  15 dup ('?');Хранение числа как строки, используется макросом NumToStr
    end_of_str  db  10, 13, 0
.code
    start:

    invoke StdOut, offset inputInfo

    invoke StdIn, offset temp, 5
    ;ПРОБЛЕМА 1
    cmp temp, '-' ;если введено отрицательное число
    jne pos
    mov al, temp + 1
    sub al, 48
    neg al
    jmp go
    pos:
    mov al, temp
    sub al, 48
    go:
    cbw
    cwde
    mov ValueX, eax


    invoke StdOut, offset infoStr
    NumToStr ValueX
    invoke StdOut, offset Num_str
    invoke StdOut, offset infoResult
    mov ecx, 16
    mov     eax, FuncLogicScale
    ;ПРОБЛЕМА 3
    cycle:
        xor     ebx, ebx
        shld    ebx, eax, 2        ;сдвинуть старшие 2 бита шкалы в ebx
        shl     eax, 2              ;сдвинуть шкалу на 2 бита влево для доступа к следующим
        cmp     bl, 00b             ;если 00 - 1я функция, и так далее
        je func1
        cmp     bl, 01b
        je  func2
        cmp     bl, 10b
        je  func3
        func1:
            Func <-5>
            jmp endfuncs
        func2:
            Func <12>
            jmp endfuncs
        func3:
            Func
endfuncs:
    loop cycle

    NumToStr ValueX
    invoke StdOut, offset Num_str

    invoke StdOut, offset exitStr
    invoke StdIn, offset Num_str, 128

end start