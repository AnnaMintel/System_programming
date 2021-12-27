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
    WRITELN 'Çהנאגסעגףי, לטנ! ÌÅÍ‗ ÇÎÂÓÒ ÀÍ‗!'

    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain