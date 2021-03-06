; ��������� ��� ������������� ANSI-����� � ASCII-������
; ����:
; PARAM1 - ����� ������ ��� ��������������
; PARAM2 - ������ ������
;
; �����:
; ��������������� ������ ������������ �� ��������� ������
;
ConvertToRus PROC USES ebx ecx PARAM1:DWORD, PARAM2:DWORD

    mov ebx, PARAM1
    mov ecx, PARAM2

start_loop:
    mov al, [ebx]
    
	.IF (al>='�' && al<='�') || (al>='�' && al<='�')
        sub al, 64
	    mov [ebx], al
	.ENDIF
    
	.IF al>='�' && al<='�'
        sub al, 16
	    mov [ebx], al
	.ENDIF
		
	inc ebx
    loop start_loop

    ret
ConvertToRus ENDP

; ��������� (���������������) ��� ������ ��������������� �������� ������ �� �����
; ����:
; PARAM1 - ����� ������ ��� ������
; PARAM2 - ������ ������
;
; �����:
; ����� �� �����
;
OutputString PROC USES ecx esi edi PARAM1:DWORD, PARAM2:DWORD
  
  mov esi, PARAM1
  mov ecx, PARAM2
  lea edi, _strbuf

  cld
  rep movsb
  RUS <_strbuf>
  WRITE_CONSOLE OFFSET _strbuf, PARAM2

  ret
OutputString ENDP

;
; ��������� ��� ����������� ������������������ ����� � ASCII
; ����:
; PARAM1:DWORD - ����� ��� ��������������
; �����:
; [ebx] - ����� �������� ������
; eax   - ����� ������
;
POSITIVE_HEX2ASCII PROC USES ecx edx edi PARAM1:DWORD
	
	mov eax, PARAM1	; �������� ����� - � eax
	lea ebx, buf+11	; ��������� ����� "�����" ������ (����� ��������� ������-������)
	mov  edi, 10	; �������� ����� ������� � edi
	xor ecx, ecx	; ��������� ��������

_label1:
	dec ebx			; �������� ����� �������� ������� � ������-���������
	xor  edx, edx	; ������� ���� edx:eax ��� �������
					; �������� edx, �.�. ������� ����� ��������
	
	div  edi		; �������� �������, ������ � eax - �������, edx - �������

    add dl, '0'		; "���������" ����� - ������� � ������� ASCII ����� '0' � 0
	mov [ebx], dl	; �������� ���� � �����

	inc ecx			; ����������� �������, �.�. ����� ������ ����������� �� 1
	cmp eax, 0		; ���� ������� ��� �� �������
	jnz _label1		; �� ��������� � ������ �����
	
	mov eax, ecx	; ��������� ����� ������ � eax
	
	ret
POSITIVE_HEX2ASCII ENDP


;
; ��������� ��� ����������� ������������������ ����� � ASCII
; ����:
; PARAM1:DWORD - ����� ��� ��������������
; �����:
; [ebx] - ����� �������� ������
; eax   - ����� ������
;
HEX2ASCII PROC PARAM1:DWORD
	
    mov eax, PARAM1
	cmp eax,0
	jge _positive
	
	neg eax
	INVOKE POSITIVE_HEX2ASCII, eax
	inc eax
	dec ebx
	push eax
	mov al, '-'
	mov [ebx], al
	pop eax

	jmp _finish
	
_positive:		
	INVOKE POSITIVE_HEX2ASCII, eax
	
_finish:
	ret
HEX2ASCII ENDP


;
; ��������� ��� ������ 32-������� ����� � ����������
; �����:
; eax - ��������� �����
;
READNUMBER PROC USES ebx ecx edx esi edi
		
	mov esi, OFFSET buf
	
	INVOKE ReadConsoleA, stdin, OFFSET buf, SIZEOF buf, OFFSET cWritten, NULL
	
	mov eax, cWritten
	mov BYTE PTR [esi+eax-2], 0

	xor edi, edi    ; edi=0 - ����� �������������
	mov al, [esi]   ; ����������� ������ ������
	.IF al=='-'     ;
      inc esi       ; ���� ������ ������ '-', �� ���������� ���
	  inc edi       ; edi=1 - ����� �������������
	.ENDIF          ;
		
	xor eax, eax	;
	xor ebx, ebx	;
	xor edx, edx	; ���������� ��������� � ��������������
	mov ecx, 10		; ecx ����� ������� ��������

_START:
	mov bl,[esi]	; ��������� ��������� ������

	cmp bl,0
	je  _DONE       ; ���� ��� ����� ������ - �����
	cmp bl,'0'
	jl  _DONE		; ���� ������ ������ '0' - �����
	cmp bl,'9'
	jg  _DONE		; ���� ������ ������ '9' - �����

	sub bl,'0'      ; "���������" ����� - ������� � ������� ASCII ����� '0' � 0
	mul ecx			; ���������� eax*ecx, ��������� ���������� � edx:eax
	add eax, ebx    ; ��������� ����� ������
	
	inc esi			; ��������� � ������ �������
	jmp _START      ; � ������ �����

_DONE:
	
	.IF edi==1      ; ���� ����� �������������
      neg eax       ; �� ����������� ���������
	.ENDIF          ;

	ret
READNUMBER ENDP


;
; ��������� ��� ��������� ���������� �����
;
; ����:
; Range - ������� �������
;
; �����: 
; eax - ��������� ����� �� 0 �� Range-1
;
; ������:
; INVOKE Random, 10
; 
Random PROC USES ebx ecx edx Range:SDWORD
    
	;
	; ���� �� ����� <=0, �� �� ������ 0
	;
	.IF Range <=0
	  xor eax, eax
	  jmp _exit_random
	.ENDIF
	
	;
	; � eax ���������� ������� ����� � �������������
	;
	INVOKE GetTickCount
	
	;
	; ���������� 32-������ ��������� ����� � ��������� _rSeed
	;	
	add eax, _rSeed
	mov edx, 8405h
	mul edx
	inc eax
	and eax, 7FFFFFFFh
	mov _rSeed, eax

	;
	; ��������� ���������� ��������� ����� � �������� 0..Range-1
	;
	xor edx, edx
	mov ebx, Range
	div ebx
	mov eax, edx

_exit_random:	
	ret
Random ENDP

;
; ��������� ��� ��������� ���������� �����
;
; ����:
; Range - ������� �������; -Range - ������ �������
;
; �����: 
; eax - ��������� ����� �� -Range+1 �� Range-1
;
; ������:
; INVOKE RandomN, 10
; 
RandomN PROC Range:SDWORD
    
	;
	; ���� �� ����� <=0, �� �� ������ 0
	;
	.IF Range <= 0
	  xor eax, eax
	  jmp _exit_random_n
	.ENDIF
	
	INVOKE Random, 101
	
	and eax, 1
	
	je POS_NUM
	INVOKE Random, Range
	neg eax
	jmp _exit_random_n
POS_NUM:
	INVOKE Random, Range

_exit_random_n:	
	ret
RandomN ENDP