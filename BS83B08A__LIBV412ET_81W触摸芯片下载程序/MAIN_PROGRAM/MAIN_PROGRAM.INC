
;;***********************************            
;;***** MAIN_PROGRAM INCLUDE FILE   *            
;;***********************************    
;=-------------------------------
;=INCLUDE LIBRARY               - 
;=EXTERNAL REFERENCE FILE       -
;=-------------------------------

        ;-FUNCTION DEFINE               ;-FUNCTION NAME
INCLUDE "..\BS83B08A_LIBV412\BS83B08A_LIBV412.AEX"
#DEFINE EXTEND_FUNCTION_1A_INITIAL      _BS83B08A_LIBV412_INITIAL
#DEFINE EXTEND_FUNCTION_1A              _BS83B08A_LIBV412
           
;--
INCLUDE "..\USER_PROGRAM\USER_PROGRAM.AEX"
#DEFINE EXTEND_FUNCTION_1B_INITIAL      _USER_PROGRAM_INITIAL
#DEFINE EXTEND_FUNCTION_1B              _USER_PROGRAM
            
;--
;INCLUDE "..\IIC_SLAVE_TEST\IIC_SLAVE_TEST.AEX"
;#DEFINE EXTEND_FUNCTION_1C_INITIAL      _IIC_SLAVE_TEST_INITIAL
;#DEFINE EXTEND_FUNCTION_1C              _IIC_SLAVE_TEST




