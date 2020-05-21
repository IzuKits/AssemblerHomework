    .386
    .model flat, stdcall
    option casemap :none
    include masm32.inc
    include kernel32.inc
    includelib masm32.lib
    includelib kernel32.lib
    .const
	MsgExit db 13,10, 'Press Enter for exit',10,13,0
	MsgIntr db 10,13, 'Hellow',10,13,0
    .data 
	b dw -6
	d dw 11
	x dw ?
	fx dw 0 ; старшее слово результата
	zapros db 10,13,'Input a = ',0
	adr_zapros dd zapros
	result db 'Result = '
	res_str db 16 dup(' '),0

;     .data?
	a dw ?
	fa dw ? ; старшее слово переменной а
	buffer db 10 dup(?)
	inbuf db 100 dup(?)
	adr_inbuf dd inbuf
    .code
    start:
	invoke StdOut, offset MsgIntr
;	invoke StdOut, addr zapros
	invoke StdOut, adr_zapros

	invoke StdIn, addr buffer, lengthof buffer
	invoke StripLF, addr buffer

	invoke atol, addr buffer
	mov dword ptr a, eax

	mov cx,d
	add cx,8 ; cx = d+8
	mov bx,b
	dec bx	 ; bx = b-1
	mov ax,a
	add ax,d ; ax = a+d
	imul bx  ; dx:ax = (a+d)*(b-1)
	idiv cx
	cwd 
	mov x,ax
	mov fx,dx

	invoke dwtoa, dword ptr x, addr res_str

	invoke StdOut, addr result
	invoke StdOut, addr res_str

	xor eax,eax
	invoke StdOut, addr MsgExit
	invoke StdIn, addr inbuf, 100

	invoke ExitProcess,0
    end start

