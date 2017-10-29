        
message '****************************************************************'
message '*PROJECT NAME :MAIN PROGRAM                                    *'
message '*     VERSION :                                                *'
message '* ICE VERSION :                                                *'
message '*      REMARK :                                                *'
message '****************************************************************'
                ;=INCLUDE REFERENCE FILE                                  '
                INCLUDE "..\HXT_REFERENCE.INC"
                INCLUDE MAIN_PROGRAM.INC  
                PUBLIC  _LOAD_HXT_REFERENCE

                ;==============
                ;=DATA SETCTION
                ;==============
MAIN_DATA       .SECTION          'DATA'



                ;==============
                ;=CODE SETCTION
                ;==============
PROGRAM_ENTRY   .SECTION  AT 000H 'CODE'
                JMP     PROGRAM_RESET

                ;==============
                ;=MAIN PROGRAM=
                ;==============
MAIN_PROGRAM    .SECTION          'CODE'

                ;;*********************** 
PROGRAM_RESET:  ;;* PROGRAM ENTRY *******                    
                ;;*********************** 
                ;---------------------                                                                                                          
                ;-MCU HARDWARE INITIAL
                ;--------------------- 

                IFNDEF  BS83A04A
                ;-SET SYSTEM CLOCK
                MOV     A,((SystemClock<<4)^00110000B)&00110000B
                MOV     CTRL,A
                ENDIF

;                CLR     SMOD1
                MOV     A,00010011B
                MOV     SMOD,A

                ;-WDT INITIAL USE 125/500MS WHEN ENABLE POWER SAVE MODE                                                                       
                MOV     A,01010010B     ;125   MS                                                                                             
              ;;MOV     A,01010011B     ;500   MS                                                                                             
                MOV     WDTC,A

                ;-IF POWER SAVING MODE ENABLE
                IF      PowerSave==1
                SZ      TO
                JMP     WDT_WAKEUP      ;IF WAKEUP BY WDT TIME OUT
                ENDIF


                ;----------------                                                                         
                ;-CLEAR RAM     -
                ;----------------
        IFDEF   BS83A04A
                ;-CLEAR BANK0 060H~0FFH
                MOV     A,60H
                CALL    CLEAR_RAM
        ENDIF
        ;-------------------------------
        IFDEF   BS83B08A
                ;-CLEAR BANK0 060H~0FFH
                MOV     A,60H
                CALL    CLEAR_RAM
        ENDIF
        ;-------------------------------
        IFDEF   BS83B12A
                ;-CLEAR BANK1 080H~0FFH
                MOV     A,1
                MOV     BP,A
                MOV     A,80
                CALL    CLEAR_RAM
                ;-CLEAR BANK0 060H~0FFH
                CLR     BP
                MOV     A,60H
                CALL    CLEAR_RAM
        ENDIF
        ;-------------------------------
        IFDEF   BS83B16A
                ;-CLEAR BANK1 080H~0FFH
                MOV     A,1
                MOV     BP,A
                MOV     A,80
                CALL    CLEAR_RAM
                ;-CLEAR BANK0 060H~0FFH
                CLR     BP
                MOV     A,60H
                CALL    CLEAR_RAM
        ENDIF
        ;-------------------------------
        IFDEF   BS84B08A
                ;-DISABLE ADC
                CLR     ACERL
                MOV     A,01100000B
                MOV     ADCR0,A
                CLR     ADCR1
                ;-CLEAR BANK1 080H~0FFH
                MOV     A,1
                MOV     BP,A
                MOV     A,80
                CALL    CLEAR_RAM
                ;-CLEAR BANK0 060H~0FFH
                CLR     BP
                MOV     A,60H
                CALL    CLEAR_RAM
        ENDIF
        ;-------------------------------
        IFDEF BS84C12A
                ;-DISABLE ADC
                CLR     ACERL
                MOV     A,01100000B
                MOV     ADCR0,A
                CLR     ADCR1
                ;-CLEAR BANK2 280H~2DFH
                MOV     A,2
                MOV     BP,A
                MOV     A,80H
                CALL    CLEAR_RAM
                ;-CLEAR BANK1 180H~1FFH
                MOV     A,1
                MOV     BP,A
                MOV     A,80H
                CALL    CLEAR_RAM
                ;-CLEAR BANK0 060H~0FFH
                CLR     BP    
                MOV     A,60H
                CALL    CLEAR_RAM
        ENDIF
        ;-------------------------------- 

                ;-LOAD LIBRARY OPTION/THRESHOLD                                                                                                 
                CALL    _LOAD_HXT_REFERENCE

                ;------------------------
                ;-EXTEND FUNCTION INITIAL
                ;------------------------
                IFDEF   EXTEND_FUNCTION_1A_INITIAL
                CALL    EXTEND_FUNCTION_1A_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1B_INITIAL
                CALL    EXTEND_FUNCTION_1B_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1C_INITIAL
                CALL    EXTEND_FUNCTION_1C_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1D_INITIAL
                CALL    EXTEND_FUNCTION_1D_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1E_INITIAL
                CALL    EXTEND_FUNCTION_1E_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1F_INITIAL
                CALL    EXTEND_FUNCTION_1F_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1G_INITIAL
                CALL    EXTEND_FUNCTION_1G_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1H_INITIAL
                CALL    EXTEND_FUNCTION_1H_INITIAL
                ENDIF



                IFDEF   EXTEND_FUNCTION_2A_INITIAL
                CALL    EXTEND_FUNCTION_2A_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2B_INITIAL
                CALL    EXTEND_FUNCTION_2B_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2C_INITIAL
                CALL    EXTEND_FUNCTION_2C_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2D_INITIAL
                CALL    EXTEND_FUNCTION_2D_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2E_INITIAL
                CALL    EXTEND_FUNCTION_2E_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2F_INITIAL
                CALL    EXTEND_FUNCTION_2F_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2G_INITIAL
                CALL    EXTEND_FUNCTION_2G_INITIAL
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2H_INITIAL
                CALL    EXTEND_FUNCTION_2H_INITIAL
                ENDIF


                ;;-----------------------
MAIN_LOOP:      ;;- MAIN PROGRAM LOOP ---
                ;;-----------------------
                CLR     WDT


                IFDEF   EXTEND_FUNCTION_1A
                CALL    EXTEND_FUNCTION_1A
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1B
                CALL    EXTEND_FUNCTION_1B
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1C
                CALL    EXTEND_FUNCTION_1C
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1D
                CALL    EXTEND_FUNCTION_1D
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1E
                CALL    EXTEND_FUNCTION_1E
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1F
                CALL    EXTEND_FUNCTION_1F
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1G
                CALL    EXTEND_FUNCTION_1G
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_1H
                CALL    EXTEND_FUNCTION_1H
                ENDIF




                IFDEF   EXTEND_FUNCTION_2A
                CALL    EXTEND_FUNCTION_2A
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2B
                CALL    EXTEND_FUNCTION_2B
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2C
                CALL    EXTEND_FUNCTION_2C
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2D
                CALL    EXTEND_FUNCTION_2D
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2E
                CALL    EXTEND_FUNCTION_2E
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2F
                CALL    EXTEND_FUNCTION_2F
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2G
                CALL    EXTEND_FUNCTION_2G
                ENDIF
                ;--
                IFDEF   EXTEND_FUNCTION_2H
                CALL    EXTEND_FUNCTION_2H
                ENDIF



                ;--------------------
WDT_WAKEUP:     ;-WDT WAKEUP FUNCTION
                ;--------------------
                IF      PowerSave==1
                CALL    _CHECK_KEY_WAKEUP
                ENDIF

                JMP     MAIN_LOOP        
                




    


                                                                                                                                                
;;***********************************************************                           
;;*SUB. NAME:                                               *                           
;;*INPUT    :                                               *                           
;;*OUTPUT   :                                               *                           
;;*USED REG.:                                               *                           
;;*FUNCTION :                                               *                           
;;***********************************************************
CLEAR_RAM:
                MOV     MP1,A
                CLR     IAR1
                INCA    MP1
                SNZ     Z
                JMP     $-4
                RET

                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
;;***********************************************************                                                                                   
;;*SUB. NAME:                                               *                                                                                   
;;*INPUT    :                                               *                                                                                   
;;*OUTPUT   :                                               *                                                                                   
;;*USED REG.:                                               *                                                                                   
;;*FUNCTION :                                               *                                                                                   
;;***********************************************************                                                                                   
_LOAD_HXT_REFERENCE:                                                                                             
                ;-TKS LIBRARY OPTION                                                                            
                MOV     A,GlobeOptionA                                                                          
                MOV     _GLOBE_VARIES[0],A                                                                      
                MOV     A,GlobeOptionB                                                                          
                MOV     _GLOBE_VARIES[1],A                                                                      
                MOV     A,GlobeOptionC                                                                          
                MOV     _GLOBE_VARIES[2],A  
        ;----------------------------------
        IFDEF   BS83A04A
                ;-TOUCH OR IO SETTING
                MOV     A,IO_TOUCH_ATTR&00FH
                MOV     _KEY_IO_SEL[0],A
                ;-KEY1 THRESHOLD                                                                                
                MOV     A,Key1Threshold                                                                         
                MOV     _GLOBE_VARIES[3],A                                                                      
                ;-KEY2 THRESHOLD                                                                                
                MOV     A,Key2Threshold                                                                         
                MOV     _GLOBE_VARIES[4],A                                                                      
                ;-KEY3 THRESHOLD                                                                                
                MOV     A,Key3Threshold                                                                         
                MOV     _GLOBE_VARIES[5],A                                                                      
                ;-KEY4 THRESHOLD                                                                                
                MOV     A,Key4Threshold                                                                         
                MOV     _GLOBE_VARIES[6],A
        ENDIF
        ;----------------------------------
        IFDEF   BS83B08A 
                ;-TOUCH OR IO SETTING
                MOV     A,IO_TOUCH_ATTR&0FFH
                MOV     _KEY_IO_SEL[0],A
                ;-KEY1 THRESHOLD                                                                                
                MOV     A,Key1Threshold                                                                         
                MOV     _GLOBE_VARIES[3],A                                                                      
                ;-KEY2 THRESHOLD                                                                                
                MOV     A,Key2Threshold                                                                         
                MOV     _GLOBE_VARIES[4],A                                                                      
                ;-KEY3 THRESHOLD                                                                                
                MOV     A,Key3Threshold                                                                         
                MOV     _GLOBE_VARIES[5],A                                                                      
                ;-KEY4 THRESHOLD                                                                                
                MOV     A,Key4Threshold                                                                         
                MOV     _GLOBE_VARIES[6],A  
                ;-KEY5 THRESHOLD                                                                                
                MOV     A,Key5Threshold                                                                         
                MOV     _GLOBE_VARIES[7],A                                                                      
                ;-KEY6 THRESHOLD                                                                                
                MOV     A,Key6Threshold                                                                         
                MOV     _GLOBE_VARIES[8],A                                                                      
                ;-KEY7 THRESHOLD                                                                                
                MOV     A,Key7Threshold                                                                         
                MOV     _GLOBE_VARIES[9],A                                                                      
                ;-KEY8 THRESHOLD                                                                                
                MOV     A,Key8Threshold                                                                         
                MOV     _GLOBE_VARIES[10],A
        ENDIF
        ;----------------------------------
        IFDEF   BS84B08A
                ;-TOUCH OR IO SETTING
                MOV     A,IO_TOUCH_ATTR&0FFH
                MOV     _KEY_IO_SEL[0],A
                ;-KEY1 THRESHOLD                                                                                
                MOV     A,Key1Threshold                                                                         
                MOV     _GLOBE_VARIES[3],A                                                                      
                ;-KEY2 THRESHOLD                                                                                
                MOV     A,Key2Threshold                                                                         
                MOV     _GLOBE_VARIES[4],A                                                                      
                ;-KEY3 THRESHOLD                                                                                
                MOV     A,Key3Threshold                                                                         
                MOV     _GLOBE_VARIES[5],A                                                                      
                ;-KEY4 THRESHOLD                                                                                
                MOV     A,Key4Threshold                                                                         
                MOV     _GLOBE_VARIES[6],A  
                ;-KEY5 THRESHOLD                                                                                
                MOV     A,Key5Threshold                                                                         
                MOV     _GLOBE_VARIES[7],A                                                                      
                ;-KEY6 THRESHOLD                                                                                
                MOV     A,Key6Threshold                                                                         
                MOV     _GLOBE_VARIES[8],A                                                                      
                ;-KEY7 THRESHOLD                                                                                
                MOV     A,Key7Threshold                                                                         
                MOV     _GLOBE_VARIES[9],A                                                                      
                ;-KEY8 THRESHOLD                                                                                
                MOV     A,Key8Threshold                                                                         
                MOV     _GLOBE_VARIES[10],A
        ENDIF
        ;----------------------------------
        IFDEF   BS83B12A
                ;-TOUCH OR IO SETTING
                MOV     A,IO_TOUCH_ATTR&0FFH
                MOV     _KEY_IO_SEL[0],A
                MOV     A,(IO_TOUCH_ATTR>>8)&00FH
                MOV     _KEY_IO_SEL[1],A
                ;-KEY1 THRESHOLD                                                                                
                MOV     A,Key1Threshold                                                                         
                MOV     _GLOBE_VARIES[3],A                                                                      
                ;-KEY2 THRESHOLD                                                                                
                MOV     A,Key2Threshold                                                                         
                MOV     _GLOBE_VARIES[4],A                                                                      
                ;-KEY3 THRESHOLD                                                                                
                MOV     A,Key3Threshold                                                                         
                MOV     _GLOBE_VARIES[5],A                                                                      
                ;-KEY4 THRESHOLD                                                                                
                MOV     A,Key4Threshold                                                                         
                MOV     _GLOBE_VARIES[6],A  
                ;-KEY5 THRESHOLD                                                                                
                MOV     A,Key5Threshold                                                                         
                MOV     _GLOBE_VARIES[7],A                                                                      
                ;-KEY6 THRESHOLD                                                                                
                MOV     A,Key6Threshold                                                                         
                MOV     _GLOBE_VARIES[8],A                                                                      
                ;-KEY7 THRESHOLD                                                                                
                MOV     A,Key7Threshold                                                                         
                MOV     _GLOBE_VARIES[9],A                                                                      
                ;-KEY8 THRESHOLD                                                                                
                MOV     A,Key8Threshold                                                                         
                MOV     _GLOBE_VARIES[10],A
                ;-KEY9 THRESHOLD                                                                                
                MOV     A,Key9Threshold                                                                         
                MOV     _GLOBE_VARIES[11],A
                ;-KEY10 THRESHOLD                                                                                
                MOV     A,Key10Threshold                                                                         
                MOV     _GLOBE_VARIES[12],A
                ;-KEY11 THRESHOLD                                                                                
                MOV     A,Key11Threshold                                                                         
                MOV     _GLOBE_VARIES[13],A
                ;-KEY12 THRESHOLD                                                                                
                MOV     A,Key12Threshold                                                                         
                MOV     _GLOBE_VARIES[14],A
        ENDIF
        ;----------------------------------
        IFDEF   BS84C12A
                ;-TOUCH OR IO SETTING
                MOV     A,IO_TOUCH_ATTR&0FFH
                MOV     _KEY_IO_SEL[0],A
                MOV     A,(IO_TOUCH_ATTR>>8)&00FH
                MOV     _KEY_IO_SEL[1],A
                ;-KEY1 THRESHOLD                                                                                
                MOV     A,Key1Threshold                                                                         
                MOV     _GLOBE_VARIES[3],A                                                                      
                ;-KEY2 THRESHOLD                                                                                
                MOV     A,Key2Threshold                                                                         
                MOV     _GLOBE_VARIES[4],A                                                                      
                ;-KEY3 THRESHOLD                                                                                
                MOV     A,Key3Threshold                                                                         
                MOV     _GLOBE_VARIES[5],A                                                                      
                ;-KEY4 THRESHOLD                                                                                
                MOV     A,Key4Threshold                                                                         
                MOV     _GLOBE_VARIES[6],A  
                ;-KEY5 THRESHOLD                                                                                
                MOV     A,Key5Threshold                                                                         
                MOV     _GLOBE_VARIES[7],A                                                                      
                ;-KEY6 THRESHOLD                                                                                
                MOV     A,Key6Threshold                                                                         
                MOV     _GLOBE_VARIES[8],A                                                                      
                ;-KEY7 THRESHOLD                                                                                
                MOV     A,Key7Threshold                                                                         
                MOV     _GLOBE_VARIES[9],A                                                                      
                ;-KEY8 THRESHOLD                                                                                
                MOV     A,Key8Threshold                                                                         
                MOV     _GLOBE_VARIES[10],A
                ;-KEY9 THRESHOLD                                                                                
                MOV     A,Key9Threshold                                                                         
                MOV     _GLOBE_VARIES[11],A
                ;-KEY10 THRESHOLD                                                                                
                MOV     A,Key10Threshold                                                                         
                MOV     _GLOBE_VARIES[12],A
                ;-KEY11 THRESHOLD                                                                                
                MOV     A,Key11Threshold                                                                         
                MOV     _GLOBE_VARIES[13],A
                ;-KEY12 THRESHOLD                                                                                
                MOV     A,Key12Threshold                                                                         
                MOV     _GLOBE_VARIES[14],A
        ENDIF
        ;----------------------------------
        IFDEF   BS83B16A

                ;-TOUCH OR IO SETTING
                MOV     A,IO_TOUCH_ATTR&0FFH
                MOV     _KEY_IO_SEL[0],A
                MOV     A,(IO_TOUCH_ATTR>>8)&0FFH
                MOV     _KEY_IO_SEL[1],A

                ;-KEY1 THRESHOLD                                                                                
                MOV     A,Key1Threshold                                                                         
                MOV     _GLOBE_VARIES[3],A                                                                      
                ;-KEY2 THRESHOLD                                                                                
                MOV     A,Key2Threshold                                                                         
                MOV     _GLOBE_VARIES[4],A                                                                      
                ;-KEY3 THRESHOLD                                                                                
                MOV     A,Key3Threshold                                                                         
                MOV     _GLOBE_VARIES[5],A                                                                      
                ;-KEY4 THRESHOLD                                                                                
                MOV     A,Key4Threshold                                                                         
                MOV     _GLOBE_VARIES[6],A  
                ;-KEY5 THRESHOLD                                                                                
                MOV     A,Key5Threshold                                                                         
                MOV     _GLOBE_VARIES[7],A                                                                      
                ;-KEY6 THRESHOLD                                                                                
                MOV     A,Key6Threshold                                                                         
                MOV     _GLOBE_VARIES[8],A                                                                      
                ;-KEY7 THRESHOLD                                                                                
                MOV     A,Key7Threshold                                                                         
                MOV     _GLOBE_VARIES[9],A                                                                      
                ;-KEY8 THRESHOLD                                                                                
                MOV     A,Key8Threshold                                                                         
                MOV     _GLOBE_VARIES[10],A
                ;-KEY9 THRESHOLD                                                                                
                MOV     A,Key9Threshold                                                                         
                MOV     _GLOBE_VARIES[11],A
                ;-KEY10 THRESHOLD                                                                                
                MOV     A,Key10Threshold                                                                         
                MOV     _GLOBE_VARIES[12],A
                ;-KEY11 THRESHOLD                                                                                
                MOV     A,Key11Threshold                                                                         
                MOV     _GLOBE_VARIES[13],A
                ;-KEY12 THRESHOLD                                                                                
                MOV     A,Key12Threshold                                                                         
                MOV     _GLOBE_VARIES[14],A
                ;-KEY13 THRESHOLD                                                                                
                MOV     A,Key13Threshold                                                                         
                MOV     _GLOBE_VARIES[15],A
                ;-KEY14 THRESHOLD                                                                                
                MOV     A,Key14Threshold                                                                         
                MOV     _GLOBE_VARIES[16],A
                ;-KEY15 THRESHOLD                                                                                
                MOV     A,Key15Threshold                                                                         
                MOV     _GLOBE_VARIES[17],A
                ;-KEY16 THRESHOLD                                                                                
                MOV     A,Key16Threshold                                                                         
                MOV     _GLOBE_VARIES[18],A
        ENDIF
                
                                                                     
                RET                                                                                             
                                                                                                                 


                                                      
                END
                


