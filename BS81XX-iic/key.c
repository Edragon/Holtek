
#include "key.h"

void BS81XXWait(void){
   delay_us(10);
}

void BS81XXI2CStart(void){  //��SCL�ߵ�ƽʱ��SDA�Ӹߵ�ƽ���䵽�͵�ƽΪ��ʼ����
	SCL = 0;
	BS81XXWait();
	SDA = 1;
	BS81XXWait();
	SCL = 1;
	BS81XXWait();
	SDA = 1;
	BS81XXWait();
	SDA = 0;
	BS81XXWait();
}

void BS81XXI2CStop(void){  //��SCL�ߵ�ƽʱ��SDA�ӵ͵�ƽ���䵽�ߵ�ƽΪֹͣ����
	SCL = 1;
	BS81XXWait();
	SDA = 0;
	BS81XXWait();
	SDA = 1;
	BS81XXWait();
}

u8 BS81XXWACK(void){  //�ȴ��ӻ�ACK,�ȴ�slave��sda����low
	u16 i=0;
	SCL = 0;
	BS81XXWait();
	SCL = 1;
	while( SDAIN == 1){
		if(i++ > 3000){
			return 1;  //��ʱ
		}
	}
	return 0;
}

void BS81XXACK(void){
	BS81XXWait();
	SCL = 0;
	BS81XXWait();
	SDA = 0;
	BS81XXWait();
	SCL = 1;
	BS81XXWait();
	SCL = 0;
	BS81XXWait();
	SDA = 1;
}

void BS81XXNoACK(void){  //NACK
	BS81XXWait();
	SCL = 0;
	BS81XXWait();
	SDA = 1;
	BS81XXWait();
	SCL = 1;
	BS81XXWait();
	SCL = 0;
	BS81XXWait();
	SDA = 1;
}

void BS81XXI2CSend(u8 dat){
    for(u8 i=0;i<8;i++)
    {
		SCL = 0;
		BS81XXWait();
		if((dat & 0x80)){
			SDA = 1;
		}else{
			SDA = 0;
		}
		BS81XXWait();
        dat = dat << 1;
		SCL = 1;
		BS81XXWait();
    }
}


u8 BS81XXI2CRec(void){
	u8 i,k= 0;
	BS81XXWait();
	for(i=8;i>0;i--)
	{
		BS81XXWait();
		SCL = 0;
		BS81XXWait();
		SCL = 1;
		BS81XXWait();
		k = (k<<1) | SDAIN;
	}
	return k;
}	


void Key_Init(void){
	GPIO_InitTypeDef GPIO_InitStructure;
	RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA,ENABLE);
	GPIO_InitStructure.GPIO_Pin = SDAPin | SCLPin;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
	GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
	GPIO_Init(GPIOA,&GPIO_InitStructure);
	SDA = 1;
	SCL = 1;
	delay_ms(100);
	if(KeyRegSet()) {
		;//key�Ĵ���д����󣬱���
	}
	delay_ms(1000);
}



typedef struct{
	u8 statustmp;
	u16 status;
}keystruct;


u8 KeyValue(keystruct * key){
	if(key->status != 0){
		switch(key->status){
			case 0x0001:
				return 6;
			case 0x0002:
				return 3;
			case 0x0004:
				return KEY10;
			case 0x0008:
				return 7;
			case 0x0010:
				return 4;
			case 0x0020:
				return 1;
			case 0x0040:
				return 0;
			case 0x0080:
				return 8;
			case 0x0100:
				return 5;
			case 0x0200:
				return 2;
			case 0x0400:
				return KEY11;
			case 0x0800:
				return 9;
			default:return NOKEY;
		}
	}else{
		return NOKEY;
	}
}


u16 GetKey(void){
	u8 t = RETRY;
	u16 r;
	keystruct key;
	while(t--){
		BS81XXI2CStart();
		BS81XXI2CSend(DEVICEADDR); //д
		if(BS81XXWACK()) continue; //��ʱSCL���ӻ����ͣ��ȴ��ߵ�ƽ�ټ���
		BS81XXWait();
		r = SCLTIMEOUT;
		while( (SCLIN == 0) && r--);
		BS81XXI2CSend(KEYVALADDR); //��ȡ
		if(BS81XXWACK()) continue;
		BS81XXWait();
		r = SCLTIMEOUT;
		while( (SCLIN == 0) && r--);
		BS81XXI2CStart();
		BS81XXI2CSend(DEVICEADDR+1); //��ȡ
		if(BS81XXWACK()) continue;
		BS81XXWait();
		r = SCLTIMEOUT;
		while( (SCLIN == 0) && r--);
		key.status = BS81XXI2CRec();
		BS81XXACK();
		key.statustmp = BS81XXI2CRec();
		key.status = (key.statustmp*256 + key.status);
		BS81XXNoACK();
		BS81XXI2CStop();
		return KeyValue(&key);
	}
	return NOKEY;
}

const u8 keyregvaluetable[] = {0x00,0x00,0x83,0xF3,0xD8,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A,0x0A};

u8 KeyRegSet(void){
	u8 t = RETRY, result = OK;
	u16 r;
	u8 checksum = 0;
	while(t--){
		BS81XXI2CStart();
		BS81XXI2CSend(DEVICEADDR); //д����
		if(BS81XXWACK()) continue; //��ʱSCL���ӻ����ͣ��ȴ��ߵ�ƽ�ټ���
		BS81XXWait();
		r = SCLTIMEOUT;
		while( (SCLIN == 0) && r--);
		BS81XXI2CSend(KEYREGADDR); //���üĴ���
		if(BS81XXWACK()) continue;
		BS81XXWait();
		for(u8 count=0; count<17; count++){
			BS81XXI2CSend(keyregvaluetable[count]); //���üĴ���
			checksum += keyregvaluetable[count];
			if(BS81XXWACK()){
				result = ERR;
				break;
			}
		}
		if(result == ERR){
			continue;
		}
		BS81XXI2CSend(checksum); //���üĴ���
		BS81XXNoACK();
		BS81XXI2CStop();
		return 0;
	}
	return 1;
}
