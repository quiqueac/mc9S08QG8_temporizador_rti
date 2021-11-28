;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            
;
; export symbols
;
            XDEF _Startup
            ABSENTRY _Startup

;
; variable/data section
;
            ORG    	$60		; Insert your data definition here
M60: 		DS.B   	1		; Contador de segundos de led encendido
M61: 		DS.B   	1		; Numero de segundos que dura el led encendido
M62:		DS.B	1		; Contador de segundos de led apagado
M63:		DS.B	1		; Numero de segundos que dura el led apagado

;
; code section
;
            ORG    	ROMStart
            

_Startup:
            LDHX   	#RAMEnd+1	; initialize the stack pointer
            TXS
            
            LDA	  	#$12	; DATO INMEDIATO PARA DESHABILITAR WATCHDOG	
            STA	  	SOPT1	; DESHABILITAR WATCHDOG
            
            LDA	  	#$53    ; Configura IRQMOD=1, IRQPE=1, IRQPDD=1, IRQIE=1
        	STA   	IRQSC	; Usando PIN PTA5 como IRQ
            
            CLI		; enable interrupts
            
            BSET 	0,PTBDD		; Pin 0 del puerto B como salida
            
            MOV		#$00,M60	; Inicializacion de M60
            
            MOV		#$02,M61	; Inicializacion de M61
            					; 2 segundos encendido
            					
            MOV		#$00,M62	; Inicializacion de M62
            
            MOV		#$01,M63	; Inicializacion de M62
            					; 1 segundo apagado
Retardo:
			LDA		#$13	; 1 segundo
			STA		SRTISC	; Guardar en el registro SRTISC el valor del acumulador
			CLI		; Habilitar interrupciones
			BRA		Retardo		; Brinca a la etiqueta retardo
           
;**************************************************************
;* Interrupcion_temporizador                                  *
;**************************************************************

Interrupcion_temporizador:	
			SEI		; Quita las IRQ
			
			LDA		#$40	; Limpiar la bandera y detener el temporizador
			STA		SRTISC	; Guardar en el registro SRTISC el valor del acumulador
									
			BRCLR 	0,PTBD,Encender_led	; Checar si el led esta apagado
Apagar_led:
			INC		M60		; Incrementar contador de segundos de led encendido
			LDA		M61		; Cargar en el acumulador lo que tiene que durar el led apagado
			CMP		M60		; Comparar el acumulador con los segundos transcurridos
			BNE		Continuar	; Si no es igual brincar a la etiqueta Encender_led
			CLR		M60		; Reset de los segundos transcurridos
			BCLR 	0,PTBD	; Apagar el led
			BRA		Continuar	; Volver a la etiqueta Continuar
Encender_led:
			INC		M62		; Decrementar contador de segundos de led encendido
			LDA		M63		; Cargar en el acumulador lo que tiene que durar el led apagado
			CMP		M62		; Comparar el acumulador con los segundos transcurridos
			BNE		Continuar	; Si no es igual brincar a la etiqueta Apagar_led
			CLR		M62		; Reset de los segundos transcurridos
			BSET 	0,PTBD	; Encender el led
Continuar:
			LDA		#$13	; Habilitar el temporizador y empezar el conteo
			STA		SRTISC	; Guardar en el registro SRTISC el valor del acumulador
			
			CLI		; Activa las IRQ
			RTI   	; Termina la IRQ
				
;**************************************************************
;* Interrupcion_externa - Usando PIN PTA5 como IRQ            *
;**************************************************************

Interrupcion_externa:	
			SEI  							; Quita las IRQ
			
			BSET 	IRQSC_IRQACK,IRQSC		; Apagar la bandera IRQF
									
			;INC 	M61						; Incrementar numero de segundos que dura el retardo
			
			CLI   							; Activa las IRQ
			RTI   							; Termina la IRQ

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************

            ORG	$FFFE
			DC.W  _Startup						; Reset
			
			ORG	$FFFA
			DC.W  Interrupcion_externa   		; Para el pin IRQ 
			
			ORG $FFD0
			DC.W  Interrupcion_temporizador		; Interrupcion del temporizador
