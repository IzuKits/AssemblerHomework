
set name=Lab3

Ml  /c  /coff %name%.asm
Ml  /c  /coff Num_in_text.asm
Ml  /c  /coff GetNumData.asm
Ml  /c  /coff CalcNumOfDays.asm



pause

LINK32.EXE  /subsystem:console /debug /debugtype:cv  %name%.obj Num_in_text.obj GetNumData.obj CalcNumOfDays.obj

pause
if %1==debug  (
    start D:\StuffForProg\DebugForAsm\release\x96dbg.exe %name%.exe 
)
if %1==run  (
start %name%.exe
)
pause