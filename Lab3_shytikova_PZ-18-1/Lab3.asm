.386
.model flat, stdcall
.xlist
include masm32.inc 
include kernel32.inc 
includelib masm32.lib
includelib kernel32.lib

public Num_str, Num_Value, end_of_str
extrn NumToStr@0:near
extrn GetNumData@0:near
extrn CalcNumOfDays@0:near
GetDayOfWeek proto

option casemap:none

.list
;Шитикова Елизавета, ПЗ-18-1


;Считая, что все даты даются по григорианскому календарю (“новому
;стилю”), описать: 1) функцию, подсчитывающую, сколько дней прошло от 1-го
;января 1-го года нашей эры до некоторой даты; 2) функцию определения дня
;недели, на который приходится заданная дата (1 января 1 –го года н.э. было
;понедельником). Использовать эти функции для определения дня недели по
;заданной дате.
;/* year%4==0&&year%100!=0||year%400==0 */

;Дата должна вводиться в форме ДД.ММ.ГГГГ  - с обязательно именно таким количеством символов
; (то есть от 0001 до 9999 года)

.const
    start_text  db  "Enter date as DD.MM.YYYY:", 10, 13, 0
    exitStr db 'Press someting to exit', 10, 13, 0
    str1    db  'Number of days:', 10, 13, 0
    str2    db  'Day of the week:', 10, 13, 0
.data
    Num_str   db  15 dup ('?');Хранение числа как строки, используется  NumToStr
    Num_Value   dd  2
    end_of_str  db  10, 13, 0


    inputStr    db  128 dup(?)
    inputDate   dw  3 dup(?)
    num_of_days dd  ?

    temp_str    db  9 dup (?), 10, 13, 0
.code

main proc far
    invoke StdOut, offset start_text
    invoke StdIn, offset inputStr, 128
    push offset inputStr
    push offset inputDate
    call GetNumData@0

    push offset inputDate
    push offset num_of_days
    call CalcNumOfDays@0

    mov eax, num_of_days
    mov Num_Value, eax 
    call NumToStr@0

    invoke StdOut, offset str1

    lea eax, Num_str
    invoke StdOut, eax

    push offset inputDate
    push offset temp_str
    call GetDayOfWeek

    invoke StdOut, offset str2

    invoke StdOut, offset temp_str

    invoke StdOut, offset exitStr
    invoke StdIn, offset inputStr, 128 
    ret
main endp
end main
