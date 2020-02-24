.386
.model flat, stdcall
include masm32.inc 
include kernel32.inc 
includelib masm32.lib
includelib kernel32.lib

.const
    erorStr db  'No any nums', 10, 13, 0
    enterStr db 'Enter line', 10, 13, 0
    exitStr db 'Press someting to exit', 10, 13, 0
    result_str  db  'The longest string of numbers:', 10, 13, 0
.data 
    InputStr db 128 dup(?)
    SizeOfStr db -1
    SizeOfStr_str   db  -1, 10, 13, 0
    nums    db  '0123456789'
    end_of_str  db  10,13,0

    num_count   db  0
    addr_nums_in_str    dd  0

    num_count_temp   db  0
    addr_nums_in_str_temp    dd  0

    longest_num_str  db  124 dup(?), 10, 13, 0
.code
    start:
    invoke StdOut, offset enterStr
    invoke StdIn, offset InputStr, 128
    
    lea eax, InputStr
    mov esi, 0
    mov ecx, 128
    mov bl, 13
    cycle1:
        mov dl, [eax+esi]
        inc esi
        cmp dl, bl
        loopne cycle1
    dec esi
    mov ax, si
    mov SizeOfStr, al
    add ax, 48
    mov SizeOfStr_str, al

    lea esi, InputStr
    mov al, SizeOfStr
    cbw
    cwde
    mov byte ptr [esi+eax], '*'
    inc SizeOfStr


    ; Получили размер строки
    ;Найти цифру в строке
    ;пока не встретим букву, идем дальше и считаем, сколько цифр нашли. Храним адрес первой цифры
    ;когда встретили букву, сохраняем данные о том блоке цифр и ищем цифры снова. 
    ;Однако если размер найденной ранее строки цифр больше, то ничего не сохраняем
    ;после достижения конца строки копируем самую длинную строку цифр  и выводим результат на экран
    lea esi, InputStr
    mov al, SizeOfStr
    cbw
    cwde
    mov ecx, eax
    cycle_1:
    lodsb;al=='символ строки по адресу esi'
    dec esi;esi содержит адрес текущего рассматриваемого символа
    lea edi, nums
    push ecx
    mov ecx, 10
    repne scasb;проверяем, цифра это или нет
    jne num_not_found;это не цифра
    cmp num_count_temp, 0;Это цифра после буквы?
    jne num_NOT_after_letter;это не первая цифра в цепочке
    mov addr_nums_in_str_temp, esi;Это цифра после буквы
    inc num_count_temp
    jmp go_next

    num_NOT_after_letter:
        inc num_count_temp
        jmp go_next

    num_not_found:;символ не цифра
        cmp num_count_temp, 0;Буква после буквы?
        jne num_after_letter;буква не после цифры
        jmp go_next
        num_after_letter:;Буква после цифры
            mov al, num_count_temp
            cmp al, num_count
            ja new_nums;Перейти если новая цепочка больше
            mov num_count_temp, 0
            jmp go_next
        new_nums:;новая цепочка цифр больше
            mov eax, addr_nums_in_str_temp
            mov addr_nums_in_str, eax
            mov al, num_count_temp
            mov num_count, al
            mov num_count_temp, 0

    go_next:
    inc esi
    pop ecx
    loop cycle_1
  
    

    cmp num_count, 0
    je no_nums
    mov al, num_count
    cbw
    cwde
    mov ecx, eax
    mov esi, addr_nums_in_str
    lea edi, longest_num_str
    rep movsb
    lea esi, end_of_str
    lea edi, longest_num_str
    add edi, eax
    mov ecx, 3
    rep movsb

    invoke StdOut, offset result_str
    invoke StdOut, offset longest_num_str
    jmp exit
    no_nums:
    invoke StdOut, offset erorStr
    exit:
    invoke StdOut, offset exitStr
    invoke StdIn, offset InputStr, 128
    invoke ExitProcess, 0
end start