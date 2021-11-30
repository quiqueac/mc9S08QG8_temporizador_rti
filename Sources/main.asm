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
M61: 		DS.B   	1		; Numero de segundos que debe durar el led encendido
M62:		DS.B	1		; Contador de segundos de led apagado
M63:		DS.B	1		; Numero de segundos que debe durar el led apagado

;
; code section
;
            ORG    	ROMStart
            
_Startup:
            LDHX   	#RAMEnd+1	; initialize the stack pointer
            TXS
            
            LDA	  	#$12	; DATO INMEDIATO PARA DESHABILITAR WATCHDOG	
            STA	  	SOPT1	; DESHABILITAR WATCHDOG
            
            BSET 	0,PTBDD		; Pin 0 del puerto B como salida
            BCLR	PTADD_PTADD0,PTADD	; Pin 0 del puerto A como boton para cambiar la intensidad del led
            
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
Inicio_checarPuertoA:		; Comenzar a checar puerto A
			BRCLR 	0,PTAD,Checar_numero_de_segundos_que_debe_durar_el_led	; Checar si se ha presionado el boton del puerto A
																			; Logica negativa
			BRA		Retardo	; Brincar a la etiqueta
			Checar_numero_de_segundos_que_debe_durar_el_led:		
						LDA		M61			; Cargar en el acumulador el contenido de la memoria 61
											; La memoria 61 es el numero de segundos que debe durar el led encendido, 
											; por defecto es 2 segundos
												
						CMP		#$02		; Comparar con 2, si es igual, lo cambiamos a 1 segundo (Cambiar_numero_de_segundos_que_debe_durar_el_led_1)
						BNE		Cambiar_numero_de_segundos_que_debe_durar_el_led_2		; Si no es igual brincar a la etiqueta
			Cambiar_numero_de_segundos_que_debe_durar_el_led_1:	; Si es igual,
						MOV		#$01,M61	; el numero de segundos que debe durar el led encendido ahora es de 1 segundo
						MOV		#$02,M63	; el numero de segundos que debe durar el led apagado ahora es de 2 segundos
						BRA		Retardo		; Volver al retardo
			Cambiar_numero_de_segundos_que_debe_durar_el_led_2:	; Si es igual,
						MOV		#$02,M61	; el numero de segundos que debe durar el led encendido ahora es de 1 segundo
						MOV		#$01,M63	; el numero de segundos que debe durar el led apagado ahora es de 2 segundos
						BRA		Retardo		; Volver al retardo
           
;**************************************************************
;* Interrupcion_temporizador                                  *
;**************************************************************

Interrupcion_temporizador:	
			SEI		; Quita las IRQ
			
			LDA		#$40	; Limpiar la bandera y detener el temporizador
			STA		SRTISC	; Guardar en el registro SRTISC el valor del acumulador
									
			BRCLR 	0,PTBD,Checar_encender_led	; Checar si el led esta apagado
Checar_apagar_led:
			INC		M60		; Incrementar contador de segundos de led encendido
			LDA		M61		; Cargar en el acumulador lo que tiene que durar el led apagado
			CMP		M60		; Comparar el acumulador con los segundos transcurridos
			BNE		Continuar	; Si no es igual brincar a la etiqueta Continuar
			MOV		#$00,M60	; Reset de los segundos transcurridos
			BCLR 	0,PTBD	; Apagar el led
			BRA		Continuar	; Volver a la etiqueta Continuar
Checar_encender_led:
			INC		M62		; Incrementar contador de segundos de led apagado
			LDA		M63		; Cargar en el acumulador lo que tiene que durar el led apagado
			CMP		M62		; Comparar el acumulador con los segundos transcurridos
			BNE		Continuar	; Si no es igual brincar a la etiqueta Continuar
			MOV		#$00,M62	; Reset de los segundos transcurridos
			BSET 	0,PTBD	; Encender el led
Continuar:
			LDA		#$13	; Habilitar el temporizador y empezar el conteo
			STA		SRTISC	; Guardar en el registro SRTISC el valor del acumulador
			
			CLI		; Activa las IRQ
			RTI   	; Termina la IRQ

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************

            ORG	$FFFE
			DC.W  _Startup						; Reset
			
			ORG $FFD0
			DC.W  Interrupcion_temporizador		; Interrupcion del temporizador
