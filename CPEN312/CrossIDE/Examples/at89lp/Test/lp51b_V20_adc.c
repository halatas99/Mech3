#include <stdio.h>
#include <at89lp51rd2.h>

#define LCD_RS P3_7
#define LCD_E  P3_6

#define CLK 22118400L
#define BAUD 115200L
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))

// timer 0 used for systemclock
#define TIMER0_RELOAD_VALUE -CLK/12/1000 // 0.99938916ms for 22.1184Mhz

unsigned int timer_count;

static long data milliSeconds;
volatile unsigned int Timer0_count;
volatile unsigned int cnt;
volatile bit ISR_Timer0_flag;

void ClockIrqHandler (void) interrupt 1 using 1
{
	TL0 = TIMER0_RELOAD_VALUE&0xff;
	TH0 = TIMER0_RELOAD_VALUE>>8;
	cnt++;
	Timer0_count++;
	ISR_Timer0_flag=1;
}

void Set_ISR_Timer0_Count (unsigned int x)
{
    do {
        ISR_Timer0_flag=0;
        Timer0_count=x;
    } while (ISR_Timer0_flag);
}

unsigned int Get_ISR_Timer0_Count (void)
{
    volatile unsigned int x;
    do {
        ISR_Timer0_flag=0;
        x=Timer0_count;
    } while (ISR_Timer0_flag);
    return x;
}

void WaitXms (unsigned int x)
{ 
    Set_ISR_Timer0_Count(0);
    while (Get_ISR_Timer0_Count()< x) ; 
}

unsigned char _c51_external_startup(void)
{
	// Configure ports as a bidirectional with internal pull-ups.
	P0M0=0;	P0M1=0;
	P1M0=0;	P1M1=0;
	P2M0=0;	P2M1=0;
	P3M0=0;	P3M1=0;
	AUXR=0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	P4M0=0;	P4M1=0;

	setbaud_timer2(TIMER_2_RELOAD); // Initialize serial port using timer 2
	// initialize timer0 for system clock
	TR0=0; // stop timer 0
	TMOD =(TMOD&0xf0)|0x01; // T0=16bit timer
	// timeout is xtal/12
	TL0 = -TIMER0_RELOAD_VALUE&0xff;
	TH0 = -TIMER0_RELOAD_VALUE>>8;
	milliSeconds=0; // reset system time
	TR0=1; // start timer 0 (bit 4 in TCON)
	ET0=1; // enable timer 0 interrupt
	
	EA=1; // enable global interrupt
	
	return 0;
}

#define GO_BSY 0x40
#define DAC  0x20
#define ADCE 0x10
#define LADJ 0x08
#define ACK2 0x04
#define ACK1 0x02
#define ACK0 0x01
#define ACON 0x80
#define IREF 0x40
#define TRG1 0x20
#define TRG0 0x10
#define DIFF 0x08
#define ACS2 0x04
#define ACS1 0x02
#define ACS0 0x01

void main(void)
{
	int result;
	setbaud_timer2(TIMER_2_RELOAD); // Initialize serial port using timer 2

	printf("\n\nAT89LP51RB2 ADC test program.\n");
	
	// Configure P0.0 as Input Only (High Impedance)
	P0M0=0xff;
	P0M1=0x00;
	DADI=7; // Channel 7 selected
	DADI|=ACON; // Channel 0 enabled
	DADC=ADCE|ACK2|ACK1|ACK0;
	
	while(1)
	{
		DADC|=GO_BSY; // Start conversion
		while((DADC&GO_BSY)==GO_BSY); // Wait for conversion to complete
		result=((DADH+2)*0x100)+DADL;
		printf("V=%5.3f\r", 5.0*result/1023.0);
	}

}
