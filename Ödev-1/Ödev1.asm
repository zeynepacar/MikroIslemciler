
;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Cum Mar 11 2016
; Processor: 8086
; Compiler:  MASM32
;
; Before starting simulation set Internal Memory Size 
; in the 8086 model properties to 0x10000
;====================================================================
STAK    SEGMENT PARA STACK 'STACK'
        DW 20 DUP(?)
STAK    ENDS

DATA    SEGMENT PARA 'DATA'
PASSWORD DB 4 DUP(?)
DIGITS DB 5 DUP(?)
MASTER DB 08H,04H,00H,09H
DATA    ENDS

CODE    SEGMENT PARA 'CODE'
        ASSUME CS:CODE, DS:DATA, SS:STAK
START   PROC FAR
	
	PUSH DS
	XOR AX,AX
	PUSH AX
        MOV AX, DATA
	MOV DS, AX
	
        MOV AL, 81H ;port a, port b, port ch output port cl input yonlu olacak sekilde control word ayarlaniyor
	OUT 0AEH, AL
	
	MOV AL, 0C1H ;KASA KILITLI DEGIL U GOSTERIYOR
	OUT 0A8H,AL
	
	
ENDLESS:

	XOR SI,SI ; dizi indisini sifirliyoruz
	
	
SIFREOKU:	CALL TUS_OKU
		CMP SI,05H ; bes kere tus okuma islemi gerceklestiriliyor
		JNZ SIFREOKU
		
            CMP DIGITS[4],03H ; dört hane girildikten sonra kareye basilmis diye kontrol ediyoruz
	    JZ KILITLE ; kareye basilmissa kasayi kitlemek icin ilgili yere atliyoruz
	    
	    ;kareye basilmamissa
	    XOR SI,SI
	    MOV AL,DIGITS[4] ;en son girilen basamagi sifre dizimizin ilk hanesine atiyoruz
	    MOV PASSWORD[SI],AL
	    INC SI
	    JMP SIFREOKU ;tekrar kullanicidan sifre icin basamak almaya geri donuyoruz kareye basilana kadar

	    
KILITLE:    ;kareye basilmissa
	    MOV AL, 0C7H ;KASA KILITLI L GOSTERIYOR
	    OUT 0A8H,AL
	    
            XOR SI,SI
	    
SIFREATA:  
	    MOV AL,DIGITS[SI]  ;girilen basamaklari sonrasında kontrol sirasinda erismek icin sifre dizisine atiyoruz
	    MOV PASSWORD[SI],AL
	    INC SI
	    CMP SI,04H
	    JNZ SIFREATA

	    JMP LOCKED
	    
	    	   
	    
LOCKED:	 ;kasa kilitli ise
	  XOR SI,SI
SIFREGIR: CALL TUS_OKU ;kullanicidan dort basamakli sifre aliyoruz
	  CMP SI,04H
	  JNZ SIFREGIR
	  
	  XOR SI,SI
KARSILASTIR1: ;kullanicidan alinan sifreyi once kendi belirledigimiz sifre ile karsilastiriyoruz
	      MOV AL,DIGITS[SI]
	      CMP AL,PASSWORD[SI] 
	      JNZ MASTERPASS ; eger belirlenmis sifreden farkli bir basamak girildiyse bu sefer master sifre ile karsilastirmak icin oraya atliyoruz
	      
	      INC SI ;girilen degerler ve onceden belirlenmis sifre basamaklari ayni oldugu surece karsılastirmaya devam ediyoruz
	      CMP SI,04H 
	      JNZ KARSILASTIR1
	      
	      ;eger tum basamaklar ayni girilmisse
	      MOV AL, 0C1H ;KASA KILITLI DEGIL U GOSTERIYOR
	      OUT 0A8H,AL
	      JMP ENDLESS
	      
MASTERPASS:	XOR SI,SI
		;girilen sifre ile master sifreyi karsilastiriyoruz
KARSILASTIR2:	MOV AL,DIGITS[SI]
		CMP AL,MASTER[SI] ;eger master sifreden daha farkli bir basamak girilmisse bu sefer sifre alma islemine en bastan basliyoruz
	        JNZ LOCKED
	
	        INC SI
	        CMP SI,04H ;girilen degerler ve master sifre basamaklari ayni oldugu surece karsılastirmaya devam ediyoruz
	        JNZ KARSILASTIR2
		MOV AL, 0C1H ;KASA KILITLI DEGIL U GOSTERIYOR
	        OUT 0A8H,AL            
	       
	    
	    JMP ENDLESS
	    RETF
START ENDP

TUS_OKU PROC NEAR
	
	MOV AL,00H
	OUT 0AAH,AL ;TUS TARAMA TAKIMINDA TUSLAR AKTIF DEGIL
        MOV DX, 00H
	MOV CL,3 ;tus tarama takiminda uc sutun icin tekrarliyoruz
	MOV BL, 08H

SUTUN:	SHR BL,1
	
	MOV AL,BL
	OUT 0AAH,AL ;sirasiyla her geciste 1 , 2 ve 3 nolu sutunlari aktif et
	
	IN AL,0ACH ;satirlari oku 
	AND AL,0FH
	
	CMP AL, 00H ;aktif sutundan herhangi bir tusa basilmamissa sonuc 0, bir sonraki sutuna gec
	JE DEVAM1
	PUSH AX ;basilmissa satir degerlerini stack'e at
TUSBASILI:  IN AL,0ACH
	    AND AL,0FH
	    CMP AL,00H
	    JNE TUSBASILI ;basili tus birakilana kadar bekle
	    
	    POP AX
	    MOV DH, AL ;okunan satir degeri DH'ta
	    MOV CH,CL
	    DEC CH
	    MOV AL,4
	    MUL CH ;AX'te aktif olan sutunun ilk tusunun bastan kacinci sirada oldugu bilgisi yer alicak
	    MOV DL,0
	    
DEVAM3:     SHR DH,1
	    CMP DH, 00H
	    JE DEVAM2 ;DL'de basili tusun satir numarasi var
	    INC DL
	    JMP DEVAM3
	    
DEVAM2:     ADD AX,DX ;BASILAN TUS INDISI AX'TE
	    MOV DIGITS[SI],AL ;basilan tus indisini diziye atiyoruz ve buradan erisiyoruz
	    INC SI
	    
DEVAM1:     LOOP SUTUN

RET
TUS_OKU ENDP
	
CODE    ENDS
        END START