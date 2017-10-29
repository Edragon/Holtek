

#ifndef _KEY___H_
#define _KEY___H_

#include "stm32l1xx.h"
#include "sys.h"
#include "delay.h"

#define SDA			PAout(0)
#define SCL			PAout(1)
#define SDAIN			PAin(0)
#define SCLIN			PAin(1)
#define SDAPin			GPIO_Pin_0
#define SCLPin			GPIO_Pin_1

#define RETRY			10
#define SCLTIMEOUT		(u16)5000

#define KEY10			10
#define KEY11			11
#define NOKEY			0xFF
#define OK				1
#define ERR				0

#define DEVICEADDR		0xA0
#define KEYVALADDR		0x08
#define KEYREGADDR		0xB0

void Key_Init(void);
u16 GetKey(void);
u8 KeyRegSet(void);


#endif

