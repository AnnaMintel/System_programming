FALSE					=0
TRUE					=1

SW_SHOW				=5

ERROR_INVALID_HANDLE		=6

WM_COMMAND		=0111h
WM_MOVE				=0003h
WM_DESTROY		=0002h
WM_CLOSE			=0010h
WM_SETTEXT		=000ch
WM_USER				=0400h

CB_ADDSTRING	=0143h
CB_GETCURSEL	=0147h
CB_SETCURSEL	=014eh
CB_ERR				=0ffffffffh
CB_RESETCONTENT=014bh

CBN_SELCHANGE	=1

BN_CLICKED		=0

SWP_NOSIZE		=0001h
SWP_NOMOVE		=0002h
SWP_NOZORDER	=0004h

SM_CXSCREEN		=0
SM_CYSCREEN		=1

MB_OK						=0
MB_ICONERROR		=10h

STD_INPUT_HANDLE                     equ -10
STD_OUTPUT_HANDLE                    equ -11
STD_ERROR_HANDLE                     equ -12

IDC_ARROW				=32512
COLOR_WINDOW    =5
HWND_BROADCAST	=0ffffh

GENERIC_READ						=80000000h
GENERIC_WRITE						=40000000h
OPEN_EXISTING						=3
CREATE_ALWAYS						=2
FILE_ATTRIBUTE_NORMAL		=00000080h
INVALID_HANDLE_VALUE		=0ffffffffh
GMEM_FIXED							=0h

EWX_REBOOT			=2
EWX_FORCE				=4

GetModuleHandleA			PROTO :DWORD
LoadIconA							PROTO :DWORD,:DWORD
ExitProcess						PROTO :DWORD
LoadCursorA						PROTO :DWORD,:DWORD
RegisterClassExA			PROTO :DWORD
MessageBoxA						PROTO :DWORD,:DWORD,:DWORD,:DWORD
CreateDialogParamA		PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetLastError					PROTO
GetCurrentProcess			PROTO
ShowWindow						PROTO :DWORD,:DWORD
TranslateMessage			PROTO :DWORD
DispatchMessageA			PROTO :DWORD
GetMessageA						PROTO :DWORD,:DWORD,:DWORD,:DWORD
DefWindowProcA				PROTO :DWORD,:DWORD,:DWORD,:DWORD
PostQuitMessage				PROTO :DWORD
DestroyWindow					PROTO :DWORD
RegisterWindowMessageA	PROTO :DWORD
SendMessageA					PROTO :DWORD,:DWORD,:DWORD,:DWORD
PostMessageA					PROTO :DWORD,:DWORD,:DWORD,:DWORD
SetForegroundWindow		PROTO :DWORD
CreateFileA						PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CloseHandle						PROTO :DWORD
ReadFile							PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
WriteFile							PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetSystemMetrics			PROTO :DWORD
SetWindowPos					PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetWindowRect					PROTO :DWORD,:DWORD
GetDlgItem						PROTO :DWORD,:DWORD
GetFileSize						PROTO :DWORD,:DWORD
GlobalAlloc						PROTO :DWORD,:DWORD
GlobalFree						PROTO :DWORD
RasHangUpA						PROTO :DWORD
Sleep									PROTO :DWORD
CreateThread					PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
EnableWindow					PROTO :DWORD,:DWORD
lstrcpy								PROTO :DWORD,:DWORD
lstrcat								PROTO :DWORD,:DWORD
RasDialA							PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
RasGetConnectStatusA	PROTO :DWORD,:DWORD
ExitWindowsEx					PROTO :DWORD,:DWORD


NULL=0
DLGWINDOWEXTRA=30

@LONG				equ	dd
@UINT				equ	dd
@WNDPROC		equ	dd
@int				equ	dd
@HINSTANCE	equ	dd
@HICON			equ dd
@HCURSOR		equ dd
@HBRUSH			equ dd
@LPCSTR			equ dd
@HWND				equ dd
@WPARAM			equ dd
@LPARAM			equ dd
@DWORD			equ dd

WNDCLASSEX STRUCT 8
	cbSize				@UINT				?
	style					@UINT				?
	lpfnWndProc		@WNDPROC		?
	cbClsExtra		@int				?
	cbWndExtra		@int				?
	hInstance			@HINSTANCE	?
	hIcon					@HICON			?
	hCursor				@HCURSOR		?
	hbrBackground	@HBRUSH			?
	lpszMenuName	@LPCSTR			?
	lpszClassName	@LPCSTR			?
	hIconSm				@HICON			?
WNDCLASSEX ENDS

POINT STRUCT 8
	x							@LONG				?
	y							@LONG				?
POINT ENDS

MSG STRUCT 8
	hwnd					@HWND				?
	message				@UINT				?
	wParam				@WPARAM			?
	lParam				@LPARAM			?
	time					@DWORD			?
	pt						POINT				{}
MSG ENDS

RECT STRUCT 8
	left					@LONG				?
	top						@LONG				?
	right					@LONG				?
	bottom				@LONG				?
RECT ENDS

RAS_MaxEntryName			=256
RAS_MaxPhoneNumber		=128
RAS_MaxCallbackNumber equ RAS_MaxPhoneNumber
UNLEN									=256
PWLEN									=256
CNLEN									=15
DNLEN									=CNLEN

RASDIALPARAMS STRUCT 4				;Œ¡–¿“» ¬Õ»Ã¿Õ»≈!!!!
    dwSize						@DWORD ?
    szEntryName				db (RAS_MaxEntryName+1)dup(?)
    szPhoneNumber			db (RAS_MaxPhoneNumber+1)dup(?)
    szCallbackNumber	db (RAS_MaxCallbackNumber+1)dup(?)
		szUserName				db (UNLEN+1)dup(?)
		szPassword				db (PWLEN+1)dup(?)
		szDomain					db (DNLEN+1)dup(?)
RASDIALPARAMS ENDS

RASCS_PAUSED	=1000h
RASCS_DONE		=2000h

RASCS_OpenPort						=0
RASCS_PortOpened					=1
RASCS_ConnectDevice				=2
RASCS_DeviceConnected			=3
RASCS_AllDevicesConnected	=4
RASCS_Authenticate				=5
RASCS_AuthNotify					=6
RASCS_AuthRetry						=7
RASCS_AuthCallback				=8
RASCS_AuthChangePassword	=9
RASCS_AuthProject					=10
RASCS_AuthLinkSpeed				=11
RASCS_AuthAck							=12
RASCS_ReAuthenticate			=13
RASCS_Authenticated				=14
RASCS_PrepareForCallback	=15
RASCS_WaitForModemReset		=16
RASCS_WaitForCallback			=17
RASCS_Projected						=18
RASCS_StartAuthentication	=19
RASCS_CallbackComplete		=20
RASCS_LogonNetwork				=21
RASCS_SubEntryConnected		=22
RASCS_SubEntryDisconnected=23
RASCS_Interactive					=RASCS_PAUSED
RASCS_RetryAuthentication	=RASCS_PAUSED+1
RASCS_CallbackSetByCaller	=RASCS_PAUSED+2
RASCS_PasswordExpired			=RASCS_PAUSED+3
RASCS_Connected						=RASCS_DONE
RASCS_Disconnected				=RASCS_DONE+1

RAS_MaxDeviceType					=16
RAS_MaxDeviceName					=128
RAS_MaxPhoneNumber				=128
RAS_MaxEntryName					=256

RASCONNSTATUS STRUCT 4
	dwSize				@DWORD ?
	rasconnstate	@DWORD ?
	dwError				@DWORD ?
	szDeviceType	db (RAS_MaxDeviceType+1)dup(?)
	szDeviceName	db (RAS_MaxDeviceName+1)dup(?)
RASCONNSTATUS ENDS

RASCONN STRUCT 4
	dwSize				@DWORD ?
	hrasconn			@DWORD ?
	szEntryName		db (RAS_MaxEntryName+1)dup(?)
	szDeviceType	db (RAS_MaxDeviceType+1)dup(?)
	szDeviceName	db (RAS_MaxDeviceName+1)dup(?)
RASCONN ENDS
