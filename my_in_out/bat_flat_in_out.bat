ML.EXE /Zi /c /Fl /coff  flat_in_out.asm
pause

LINK32.EXE  /subsystem:console /debug /debugtype:cv flat_in_out.obj
pause
