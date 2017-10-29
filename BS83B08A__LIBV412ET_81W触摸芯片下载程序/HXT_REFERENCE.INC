
;;***************************************
;;***** HXT ERERENCE DEFINE FOR ASM CODE*
;;***************************************
#DEFINE V412
;-SELECT IC BODY & INCLUDE REFERENCE FILE
#DEFINE BS83B08A
INCLUDE BS83B08A-3.INC

;------------------------
;-DEFINE SYSTEM CLOCK   -
;------------------------
#define SystemClock             0       ;0=8MHZ
                                        ;1=12MHZ
                                        ;2=16MHZ

 
;--------------------------------
;-TOUCH KEY LIBRARY VARIES DEFINE
;--------------------------------
;-numeric operate ; range 0 ~ 15; function: Touch key debounce to stable
#define KeyDebounce             1      ; 

;-numeric operate ; range 0 ~ 15; function: Reference value update time base on 62.5ms
#define CalibrateTime           7     ;                              

;-numeric operate ; range 0 ~ 3 ; function: Touch sensor sampling window & count by internal REF. OSC.
#define SamplingTime            3       ;0=256 ; 1=512 ; 2=1024; 3=2048                       
        
;-numeric operate ; range 0 ~ 15; function: key holding time ,if time out will reset key status to non-press
#define MaximumOnTime           15       ;0=disable ; 1=4 secend ...... 15=60secend 

;-bit operate ; range 0/1       ; function : sampling speed control                           
#define SampleSpeed             1       ;0=Normal ; 1=Fast sampling speed

;-bit operate ; range 0/1       ; function: Auto Change internal Resistor for diferent FREQ.
#define AutoRSelect             1       ;0=disable ; 1=enable

;-bit operate ; range 0/1       ; function: only one or all key active at the same time
#define OneKeyActive            0       ;0=disable ; 1=enable

;-bit operate ; range 0/1       ; function:power save selection                          
#define PowerSave               0    ;0=disable ; 1=enable
 
;-bit operate ; range 0/1       ;                                                             
#define CSprotect               0       ;0=disable ; 1=enable

;-bit operate ; range 0/1       ; function : reference update when press                      
#define ActiveLogic             1       ;0=disable ; 1=enable

;-bit operate ; range 0/1       ;                                                             
#define ReserveOptionB          0       ;no use
;-bit operate ; range 0/1       ;                                                             
#define ReserveOptionA          0       ;no use


  
;-Key threshold define 
#define Key1Threshold           10    ;range 8 ~ 255
#define Key2Threshold           10
#define Key3Threshold           10
#define Key4Threshold           10
;--
#define Key5Threshold           10
#define Key6Threshold           10
#define Key7Threshold           10
#define Key8Threshold           10



;---------------------------------
;-DEFINE PIN AS I/O OR TOUCH INPUT
;---------------------------------
#define IO_TOUCH_ATTR           00000000000000000000000000011111B;0=IO ; 1=TOUCH INPUT
                           ;KEY 3   ~   2 ~ 2 ~ 1 ~ 1 ~ 0 ~ 0 ~0 ;KEY32~KEY1
                           ;    2       4   0   6   2   8   4  1

;-----------------------------------------
;-conbine above varies in GlobeOptionA/B/C
;-----------------------------------------
#define GlobeOptionA            (CalibrateTime<<4)|KeyDebounce                                                  
#define GlobeOptionB            (MaximumOnTime<<4)|SamplingTime                                                 
#define GlobeOptionC            (ActiveLogic<<7)|(PowerSave<<6)|(OneKeyActive<<5)|(CSprotect<<4)|(AutoRSelect<<3)|(SampleSpeed<<2)|(ReserveOptionB<<1)|(ReserveOptionA)




;------------------
;-UART TEST DEFINE
;------------------
;#define _UART_TX_C      PAC.3   ;Define PXX as TX output 
;#define _UART_TX        PA.3    ;                                                         
;#define BAUDRATE_OPTION 0       ;0=38400
                                ;1=57600
                                ;2=115200


                            
