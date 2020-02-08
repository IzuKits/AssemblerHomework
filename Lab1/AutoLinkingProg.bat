
set name=Lab1

Ml -c -coff -Fl %name%.asm
pause

LINK32.EXE  /subsystem:console /debug /debugtype:cv %name%.obj

rem mkdir Result
rem move /-Y %name%.lst "%CD%\Result"
rem move /-Y %name%.exe "%CD%\Result"
rem move /-Y %name%.obj "%CD%\Result"
pause
if %1==debug  (
    start D:\StuffForProg\DebugForAsm\release\x96dbg.exe %name%.exe 
)
if %1==run  (
start %name%.exe
)
pause