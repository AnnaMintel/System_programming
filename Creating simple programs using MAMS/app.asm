.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

    WRITELN 'Hello, world!'
    WRITELN '����������, ���! ���� ����� ���!'

    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain