
set name=Lab2

Ml -c -coff -Fl %name%.asm
pause

LINK32.EXE  /subsystem:console /debug /debugtype:cv %name%.obj

pause
if %1==debug  (
    start D:\StuffForProg\DebugForAsm\release\x96dbg.exe %name%.exe 
)
if %1==run  (
start %name%.exe
)
pause