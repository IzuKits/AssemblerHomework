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


    ; �������� ������ ������
    ;����� ����� � ������
    ;���� �� �������� �����, ���� ������ � �������, ������� ���� �����. ������ ����� ������ �����
    ;����� ��������� �����, ��������� ������ � ��� ����� ���� � ���� ����� �����. 
    ;������ ���� ������ ��������� ����� ������ ���� ������, �� ������ �� ���������
    ;����� ���������� ����� ������ �������� ����� ������� ������ ����  � ������� ��������� �� �����
    lea esi, InputStr
    mov al, SizeOfStr
    cbw
    cwde
    mov ecx, eax
    cycle_1:
    lodsb;al=='������ ������ �� ������ esi'
    dec esi;esi �������� ����� �������� ���������������� �������
    lea edi, nums
    push ecx
    mov ecx, 10
    repne scasb;���������, ����� ��� ��� ���
    jne num_not_found;��� �� �����
    cmp num_count_temp, 0;��� ����� ����� �����?
    jne num_NOT_after_letter;��� �� ������ ����� � �������
    mov addr_nums_in_str_temp, esi;��� ����� ����� �����
    inc num_count_temp
    jmp go_next

    num_NOT_after_letter:
        inc num_count_temp
        jmp go_next

    num_not_found:;������ �� �����
        cmp num_count_temp, 0;����� ����� �����?
        jne num_after_letter;����� �� ����� �����
        jmp go_next
        num_after_letter:;����� ����� �����
            mov al, num_count_temp
            cmp al, num_count
            ja new_nums;������� ���� ����� ������� ������
            mov num_count_temp, 0
            jmp go_next
        new_nums:;����� ������� ���� ������
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