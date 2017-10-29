
                #include    "..\HXT_REFERENCE.H"
                #include    "..\MAIN_PROGRAM\MAIN_PROGRAM.H" 
                  
   

volatile unsigned	char	_key_val_buf[2];
//volatile unsigned char  f_125us_flag;

//#pragma vector tmr_isr @0x0c
//void tmr_isr(void)
//{
//	f_125us_flag++;
//}
//***********************************************************                           
//*SUB. NAME: IIC ISR                                       *                           
//*INPUT    :                                               *                           
//*OUTPUT   :                                               *                           
//*USED REG.:                                               *                           
//*FUNCTION :                                               *                           
//***********************************************************
#pragma vector  iic_isr        @ 0x10
void iic_isr(void)
{
	if(_haas)
	{										//_haas=1,address match trig interrupt
		if(_srw)
		{									//srw=1:slave in transfer mode	
			_htx = 1;
			_simd = _key_val_buf[0];	
		}
		else
		{									//srw=0:slave in receive mode
			_htx = 0;
			_txak = 0;
			_acc = _simd;					//dummy read from simd to release scl line
		} 
	}
	else
	{										//_haas=0,data trig interrupt
		if(_htx)
		{									//htx=1:slave in write state;
			if(_rxak)
			{								//rxak=1:master stop receiving next byte,master releases scl bus
				_htx = 0;
				_txak = 0;	
				_acc = _simd;				//dummy read from simd to release scl line
			}
			else
			{								//rxak=0:master wants to receive next byte;	
				_simd = _key_val_buf[1];
			}			
		}
		else
		{									//htx=0:slave in read state
			_acc = _simd;
			_txak = 0;	
		}		
	}
	_simf = 0;								//clr i2c interrupt flag 
}


//***********************************************************                           
//*SUB. NAME:                                               *                           
//*INPUT    :                                               *                           
//*OUTPUT   :                                               *                           
//*USED REG.:                                               *                           
//*FUNCTION :                                               *                           
//***********************************************************
void USER_PROGRAM_INITIAL()
{
	//IO initial or Varies Initial   
   //_pdc=0;  
   _pac1 = 0;  
   _papu1 = 0;
   _pa1 = 0;
   //_pec=0;    
   //_pfc=0;       
	_pac0=1;
	_pac2=1;
	_papu0 = 0;
	_papu2 = 0;
	_simc0=0b11000010;
	_sima =0b01110100;
	_i2ctoen=0;
	
	_simf=0;
	_sime=1;
	_key_val_buf[0]=0x00;
	_key_val_buf[1]=0x00;
	/*tmr init*/
//	_tmr = 255-124;
//	_tmrc = 0b00010011;
//	_te = 1;
}



//***********************************************************                           
//*SUB. NAME:                                               *                           
//*INPUT    :                                               *                           
//*OUTPUT   :                                               *                           
//*USED REG.:                                               *                           
//*FUNCTION :                                               *                           
//***********************************************************
void USER_PROGRAM()
{
 	GET_KEY_BITMAP();	 
  	// get key
  	_key_val_buf[0] = DATA_BUF[0];
  	_key_val_buf[1]=~_key_val_buf[0];
  	if(_key_val_buf[0] == 0x01)
  	{
  		_pa1 = 1;
  	}
  	else
  	{
  		_pa1 = 0;
  	}
}





