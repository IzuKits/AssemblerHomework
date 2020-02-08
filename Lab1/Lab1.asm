.386
.model flat, stdcall
include masm32.inc 
include kernel32.inc 
includelib masm32.lib
includelib kernel32.lib

.const
    enterStr db 'Enter line', 10, 13, 0
    exitStr db 'Press someting to exit', 10, 13, 0
.data 
    MyStr dw 50 dup(?)
    temp dd ?
    cym db '*', 10, 13, 0
.code
    start:
    invoke StdOut, offset enterStr
    invoke StdIn, offset MyStr, 50
    mov ECX, 0
    mov ECX, lstr
        cycle:
        invoke StdOut, offset cym
        loop cycle 
    invoke StdOut, offset temp
    invoke StdIn, offset MyStr, 50

    ;invoke StdOut, offset MyStr

    invoke StdOut, offset exitStr
    invoke StdIn, offset MyStr, 50
    invoke ExitProcess,0
end start